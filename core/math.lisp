(in-package :cl-logo.core)

(defconstant +degrees-to-radians+ (/ (float pi 1f0) 180))
(defconstant +radians-to-degrees+ (/ 180 (float pi 1f0)))

(defun radians (angle)
  (* angle +degrees-to-radians+))

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
