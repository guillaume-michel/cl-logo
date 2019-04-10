(in-package :cl-logo.core)

(defcmd up (length)
  (face-up)
  (forward length))

(defcmd down (length)
  (face-down)
  (forward length))

(defcmd left (length)
  (face-left)
  (forward length))

(defcmd right (length)
  (face-right)
  (forward length))
