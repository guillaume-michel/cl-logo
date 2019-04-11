(in-package :cl-logo.backend)

(defparameter *backend* nil)

(defgeneric init (backend)
  (:documentation "Initialization function for the backend"))

(defgeneric shutdown (backend)
  (:documentation "Shutdown function for the backend"))

(defgeneric update (backend)
  (:documentation "Update the backend")
  (:method (backend)))

(defgeneric reset-backend (backend)
  (:documentation "Reset the backend")
  (:method (backend)))

(defgeneric draw-line (backend x1 y1 x2 y2)
  (:documentation "Draw a line from (x1, y1) to (x2, y2) into the given backend"))
