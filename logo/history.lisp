(in-package :cl-logo.logo)

(defparameter *history* nil)

(defun reset-history ()
  (setf *history* '()))

(defun show-program ()
  (mapcar #'cadr (reverse *history*)))

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

(eval-when (::load-toplevel)
  (reset))
