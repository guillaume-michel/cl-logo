(defsystem "cl-logo"
  :description "Logo implemented in Common LISP"
  :version "0.0.1"
  :author "Guillaume MICHEL"
  :mailto "contact@orilla.fr"
  :homepage "http://www.orilla.fr"
  :license "MIT License (see COPYING)"
  :depends-on ("uiop"
               "cl-logo/core"
               "cl-logo/backend")
  :serial t
  :components ((:static-file "COPYING")
               (:static-file "README.org")
               (:file "package"))
  :in-order-to ((test-op (test-op "cl-logo-tests"))))

(defsystem "cl-logo/core"
  :description "Logo implemented in Common LISP - Core functionalities"
  :version "0.0.1"
  :author "Guillaume MICHEL"
  :mailto "contact@orilla.fr"
  :homepage "http://www.orilla.fr"
  :license "MIT License (see COPYING)"
  :depends-on ("uiop"
               "cl-logo/backend")
  :components ((:module "core"
                        :serial t
                        :components ((:file "package")
                                     (:file "turtle")
                                     (:file "logo")))))

(defsystem "cl-logo/backend"
  :description "Logo implemented in Common LISP - backend API"
  :version "0.0.1"
  :author "Guillaume MICHEL"
  :mailto "contact@orilla.fr"
  :homepage "http://www.orilla.fr"
  :license "MIT License (see COPYING)"
  :depends-on ("uiop")
  :components ((:module "backend"
                        :serial t
                        :components ((:file "package")
                                     (:file "api")))))

(defsystem "cl-logo/backend/null"
  :description "Logo implemented in Common LISP - null backend"
  :version "0.0.1"
  :author "Guillaume MICHEL"
  :mailto "contact@orilla.fr"
  :homepage "http://www.orilla.fr"
  :license "MIT License (see COPYING)"
  :depends-on ("uiop"
               "cl-logo/backend")
  :components ((:module "backend/null"
                        :serial t
                        :components ((:file "package")
                                     (:file "primitives")))))

(defsystem "cl-logo/backend/text"
  :description "Logo implemented in Common LISP - text console backend"
  :version "0.0.1"
  :author "Guillaume MICHEL"
  :mailto "contact@orilla.fr"
  :homepage "http://www.orilla.fr"
  :license "MIT License (see COPYING)"
  :depends-on ("uiop"
               "cl-logo/backend")
  :components ((:module "backend/text"
                        :serial t
                        :components ((:file "package")
                                     (:file "primitives")))))

(defsystem "cl-logo/backend/sdl2"
  :description "Logo implemented in Common LISP - SDL2 + Cairo2 backend"
  :version "0.0.1"
  :author "Guillaume MICHEL"
  :mailto "contact@orilla.fr"
  :homepage "http://www.orilla.fr"
  :license "MIT License (see COPYING)"
  :depends-on ("uiop"
               "cl-logo/backend")
  :components ((:module "backend/sdl2"
                        :serial t
                        :components ((:file "package")
                                     (:file "primitives")))))

(defsystem "cl-logo/app"
  :description "Logo implemented in Common LISP - Application"
  :version "0.0.1"
  :author "Guillaume MICHEL"
  :mailto "contact@orilla.fr"
  :homepage "http://www.orilla.fr"
  :license "MIT License (see COPYING)"
  :depends-on ("uiop"
               "cl-logo"
               "cl-logo/backend/sdl2")
  :components ((:module "app"
                        :serial t
                        :components ((:file "package")
                                     (:file "main")))))
