(in-package :cl-logo.logo)

(defparameter *easy-mode* nil)

(defcmd forward (length)
  (let* ((length (if *easy-mode* (* length cl-logo.core:*grid-interval*) length))
         (new-x (+ (turtle-x *turtle*) (* length (precise-cos (turtle-theta *turtle*)))))
         (new-y (+ (turtle-y *turtle*) (* length (precise-sin (turtle-theta *turtle*))))))
    (if (eq (pen-state (turtle-pen *turtle*)) :down)
        (draw-line *backend*
                   (turtle-x *turtle*)
                   (turtle-y *turtle*)
                   new-x
                   new-y
                   (pen-color (turtle-pen *turtle*))
                   (pen-width (turtle-pen *turtle*))))
    (setf (turtle-x *turtle*) new-x)
    (setf (turtle-y *turtle*) new-y)))

(defcmd rotate (angle)
  (setf (turtle-theta *turtle*) (+ (turtle-theta *turtle*) angle)))

(defcmd penup ()
  (setf (pen-state (turtle-pen *turtle*)) :up))

(defcmd pendown ()
  (setf (pen-state (turtle-pen *turtle*)) :down))

(defcmd penwidth (width)
  (setf (pen-width (turtle-pen *turtle*)) width))

(defcmd pencolor (r g b)
  (setf (pen-color (turtle-pen *turtle*)) (list r g b)))

(defcmd backward (length)
  (forward (- length)))

(defcmd face-up ()
  (setf (turtle-theta *turtle*) 90))

(defcmd face-down ()
  (setf (turtle-theta *turtle*) 270))

(defcmd face-left ()
  (setf (turtle-theta *turtle*) 180))

(defcmd face-right ()
  (setf (turtle-theta *turtle*) 0))

(defcmd move-to (x y)
  (let ((x (if *easy-mode* (* x cl-logo.core:*grid-interval*) x))
        (y (if *easy-mode* (* y cl-logo.core:*grid-interval*) y)))
    (setf (turtle-x *turtle*) x)
    (setf (turtle-y *turtle*) y)))

(defcmd up (length)
  (face-up)
  (forward length))

(defcmd down (length)
  (face-down)
  (forward length))

(defcmd left (length)
  (face-left)
  (forward length))

(defcmd right (length)
  (face-right)
  (forward length))

(defun current-pos ()
  (let* ((x (turtle-x *turtle*))
         (y (turtle-y *turtle*))
         (final-x (if *easy-mode* (/ x cl-logo.core:*grid-interval*) x))
         (final-y (if *easy-mode* (/ y cl-logo.core:*grid-interval*) y)))
    (cons final-x final-y)))

(defun show-turtle ()
  (setf (turtle-visibility *turtle*) :visible)
  (commit *backend*)
  *turtle*)

(defun hide-turtle ()
  (setf (turtle-visibility *turtle*) :hidden)
  (commit *backend*)
  *turtle*)
