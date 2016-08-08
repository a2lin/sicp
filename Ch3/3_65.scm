(load "stream_lib.scm")

(define (ln2-summands n)
  (cons-stream (/ 1.0 n)
               (stream-map - (ln2-summands (+ n 2)))))
; first non-accel
(define (ln2-stream)
  (partial-sums (ln2-summands 1)))
