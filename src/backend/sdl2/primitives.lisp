(in-package :cl-logo-backend-sdl2)

(defclass sdl2-backend ()
  ())

(defmethod draw-line ((backend sdl2-backend) x1 y1 x2 y2)
  (declare (ignore backend))
  (format t "SDL2: draw line from (~D, ~D) to (~D, ~D)~%" x1 y1 x2 y2))

(defun set-sdl2-backend-as-default ()
  (setf *backend* (make-instance 'sdl2-backend)))

(eval-when (::load-toplevel)
  (set-sdl2-backend-as-default))
