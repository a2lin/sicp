(define (compose f g)
    (lambda (x) (f (g x))))

(define (repeated f n)
  (define (multi-compose g n)
    (if (= n 1)
      g
      (multi-compose (compose f g) (- n 1))))
  (multi-compose f n))

(define (smooth f)
  (let ((dx 0.00001))
    (lambda (x) (/ (+ (f (- x dx)) (f x) (f (+ x dx))) 3))
  ))

(define (nsmooth f n)
  (repeated (smooth f) n))
