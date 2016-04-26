(define (fixed-point f first-guess)
  (let ((tolerance 0.00001))
    (define (close-enough? v1 v2)
      (< (abs (- v1 v2)) tolerance))
    (define (try guess)
      (let ((next (f guess)))
        (if (close-enough? guess next)
          next
          (try next))))
    (try first-guess)))

(define (average-damp f)
  (define (average x y)
    (/ (+ x y) 2))
  (lambda (x) (average x (f x))))

(define (repeated f n)
  (define (compose f g)
    (lambda (x) (f (g x))))
  (define (multi-compose g n)
    (if (= n 1)
      g
      (multi-compose (compose f g) (- n 1))))
  (multi-compose f n))

(define (fast-expt b n)
  (define (square x)
    (* x x))
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))

(define (nthroot x initial-guess n)
  (let ((f (lambda (y) (/ x (fast-expt y (- n 1)))))
        (damps 8))
    (fixed-point (repeated (average-damp f) damps) initial-guess)))

(nthroot 37 1.0 4)
