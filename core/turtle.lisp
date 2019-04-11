(in-package :cl-logo.core)

(defclass turtle-state ()
  ((x :initarg :x
      :initform 0
      :accessor x)
   (y :initarg :y
      :initform 0
      :accessor y)
   (theta :initarg :theta
          :initform 0
          :accessor theta
          :documentation "angle from X axis in degrees")
   (pen :initarg :pen
        :initform :down
        :accessor pen)))

(defmethod print-object ((object turtle-state) stream)
  (print-unreadable-object (object stream :type t :identity t)
    (with-slots (x y theta pen) object
      (format stream ":x ~d :y ~d :theta ~d :pen ~A" x y theta pen))))

(defgeneric copy-object (object)
  (:documentation "deep object copy"))

(defmethod copy-object ((turtle turtle-state))
  (make-instance 'turtle-state
                 :x (x turtle)
                 :y (y turtle)
                 :theta (theta turtle)
                 :pen (pen turtle)))

(defparameter *turtle* nil)

(defun reset-turtle ()
  (setf *turtle* (make-instance 'turtle-state)))

(defparameter *history* nil)

(defun reset-history ()
  (setf *history* '()))

(defun show-program ()
  (mapcar #'cadr (reverse *history*)))

(defun get-state()
  (list (x *turtle*)
        (y *turtle*)
        (theta *turtle*)
        (pen *turtle*)))

(defun reset ()
  (reset-history)
  (reset-turtle)
  *turtle*)

(defun undo ()
  (cond ((null *history*) t)
        ((= (length *history*) 1) (reset))
        (t (progn
             (setf *history* (cdr *history*))
             (setf *turtle* (caar *history*)))))
  *turtle*)

(defconstant +degrees-to-radians+ (/ (float pi 1f0) 180))
(defconstant +radians-to-degrees+ (/ 180 (float pi 1f0)))

(defun radians (angle)
  (* angle +degrees-to-radians+))

(defmacro defcmd (name lambda-list &body body)
  `(defun ,name (,@lambda-list)
     (progn
       (with-transaction (*backend*)
         ,@body)
       (when (= (transaction-count *backend*) 0)
         (setf *history* (cons (list (copy-object *turtle*)
                                     (list (quote ,name) ,@lambda-list))
                               *history*)))
       *turtle*)))

(defun precise-cos (angle)
  "precise cosine with arguments in degrees"
  (let ((angle (mod angle 360)))
    (cond ((= angle 0) 1)
          ((= angle 90) 0)
          ((= angle 180) -1)
          ((= angle 270) 0)
          (t (cos (radians angle))))))

(defun precise-sin (angle)
  "precise sine with arguments in degrees"
  (let ((angle (mod angle 360)))
    (cond ((= angle 0) 0)
          ((= angle 90) 1)
          ((= angle 180) 0)
          ((= angle 270) -1)
          (t (sin (radians angle))))))

(defcmd forward (length)
  (let* ((new-x (+ (x *turtle*) (* length (precise-cos (theta *turtle*)))))
         (new-y (+ (y *turtle*) (* length (precise-sin (theta *turtle*))))))
    (if (eq (pen *turtle*) :down)
        (cl-logo.backend:draw-line cl-logo.backend:*backend*
                                   (x *turtle*)
                                   (y *turtle*)
                                   new-x
                                   new-y))
    (setf (x *turtle*) new-x)
    (setf (y *turtle*) new-y)))

(defcmd rotate (angle)
  (setf (theta *turtle*) (+ (theta *turtle*) angle)))

(defcmd penup ()
  (setf (pen *turtle*) :up))

(defcmd pendown ()
  (setf (pen *turtle*) :down))

(defcmd backward (length)
  (forward (- length)))

(defcmd face-up ()
  (setf (theta *turtle*) 90))

(defcmd face-down ()
  (setf (theta *turtle*) 270))

(defcmd face-left ()
  (setf (theta *turtle*) 180))

(defcmd face-right ()
  (setf (theta *turtle*) 0))

(defcmd move-to (x y)
  (setf (x *turtle*) x)
  (setf (y *turtle*) y))

(defun current-pos ()
  (cons (x *turtle*) (y *turtle*)))

(eval-when (::load-toplevel)
  (reset))
