;;;; --------------- TEXT backend ---------------------------------
(uiop:define-package :cl-logo.backend.text
    (:use :cl
          :cl-logo.backend)
  (:export #:init
           #:shutdown
           #:draw-line
           #:commit
           #:delete-last-transaction
           #:set-text-backend-as-default))
