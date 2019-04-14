(in-package :cl-logo.backend)

(defparameter *backend* nil)

(defgeneric init (backend)
  (:documentation "Initialization function for the backend"))

(defgeneric shutdown (backend)
  (:documentation "Shutdown function for the backend"))

(defgeneric reset-backend (backend)
  (:documentation "Reset the backend"))

(defgeneric draw-line (backend x1 y1 x2 y2 color width)
  (:documentation "Draw a line from (x1, y1) to (x2, y2)
with given color and width into the given backend"))
