;;;; --------------- NULL backend ---------------------------------
(uiop:define-package :cl-logo.backend.null
    (:use :cl
          :cl-logo.backend)
  (:export #:draw-line
           #:set-null-backend-as-default))
