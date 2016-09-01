(load "stream_lib.scm")
(define (solve-2nd a b dt y0 dy0)
  (integral
    (integral dy0
