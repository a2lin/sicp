(load "stream_lib.scm")

;a.)
(define (integrate-series power-series)
  (stream-map * power-series (stream-map / (ones) (integers))))

;b.)
(define (exp-series)
  (cons-stream 1 (integrate-series (exp-series))))

;c.)
(define (cosine-series) (cons-stream 1 (integrate-series (stream-map - (sine-series)))))
(define (sine-series) (cons-stream 0 (integrate-series (cosine-series))))
