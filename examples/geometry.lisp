(in-package :cl-logo.examples)

(defcmd rectangle (w h)
  (up h)
  (right w)
  (down h)
  (left w))

(defcmd square (length)
  (rectangle length length))
