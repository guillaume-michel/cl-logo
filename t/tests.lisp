(in-package :cl-logo-tests)

(fiveam:def-suite cl-logo-test-suite
    :description "cl-logo test suite.")

(fiveam:in-suite cl-logo-test-suite)

(fiveam:test forward
  (fiveam:is (equal (progn (reset)
                           (forward 10)
                           (get-state))
                    (list 330.0 240.0 0 t))))

(defun run-tests ()
  (princ "Running all cl-logo unit tests")
  (fiveam:run! 'cl-logo-test-suite))
