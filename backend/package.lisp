;;;; --------------- backend API ---------------------------------
(uiop:define-package :cl-logo.backend
    (:use :cl)
  (:export
   ;; api
   #:*backend*
   #:init
   #:shutdown
   #:reset-backend
   #:draw-line

   ;; transactional-backend
   #:transactional-backend
   #:transaction-commands
   #:transaction-count
   #:start-transaction
   #:end-transaction
   #:commit
   #:delete-last-transaction
   #:with-transactional-backend
   ))
