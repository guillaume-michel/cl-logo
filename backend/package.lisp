;;;; --------------- backend API ---------------------------------
(uiop:define-package :cl-logo.backend
    (:use :cl)
  (:export
   #:*backend*
   #:init
   #:shutdown
   #:draw-line
   ))
