(in-package :cl-logo.backend.text)

(defclass text-backend ()
  ())

(defmethod init ((backend text-backend)))

(defmethod shutdown ((backend text-backend)))

(defmethod draw-line ((backend text-backend) x1 y1 x2 y2)
  (declare (ignore backend))
  (format t "draw line from (~D, ~D) to (~D, ~D)~%" x1 y1 x2 y2))

(defun set-text-backend-as-default ()
  (setf *backend* (make-instance 'text-backend)))

(eval-when (::load-toplevel)
  (set-text-backend-as-default))
