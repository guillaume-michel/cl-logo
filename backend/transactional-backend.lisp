(in-package :cl-logo.backend)

(defclass transactional-backend ()
  ((commands :initform nil
            :accessor transaction-commands
            :documentation "list of commands in transaction")
   (count :initform 0
          :accessor transaction-count
          :documentation "counter of start-transaction call"))
  (:documentation "A transactional backend groups together
a list of commands to be called by the backend.

transactions can be nested but only 1 transaction will exists at one time.
ref counting is done to detect end of transaction."))

(defgeneric start-transaction (backend)
  (:documentation "Starts a transaction of commands for the backend"))

(defgeneric end-transaction (backend)
  (:documentation "Ends a transaction of commands for the backend"))

(defgeneric commit (backend)
  (:documentation "Commits transaction to the backend"))

(defgeneric delete-last-transaction (backend)
  (:documentation "Delete the last committed transaction if any"))

;;;; ---------- transactional-backend methods -------------------

(defmethod start-transaction ((backend transactional-backend))
  (incf (transaction-count backend)))

(defmethod end-transaction ((backend transactional-backend))
  (unless (<= (transaction-count backend) 0)
    (decf (transaction-count backend))))

(defmethod end-transaction :after ((backend transactional-backend))
  (when (= (transaction-count backend) 0)
    (commit backend)))

(defmethod reset-backend ((backend transactional-backend))
  (setf (transaction-commands backend) nil)
  (setf (transaction-count backend) 0))

(defmethod draw-line :around ((backend transactional-backend) x1 y1 x2 y2 color width)
  (unless (> (transaction-count backend) 0)
    (error "draw-line should be called in a transaction"))

  ;; append next draw-line call to transaction commands
  ;; here the final draw-line is suspended
  ;; it will be resued in commit method
  (setf (transaction-commands backend)
        (cons (lambda ()
                (call-next-method))
              (transaction-commands backend))))

(defmacro with-transactional-backend ((backend) &body body)
  `(progn
     (start-transaction ,backend)
     (unwind-protect (progn ,@body)
       (end-transaction ,backend))))
