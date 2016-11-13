(load "stream_lib.scm")

(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))

(define (integ-predicate x y)
  (<= (+ (* x x) (* y y)) 1))

(define (calc acc trials x1 x2 y1 y2)
  (* (/ acc trials) (- x2 x1) (- y2 y1)))

(define (estimate-integral-stream P x1 x2 y1 y2 acc trials)
  (define (next acc trials)
    (cons-stream
        (calc acc trials x1 x2 y1 y2)
        (estimate-integral-stream P x1 x2 y1 y2 acc trials)))
  (if (P (random-in-range x1 x2) (random-in-range y1 y2))
    (next (+ acc 1) (+ trials 1))
    (next acc (+ trials 1)))
  )

(take (estimate-integral-stream integ-predicate -1.0 1.0 -1.0 1.0 0 0) 200000)
