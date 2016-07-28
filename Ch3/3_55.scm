(load "stream_lib.scm")
(define (partial-sums s)
  (add-streams s (cons-stream 0 (parial-sums s))))
