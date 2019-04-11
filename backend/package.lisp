;;;; --------------- backend API ---------------------------------
(uiop:define-package :cl-logo.backend
    (:use :cl)
  (:export
   #:*backend*
   #:transaction
   #:transaction-commands
   #:transaction-count
   #:start-transaction
   #:end-transaction
   #:with-transaction
   #:reset-transaction
   #:init
   #:shutdown
   #:update
   #:reset-backend
   #:draw-line
   ))
