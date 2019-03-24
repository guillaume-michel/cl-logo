;;;; cl-logo.asd

(asdf:defsystem #:cl-logo
  :description "Logo implemented in Common LISP"
  :version "0.0.1"
  :author "Guillaume MICHEL <guillaume.michel@orilla.fr>"
  :homepage "http://www.orilla.fr"
  :license "MIT License"
  :depends-on (#:sdl2 #:bordeaux-threads)
  :components ((:static-file "COPYING")
               (:static-file "README.org")
               (:module "src"
                        :serial t
                        :components ((:file "package")
                                     (:file "drawing")
                                     (:file "logo")
                                     (:file "main"))))
  :in-order-to ((asdf:test-op (asdf:test-op "cl-logo-tests"))))

(defmethod asdf:perform ((o asdf:test-op)
                         (c (eql (asdf:find-system '#:cl-logo))))
  (asdf:oos 'asdf:load-op '#:cl-logo-tests)
  (funcall (intern (symbol-name '#:run-tests) (find-package '#:cl-logo-tests))))
