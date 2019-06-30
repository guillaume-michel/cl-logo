(uiop:define-package :cl-logo
    (:nicknames :logo)
  (:use :cl
        :cl-logo.core
        :cl-logo.backend
        :cl-logo.logo
        :cl-logo.logo.fr)
  (:reexport
   :cl-logo.core
   :cl-logo.backend
   :cl-logo.logo
   :cl-logo.logo.fr)
  (:export
   #:*version*))
