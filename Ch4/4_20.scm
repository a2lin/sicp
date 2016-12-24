(define (f x)
  (define (even? n) (if (= n 0) true (odd? (- n 1))))
  (define (odd? n) (if (= n 0) false (even? (- n 1))))
  <>)

(define (f x)
  (letrec
    ((even? (lambda (n)
              (if (= n 0) true (odd? (- n 1)))))
     (odd? (lambda (n)
             (if (= n 0) false (even? (- n 1))))))
    <>))
