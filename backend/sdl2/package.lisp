;;;; --------------- SDL2+CAIRO2 backend --------------------------
(uiop:define-package :cl-logo.backend.sdl2
    (:use :cl
          :cl-logo.backend)
  (:export #:draw-line
           #:set-sdl2-backend-as-default))
