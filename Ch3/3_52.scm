(load "stream_lib.scm")
(define (stream-for-each proc s) 
  (if (stream-null? s)
    'done
    (begin (proc (stream-car s))
           (stream-for-each proc (stream-cdr s)))))
(define (display-stream s) (stream-for-each display-line s))
(define (display-line x) (newline) (display x))
;(define sum 0) 
;(define (accum x) (set! sum (+ x sum)) sum)
;(define seq
;  (stream-map accum
;              (stream-enumerate-interval 1 20)))
;(define y (stream-filter even? seq))
;(define z
;  (stream-filter (lambda (x) (= (remainder x 5) 0))
;                 seq))
;(stream-ref y 7)
;(display-stream z)

; expected: 136
; display-stream z should show:
; 10, 15, 45, 55, 105, 120, 190, 210.
; we take advantage of the caching, otherwise accum would
; have been accumulated again as display-stream started from
; zero.
