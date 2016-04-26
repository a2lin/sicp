(define (filtered-accumulate filter combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
      result
      (if (filter a)
          (iter (next a) (combiner result (term a)))
          (iter (next a) result))))
  (iter a null-value))


(define (sum term a next b)
  (define (filter x) #t)
  (filtered-accumulate filter + 0 term a next b))

(define (sigma a b)
  (define (term x) x)
  (define (next x) (+ x 1))
  (sum term a next b))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
          (remainder (* base (expmod base (- exp 1) m))
                     m))))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))
 
(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

(define (prime? x)
  (fast-prime? x 300))

(define (square x)
  (* x x))

(define (squareprime a b)
  (define (next x) (+ x 1))
  (filtered-accumulate prime? + 0 square a next b))

(define (relprimeprod n)
  (define (next x) (+ x 1))
  (define (filter x) (= 1 (gcd x n)))
  (define (term x) x)
  (filtered-accumulate filter * 1 term 1 next (- n 1)))

(relprimeprod 6)
