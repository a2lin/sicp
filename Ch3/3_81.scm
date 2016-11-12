(load "stream_lib.scm")
(define (rand-update x)
  (modulo (+ (* x 1103515245) 12345) 32768))

(define random-init 0)

(define random-numbers
  (cons-stream
    random-init
    (stream-map rand-update random-numbers)))

(take random-numbers 7)
