; we can show that the case works in the first case but is a problem in the
; second case by transforming the let into lambdas.

(define (solve f y0 dt)
  (let ((y '*unassigned*)
        (dy '*unassigned*))
    (set! y (integral (delay dy) y0 dt))
    (set! dy ((stream-map f y)))
    y))
; xform this into:
(define (solve f y0 dt)
  ((lambda (y dy)
     (set! y (integral (delay dy) y0 dt))
     (set! dy ((stream-map f y)))
     y)
   '*unassigned*
   '*unassigned*))

(define (solve f y0 dt)
  (let ((y '*unassigned*) (dy '*unassigned*))
    (let ((a (integral (delay dy) y0 dt)) (b (stream-map f y)))
      (set! y a)
      (set! dy b)
      y)))
; xform into lambda
(define (solve f y0 dt)
  ((lambda (y dy)
     (let ((a (integral (delay dy) y0 dt)) (b (stream-map f y)))
       (set! y a)
       (set! dy b)
       y))
   '*unassigned*
   '*unassigned*))
; we can see that y, dy are '*unassigned' value-wise, but this gets fixed before
; the lambda returns.

; xform other into lambda
(define (solve f y0 dt)
  ((lambda (y dy)
     ((lambda (a b)
        (set! y a)
        (set! dy b)
        y)
      (integral (delay dy) y0 dt)
      (stream-map f y))
   '*unassigned*
   '*unassigned*)))

; dy, y are both 'unassigned; so
; (integral (delay '*unassigned*) y0 dt)
; (stream-map f '*unassigned*)
; and therefore we have a problem.
