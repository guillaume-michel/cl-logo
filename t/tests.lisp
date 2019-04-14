(in-package :cl-logo.tests)

(fiveam:def-suite cl-logo-test-suite
    :description "cl-logo test suite.")

(fiveam:in-suite cl-logo-test-suite)

(fiveam:test forward
  (fiveam:is (equal (progn (reset)
                           (forward 10)
                           (get-state))
                    (list 10 0 0 '(0 0 0) 1 :down))))

(defun run-tests ()
  (princ "Running all cl-logo unit tests")
  (fiveam:run! 'cl-logo-test-suite))
