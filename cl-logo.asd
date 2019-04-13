(defsystem "cl-logo"
  :description "Logo implemented in Common LISP"
  :version (:read-file-form "version.lisp" :at (1 2))
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
               (:file "package")
               (:file "version"))
  :in-order-to ((test-op (test-op "cl-logo-tests"))))

(defsystem "cl-logo/core"
  :description "Logo implemented in Common LISP - Core functionalities"
  :version (:read-file-form "version.lisp" :at (1 2))
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
  :version (:read-file-form "version.lisp" :at (1 2))
  :author "Guillaume MICHEL"
  :mailto "contact@orilla.fr"
  :homepage "http://www.orilla.fr"
  :license "MIT License (see COPYING)"
  :depends-on ("uiop")
  :components ((:module "backend"
                        :serial t
                        :components ((:file "package")
                                     (:file "api")
                                     (:file "transactional-backend")))))

(defsystem "cl-logo/backend/null"
  :description "Logo implemented in Common LISP - null backend"
  :version (:read-file-form "version.lisp" :at (1 2))
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
  :version (:read-file-form "version.lisp" :at (1 2))
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
  :version (:read-file-form "version.lisp" :at (1 2))
  :author "Guillaume MICHEL"
  :mailto "contact@orilla.fr"
  :homepage "http://www.orilla.fr"
  :license "MIT License (see COPYING)"
  :depends-on ("uiop"
               "cl-logo/backend"
               "sdl2"
               "cl-opengl"
               "cl-cairo2"
               "bordeaux-threads"
               "cl-autowrap")
  :components ((:module "backend/sdl2"
                        :serial t
                        :components ((:file "package")
                                     (:file "primitives")))))

(defsystem "cl-logo/app"
  :description "Logo implemented in Common LISP - Application"
  :version (:read-file-form "version.lisp" :at (1 2))
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
