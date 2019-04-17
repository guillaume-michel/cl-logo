(uiop:define-package :cl-logo.core
    (:use :cl)
  (:export
   #:copy-object

   #:radians
   #:precise-cos
   #:precise-sin

   #:pen
   #:pen-color
   #:pen-width
   #:pen-state

   #:*turtle*
   #:turtle-x
   #:turtle-y
   #:turtle-theta
   #:turtle-pen
   #:turtle-visibility
   #:reset-turtle

   #:get-state
   ))
