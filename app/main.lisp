(in-package :cl-logo.app)

(defun start()
  (init *backend*)
  (reset))

(defun stop ()
  (reset)
  (shutdown *backend*))
