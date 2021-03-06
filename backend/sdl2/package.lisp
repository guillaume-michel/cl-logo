;;;; --------------- SDL2 + CAIRO backend --------------------------
(uiop:define-package :cl-logo.backend.sdl2
    (:use :cl
          :cl-logo.backend
          :cl-logo.core)
  (:export #:sdl2-backend
           #:init
           #:shutdown
           #:reset-backend
           #:draw-line
           #:commit
           #:set-sdl2-backend-as-default
           #:with-sdl2-backend
           #:show-grid
           #:hide-grid
           ))
