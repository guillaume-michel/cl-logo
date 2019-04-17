(in-package :cl-logo.app)

(defun start(&key (width 600)
                  (height 600)
                  (bg-color '(255 255 255)))
  (set-sdl2-backend-as-default :width width
                               :height height
                               :bg-color bg-color)
  (init *backend*)
  (reset))

(defun stop ()
  (reset)
  (shutdown *backend*))
