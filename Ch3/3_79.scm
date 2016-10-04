(load "stream_lib.scm")

; start -> map:f -> dy -> integral (y0) -> y -> start
(define (solve f y0 dt)
  (define y (integral dy y0 dt))
  (define dy (stream-map f y))
  y)


(define (solve-2nd a b dt y0 dy0)
  (define dy (integral (delay ddy) dy0 dt))
  (define y (integral dy y0 dt))
  (define ddy (add-streams (stream-scale y a)
                           (stream-scale dy b)))
  y)

; solve-2nd generalized -- for any diffeq
(define (solve-2nd-general fn dt y0 dy0)
  (define dy (integral (delay ddy) dy0 dt))
  (define y (integral dy y0 dt))
  (define ddy (stream-map f dy y))
  y)
