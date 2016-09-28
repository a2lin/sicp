(load "stream_lib.scm")
(define (integral delayed-integrand initial-value dt)
  (cons-stream
    initial-value
    (let ((integrand (force delayed-integrand)))
      (if (stream-null? integrand)
        '()
        (integral (delay (stream-cdr integrand))
                  (+ (* dt (stream-car integrand))
                     initial-value)
                  dt))))
  )
; 'every caller of integral must now `delay` the integrand argument.
; this includes us!

(define (integral-ref delayed-integrand initial-value dt)
  (define int
    (cons-stream
      initial-value
      (let ((integrand (force delayed-integrand)))
        (add-streams (scale-stream integrand dt) int))))
    int)
              

(define (solve f y0 dt)
  (define y (integral (delay dy) y0 dt))
  (define dy (stream-map f y))
  y)

;(stream-ref (solve (lambda (y) y)
;                   1
;                   0.0001)
;            10000)
