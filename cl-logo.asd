(defsystem "cl-logo"
  :description "Logo implemented in Common LISP"
  :version "0.0.1"
  :author "Guillaume MICHEL"
  :mailto "contact@orilla.fr"
  :homepage "http://www.orilla.fr"
  :license "MIT License (see COPYING)"
  :depends-on ()
  :components ((:static-file "COPYING")
               (:static-file "README.org")
               (:module "src"
                        :serial t
                        :components ((:file "package")
                                     (:file "drawing")
                                     (:file "turtle")
                                     (:file "logo"))))
  :in-order-to ((test-op (test-op "cl-logo-tests"))))
