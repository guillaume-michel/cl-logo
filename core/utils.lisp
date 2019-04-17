(in-package :cl-logo.core)

(defun get-state()
  "utility function for tests"
  (list (turtle-x *turtle*)
        (turtle-y *turtle*)
        (turtle-theta *turtle*)
        (pen-color (turtle-pen *turtle*))
        (pen-width (turtle-pen *turtle*))
        (pen-state (turtle-pen *turtle*))))
