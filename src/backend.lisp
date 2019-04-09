(in-package :cl-logo-core)

(defparameter *backend* nil)

(defgeneric draw-line (backend x1 y1 x2 y2)
  (:documentation "Draw a line from (x1, y1) to (x2, y2) into the given backend"))
