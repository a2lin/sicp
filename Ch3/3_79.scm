(load "stream_lib.scm")

; start -> map:f -> dy -> integral (y0) -> y -> start
(define (solve f y0 dt)
  (define y (integral dy y0 dt))
  (define dy (stream-map f y))
  y)


(define (solve-2nd a b dt y0 dy0)
  (define ddy (stream-add (stream-scale y)
                        (stream-scale dy)))
  (define dy (integral dy0 ddy))
  (define y (integral y0 dy))
  y)

; solve-2nd generalized -- for any diffeq
(define (solve-2nd-generalized  
