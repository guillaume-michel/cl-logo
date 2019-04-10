;;;; --------------- NULL backend ---------------------------------
(uiop:define-package :cl-logo.backend.null
    (:use :cl
          :cl-logo.backend)
  (:export #:init
           #:shutdown
           #:draw-line
           #:set-null-backend-as-default))
