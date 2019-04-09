;;;; --------------- TEXT backend ---------------------------------
(uiop:define-package :cl-logo.backend.text
    (:use :cl
          :cl-logo.backend)
  (:export #:draw-line
           #:set-text-backend-as-default))
