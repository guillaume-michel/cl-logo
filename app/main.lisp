(in-package :cl-logo.app)

(defun start(&key (width 512)
                  (height 512)
                  (bg-color '(255 255 255)))
  (set-sdl2-backend-as-default :width width
                               :height height
                               :bg-color bg-color)
  (init *backend*)
  (reset))

(defun stop ()
  (reset)
  (shutdown *backend*))
