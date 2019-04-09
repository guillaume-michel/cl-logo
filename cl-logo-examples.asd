(defsystem "cl-logo-examples"
  :description "cl-logo examples"
  :author "Guillaume MICHEL"
  :mailto "contact@orilla.fr"
  :homepage "http://www.orilla.fr"
  :license "MIT License (see COPYING)"
  :depends-on ("cl-logo"
               "cl-logo/backend/text")
  :components ((:module "examples"
                :serial t
                :components ((:file "package")
                             (:file "geometry")
                             (:file "robot")))))
