(in-package :cl-logo)

(defparameter *backend* nil)

(defgeneric draw-line (backend x1 y1 x2 y2)
  (:documentation "Draw a line from (x1, y1) to (x2, y2) into the given backend"))

(defclass text-backend ()
  ())

(defmethod draw-line ((backend text-backend) x1 y1 x2 y2)
  (declare (ignore backend))
  (format t "draw line from (~D, ~D) to (~D, ~D)~%" x1 y1 x2 y2))

(defun set-text-backend-as-default ()
  (setf *backend* (make-instance 'text-backend)))

(eval-when (::load-toplevel)
  (set-text-backend-as-default))
