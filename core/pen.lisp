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

(defmethod copy-object ((pen pen))
  (make-instance 'pen
                 :color (pen-color pen)
                 :width (pen-width pen)
                 :state (pen-state pen)))
