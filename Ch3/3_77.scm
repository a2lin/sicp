(define (integral delayed-integrand initial-value dt)
  (cons-stream
    initial-value
    (let ((integrand (force delayed-integrand)))
      (if (stream-null? integrand)
        '()
        (integral (delay stream-cdr integrand)
                  (+ (* dt (stream-car integrand))
                     initial-value)
                  dt))))
; 'every caller of integral must now `delay` the integrand argument.
; this includes us!
