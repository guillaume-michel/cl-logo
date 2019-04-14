(in-package :cl-logo.examples)

(defcmd robot-stairs ()
  "Adam first drawing with my help"

  (penwidth 10)

  (pencolor 204 255 255)
  (move-to 100 100)
  (robot 100 100)

  (pencolor 0 153 153)
  (move-to 200 200)
  (robot 100 100)

  (pencolor 255 102 0)
  (move-to 300 300)
  (robot 100 100)

  (pencolor 255 0 255)
  (move-to 400 400)
  (robot 100 100)

  (pencolor 255 0 0)
  (move-to 500 500)
  (robot 100 100)

  (pencolor 102 255 102)
  (move-to 600 600)
  (robot 100 100))
