(load "stream_lib.scm")
(load "3_60.scm")

(define (invert-unit-series series)
  ;sr = stream-cdr series
  ;1, -sr*x
    (cons-stream 1 (mul-series (scale-stream (stream-cdr series) -1) (invert-unit-series series))))

(take (invert-unit-series (ones)) 10)
