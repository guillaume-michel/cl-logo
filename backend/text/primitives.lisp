(in-package :cl-logo.backend.text)

(defclass text-backend (transactional-backend)
  ())

(defmethod init ((backend text-backend)))

(defmethod shutdown ((backend text-backend)))

(defmethod draw-line ((backend text-backend) x1 y1 x2 y2)
  (declare (ignore backend))
  (format t "draw line from (~D, ~D) to (~D, ~D)~%" x1 y1 x2 y2))

(defun run-commands (cmds)
  (cond ((null cmds) nil)
        ((functionp cmds) (funcall cmds))
        ((consp cmds)
         (run-commands (cdr cmds))
         (run-commands (car cmds)))
        (t (error "cl-logo.backend.text:run-commands expects FUNCTION or LIST but got ~A~%"
                  (type-of cmds)))))

(defmethod commit ((backend text-backend))
  (when (= (transaction-count backend) 0)
    (when (not (null (transaction-commands backend)))
      (run-commands (reverse (transaction-commands backend)))
      (setf (transaction-commands backend) nil))))

(defmethod delete-last-transaction ((backend text-backend)))

(defun set-text-backend-as-default ()
  (setf *backend* (make-instance 'text-backend)))

(eval-when (::load-toplevel)
  (set-text-backend-as-default))
