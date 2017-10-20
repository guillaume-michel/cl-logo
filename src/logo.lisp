;;;; logo.lisp

(in-package #:cl-logo)

(defparameter turtle-pane nil)
(defparameter turtle-x 320)
(defparameter turtle-y 240)
(defparameter turtle-theta 0)
(defparameter turtle-draw t)

(defun get-state()
  (list turtle-x turtle-y turtle-theta turtle-draw))

(defun reset ()
  (setf turtle-x 320)
  (setf turtle-y 240)
  (setf turtle-theta 0)
  (setf turtle-draw t))

(defun forward (length)
  (let ((new-x (+ turtle-x (* length (cos turtle-theta))))
        (new-y (- turtle-y (* length (sin turtle-theta)))))
    (if turtle-draw
        (draw-line turtle-pane turtle-x turtle-y new-x new-y))
    (setf turtle-x new-x)
    (setf turtle-y new-y)))

(defun radians (angle)
  (* pi (/ angle 180)))

(defun right (angle)
  (setf turtle-theta (- turtle-theta (radians angle))))

(defun back (length)
  (forward (- length)))

(defun left (angle)
  (right (- angle)))

(defun penup ()
  (setf turtle-draw nil))

(defun pendown ()
  (setf turtle-draw t))

#|
(defun plot ()
  (capi:contain
   (make-instance 'capi:output-pane :display-callback 'draw)
   :best-width 640 :best-height 480))

(defun draw (pane &optional x y width height)
  (declare (ignore x y width height))
  (setf turtle-pane pane)
  (reset)
  (forward 100)
  (left 90)
  (forward 100)
  (left 30)
  (forward 100)
  (left 120)
  (forward 100)
  (left 30)
  (forward 100))

(plot)

(defun inspi (side angle inc count)
  (forward side)
  (right angle)
  (if (> count 0)
      (inspi side (+ angle inc) inc (- count 1))))

(defun draw (pane &optional x y width height)
  (declare (ignore x y width height))
  (setf turtle-pane pane)
  (reset)
  (inspi 50 2 20 1000))

(defun ldragon (size level)
  (if (= level 0)
      (forward size)
      (progn
        (ldragon size (- level 1))
        (left 90)
        (rdragon size (- level 1)))))

(defun rdragon (size level)
  (if (= level 0)
      (forward size)
      (progn
        (ldragon size (- level 1))
        (right 90)
        (rdragon size (- level 1)))))

(defun draw (pane &optional x y width height)
  (declare (ignore x y width height))
  (setf turtle-pane pane)
  (reset)
  (ldragon 4 11))
|#
