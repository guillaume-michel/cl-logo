(uiop:define-package :cl-logo
    (:nicknames :logo)
  (:use :cl
        :cl-logo.core
        :cl-logo.backend)
  (:reexport
   :cl-logo.core
   :cl-logo.backend))
