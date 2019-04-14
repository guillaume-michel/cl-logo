(uiop:define-package :cl-logo.app
    (:use :cl
          :cl-logo
          :cl-logo.examples
          :cl-logo.backend.sdl2)
  (:export
   #:start
   #:stop
   ))
