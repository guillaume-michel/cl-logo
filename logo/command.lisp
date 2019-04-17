(in-package :cl-logo.logo)

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
