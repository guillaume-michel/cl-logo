(uiop:define-package :cl-logo.logo.fr
    (:use :cl
          :iterate
          :cl-logo.logo)
  (:export
   #:recommencer
   #:annuler

   #:avancer
   #:tourner
   #:lever-stylo
   #:baisser-stylo
   #:largeur-stylo
   #:couleur-stylo
   #:reculer
   #:tourner-haut
   #:tourner-bas
   #:tourner-gauche
   #:tourner-droite
   #:deplacer-a
   #:haut
   #:bas
   #:gauche
   #:droite
   #:ma-position
   #:montrer-tortue
   #:cacher-tortue
   ))
