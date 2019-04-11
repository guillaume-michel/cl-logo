(in-package :cl-logo.backend)

(defclass transaction ()
  ((commands :initform nil
            :accessor transaction-commands
            :documentation "list of commands in transaction")
   (count :initform 0
          :accessor transaction-count
          :documentation "counter of start-transaction call"))
  (:documentation "A transaction groups together a list of commands.

transactions can be nested but only 1 transaction will exists at one time.
ref counting is done to detect end of transaction."))

(defgeneric start-transaction (transaction)
  (:documentation "Starts a transaction of commands")
  (:method (transaction)
    (incf (transaction-count transaction))))

(defgeneric end-transaction (transaction)
  (:documentation "Ends a transaction of commands")
  (:method (transaction)
    (unless (<= (transaction-count transaction) 0)
      (decf (transaction-count transaction)))))

(defmacro with-transaction ((backend) &body body)
  `(progn
     (start-transaction ,backend)
     (unwind-protect (progn ,@body)
       (end-transaction ,backend))))
