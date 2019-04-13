;;;; --------------- NULL backend ---------------------------------
(uiop:define-package :cl-logo.backend.null
    (:use :cl
          :cl-logo.backend)
  (:export #:init
           #:shutdown
           #:draw-line
           #:commit
           #:delete-last-transaction
           #:set-null-backend-as-default))
