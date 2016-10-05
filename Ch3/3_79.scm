(load "stream_lib.scm")

(define (integral delayed-integrand initial-value dt)
  (define int
    (cons-stream
      initial-value
      (let ((integrand (force delayed-integrand)))
        (add-streams (scale-stream integrand dt) int))))
    int)

; start -> map:f -> dy -> integral (y0) -> y -> start
(define (solve f y0 dt)
  (define y (integral (delay dy) y0 dt))
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

(define (f a b)
  (define (g x y)
    (+ (* x a) (* y b)))
  g)
(define (apply-f a b dt y0 dy0) 
  (solve-2nd-general (f a b) dt y0 dy0))

(apply-f 1 3 0.0001 3 7)
