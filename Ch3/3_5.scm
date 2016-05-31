(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))

(define (estimate-integral P x1 x2 y1 y2 trials)
    (define (estimate-integral-helper trials-left acc)
      (if (= 0 trials-left)
        (* (/ acc trials) (- x2 x1) (- y2 y1))
        (if (P (random-in-range x1 x2) (random-in-range y1 y2))
          (estimate-integral-helper (- trials-left 1) (+ acc 1))
          (estimate-integral-helper (- trials-left 1) acc))))
    (estimate-integral-helper trials 0))

(define (integ-predicate x y)
  (<= (+ (* x x) (* y y)) 1))

(estimate-integral integ-predicate -1.0 1.0 -1.0 1.0 200000)
