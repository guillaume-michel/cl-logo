(uiop:define-package :cl-logo-core
  (:use :cl)
  (:export
   #:*backend*
   #:draw-line
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

(uiop:define-package :cl-logo-backend-text
    (:use :cl
          :cl-logo-core)
  (:export #:draw-line
           #:set-text-backend-as-default))

(uiop:define-package :cl-logo-backend-sdl2
    (:use :cl
          :cl-logo-core)
  (:export #:draw-line
           #:set-sdl2-backend-as-default))

(uiop:define-package :cl-logo
  (:nicknames :logo)
  (:use :cl
        :cl-logo-core
        :cl-logo-backend-text)
  (:reexport
   :cl-logo-core
   :cl-logo-backend-text))
