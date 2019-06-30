(in-package :cl-logo.logo.fr)

;; French command translations

(defcmd recommencer ()
  (reset))

(defcmd annuler ()
  (undo))

(defcmd avancer (distance)
  (forward distance))

(defcmd tourner (angle)
  (rotate angle))

(defcmd lever-stylo ()
  (penup))

(defcmd baisser-stylo ()
  (pendown))

(defcmd largeur-stylo (largeur)
  (penwidth largeur))

(defcmd couleur-stylo (r v b)
  (pencolor r v b))

(defcmd reculer (distance)
  (backward distance))

(defcmd tourner-haut ()
  (face-up))

(defcmd tourner-bas ()
  (face-down))

(defcmd tourner-gauche ()
  (face-left))

(defcmd tourner-droite ()
  (face-right))

(defcmd deplacer-a (x y)
  (move-to x y))

(defcmd haut (distance)
  (up distance))

(defcmd bas (distance)
  (down distance))

(defcmd gauche (distance)
  (left distance))

(defcmd droite (distance)
  (right distance))

(defcmd ma-position ()
  (current-pos))

(defcmd montrer-tortue ()
  (show-turtle))

(defcmd cacher-tortue ()
  (hide-turtle))
