(define (even? x)
  (= (remainder x 2) 0))

(define (expmod base exp m)
    (cond ((= exp 0) 1)
      ((even? exp)
       (remainder (square (expmod base (/ exp 2) m))
                  m))
      (else
        (remainder (* base (expmod base (- exp 1) m))
                   m))))

(define (test a n)
    (= (expmod a n n) a))

(define (carmichael n)
  (define (test-carmichael a n)
      (cond ((= a 0) #t)
            ((test a n) (test-carmichael (- a 1) n))
            (else #f)))
  (test-carmichael (- n 1) n))

(carmichael 1729)
