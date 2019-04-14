(in-package :cl-logo.core)

(defclass pen ()
  ((color :initarg :color
          :initform '(0 0 0)
          :accessor pen-color
          :documentation "pen's RGB color")
   (width :initarg :width
          :initform 1
          :accessor pen-width
          :documentation "pen's width in pixels")
   (state :initarg :state
          :initform :down
          :accessor pen-state
          :documentation "pen's state (:up or :down)")))

(defmethod print-object ((object pen) stream)
  (print-unreadable-object (object stream :type t :identity t)
    (with-slots (color width state) object
      (format stream ":color ~A :width ~d :state ~A" color width state))))

(defclass turtle ()
  ((x :initarg :x
      :initform 0
      :accessor turtle-x)
   (y :initarg :y
      :initform 0
      :accessor turtle-y)
   (theta :initarg :theta
          :initform 0
          :accessor turtle-theta
          :documentation "angle from X axis in degrees")
   (pen :initarg :pen
        :initform (make-instance 'pen)
        :accessor turtle-pen)))

(defmethod print-object ((object turtle) stream)
  (print-unreadable-object (object stream :type t :identity t)
    (with-slots (x y theta pen) object
      (with-slots (color width state) pen
        (format stream
                ":x ~d :y ~d :theta ~d :color ~A :width ~d :state ~A"
                x y theta color width state)))))

(defgeneric copy-object (object)
  (:documentation "deep object copy"))

(defmethod copy-object ((turtle turtle))
  (make-instance 'turtle
                 :x (turtle-x turtle)
                 :y (turtle-y turtle)
                 :theta (turtle-theta turtle)
                 :pen (copy-object (turtle-pen turtle))))

(defmethod copy-object ((pen pen))
  (make-instance 'pen
                 :color (pen-color pen)
                 :width (pen-width pen)
                 :state (pen-state pen)))

(defparameter *turtle* nil)

(defun reset-turtle ()
  (setf *turtle* (make-instance 'turtle)))

(defparameter *history* nil)

(defun reset-history ()
  (setf *history* '()))

(defun show-program ()
  (mapcar #'cadr (reverse *history*)))

(defun get-state()
  (list (turtle-x *turtle*)
        (turtle-y *turtle*)
        (turtle-theta *turtle*)
        (pen-color (turtle-pen *turtle*))
        (pen-width (turtle-pen *turtle*))
        (pen-state (turtle-pen *turtle*))))

(defun reset ()
  (reset-history)
  (reset-turtle)
  (unless (null *backend*)
    (reset-backend *backend*))
  *turtle*)

(defun undo ()
  (cond ((null *history*) t)
        (t (progn
             (setf *turtle* (caar *history*))
             (setf *history* (cdr *history*))
             (when (not (null *backend*))
               (delete-last-transaction *backend*)))))
  *turtle*)

(defconstant +degrees-to-radians+ (/ (float pi 1f0) 180))
(defconstant +radians-to-degrees+ (/ 180 (float pi 1f0)))

(defun radians (angle)
  (* angle +degrees-to-radians+))

(defmacro defcmd (name lambda-list &body body)
  `(defun ,name (,@lambda-list)
     (progn
       (let ((turtle-before-cmd))
         (when (= (transaction-count *backend*) 0)
           (setf turtle-before-cmd (copy-object *turtle*)))
         (with-transactional-backend (*backend*)
           ,@body)
         (when (= (transaction-count *backend*) 0)
           (setf *history* (cons (list turtle-before-cmd
                                       (list (quote ,name) ,@lambda-list))
                                 *history*))))
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
  (let* ((new-x (+ (turtle-x *turtle*) (* length (precise-cos (turtle-theta *turtle*)))))
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
  (setf (turtle-x *turtle*) x)
  (setf (turtle-y *turtle*) y))

(defun current-pos ()
  (cons (turtle-x *turtle*) (turtle-y *turtle*)))

(eval-when (::load-toplevel)
  (reset))
