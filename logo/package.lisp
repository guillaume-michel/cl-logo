(uiop:define-package :cl-logo.logo
    (:use :cl
          :cl-logo.core
          :cl-logo.backend)
  (:export
   #:show-program
   #:reset
   #:undo

   #:defcmd

   #:forward
   #:rotate
   #:penup
   #:pendown
   #:penwidth
   #:pencolor
   #:backward
   #:face-up
   #:face-down
   #:face-left
   #:face-right
   #:move-to
   #:up
   #:down
   #:left
   #:right
   #:current-pos
   ))
