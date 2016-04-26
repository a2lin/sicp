(define (product term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* result (term a)))))
  (iter a 1))

(define (product-rec term a next b)
    (if (> a b)
        1
        (* (term a) (product-rec term (next a) next b))))

(define (factorial x)
  (define (next a)
    (+ a 1))
  (define (term a)
    a)
  (product-rec term 1 next x))

(define (pi n)
  (define (term a)
    (if (even? a)
        (/ a (+ a 1))
        (/ (+ a 1) a)))
  (define (next a)
    (+ a 1))
  (product term 2 next (+ n 2)))

(* 4.0 (pi 10000))
