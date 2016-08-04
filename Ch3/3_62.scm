(load "stream_lib.scm")
(define (div-series s1 s2)
  (if (eq? (stream-car s2))
    (display "error error error")
    (mul-series s1 (invert-unit-series s2))))

(define (tangent) (div-series (sine-series) (cosine-series)))
