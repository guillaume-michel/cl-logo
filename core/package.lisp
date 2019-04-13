(uiop:define-package :cl-logo.core
    (:use :cl)
  (:import-from :cl-logo.backend
                #:*backend*
                #:reset-backend
                #:draw-line
                #:transaction-count
                #:with-transactional-backend
                #:delete-last-transaction
                )
  (:export
   #:*turtle*
   #:get-state
   #:show-program
   #:undo
   #:reset
   #:defcmd
   #:forward
   #:rotate
   #:penup
   #:pendown
   #:backward
   #:face-up
   #:face-down
   #:face-left
   #:face-right
   #:move-to
   #:current-pos
   #:up
   #:down
   #:left
   #:right
   ))
