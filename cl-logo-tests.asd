(defsystem "cl-logo-tests"
  :description "cl-logo unit tests"
  :author "Guillaume MICHEL"
  :mailto "contact@orilla.fr"
  :homepage "http://www.orilla.fr"
  :license "MIT License (see COPYING)"
  :depends-on ("cl-logo"
               "fiveam")
  :perform (test-op (o s) (symbol-call :cl-logo-tests '#:run-tests))
  :components ((:module "t"
                :serial t
                :components ((:file "package")
                             (:file "tests")))))
