(in-package :cl-logo.core)

(defparameter *turtle* nil)

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

(defmethod copy-object ((turtle turtle))
  (make-instance 'turtle
                 :x (turtle-x turtle)
                 :y (turtle-y turtle)
                 :theta (turtle-theta turtle)
                 :pen (copy-object (turtle-pen turtle))))

(defun reset-turtle ()
  (setf *turtle* (make-instance 'turtle)))
