(in-package :cl-logo.backend.null)

(defclass null-backend ()
  ())

(defmethod draw-line ((backend null-backend) x1 y1 x2 y2)
  (declare (ignore backend x1 y1 x2 y2)))

(defun set-null-backend-as-default ()
  (setf *backend* (make-instance 'null-backend)))

(eval-when (::load-toplevel)
  (set-null-backend-as-default))
