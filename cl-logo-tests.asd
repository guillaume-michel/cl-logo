;;;; cl-logo-tests.asd

(asdf:defsystem #:cl-logo-tests
  :description "cl-logo unit tests"
  :author "Guillaume MICHEL <guillaume.michel@orilla.fr>"
  :homepage "http://www.orilla.fr"
  :license "MIT license"
  :depends-on (#:cl-logo
               #:fiveam)
  :components ((:module "t"
                :serial t
                :components ((:file "package")
                             (:file "tests")))))
