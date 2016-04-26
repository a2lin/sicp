(define (compose f g)
    (lambda (x) (f (g x))))

(define (repeated f n)
  (define (multi-compose g n)
    (if (= n 1)
      g
      (multi-compose (compose f g) (- n 1))))
  (multi-compose f n))

(define (square x)
  (* x x))

((repeated square 2) 5)
