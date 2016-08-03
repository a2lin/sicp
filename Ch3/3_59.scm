(load "stream_lib.scm")

;a.)
(define (integrate-series power-series)
  (stream-map * power-series (stream-map / (ones) (integers))))

;b.)
(define (exp-series)
  (cons-stream 1 (integrate-series (exp-series))))

;c.)
(define (cosine-series) (cons-stream 1.0 (scale-stream (integrate-series (sine-series)) -1)))
(define (sine-series) (cons-stream 0.0 (integrate-series (cosine-series))))
