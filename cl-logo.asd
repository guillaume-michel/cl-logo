(defsystem "cl-logo"
  :description "Logo implemented in Common LISP"
  :version "0.0.1"
  :author "Guillaume MICHEL"
  :mailto "contact@orilla.fr"
  :homepage "http://www.orilla.fr"
  :license "MIT License (see COPYING)"
  :depends-on ("uiop"
               "cl-logo/core"
               "cl-logo/backend/text")
  :components ((:static-file "COPYING")
               (:static-file "README.org"))
  :in-order-to ((test-op (test-op "cl-logo-tests"))))

(defsystem "cl-logo/core"
  :description "Logo implemented in Common LISP - Core functionalities"
  :version "0.0.1"
  :author "Guillaume MICHEL"
  :mailto "contact@orilla.fr"
  :homepage "http://www.orilla.fr"
  :license "MIT License (see COPYING)"
  :depends-on ("uiop")
  :components ((:module "src"
                        :serial t
                        :components ((:file "package")
                                     (:file "backend")
                                     (:file "turtle")
                                     (:file "logo")))))

(defsystem "cl-logo/backend/text"
  :description "Logo implemented in Common LISP - text console backend"
  :version "0.0.1"
  :author "Guillaume MICHEL"
  :mailto "contact@orilla.fr"
  :homepage "http://www.orilla.fr"
  :license "MIT License (see COPYING)"
  :depends-on ("uiop"
               "cl-logo/core")
  :components ((:module "src/backend/text"
                        :serial t
                        :components ((:file "primitives")))))
