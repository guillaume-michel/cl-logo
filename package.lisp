(uiop:define-package :cl-logo
    (:nicknames :logo)
  (:use :cl
        :cl-logo.core
        :cl-logo.backend
        :cl-logo.logo)
  (:reexport
   :cl-logo.core
   :cl-logo.backend
   :cl-logo.logo)
  (:export
   #:*version*))
