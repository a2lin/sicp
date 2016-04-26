(define (accumulate combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
      result
      (iter (next a) (combiner result (term a)))))
  (iter a null-value))

(define (accumulate-rec combiner null-value term a next b)
  (if (> a b)
    null-value
    (combiner (accumulate-rec combiner null-value term (next a) next b) (term a))))


(define (sum term a next b)
  (accumulate + 0 term a next b))

(define (sigma a b)
  (define (term x)
    x)
  (define (next x)
    (+ x 1))
  (sum term a next b))

(define (product term a next b)
  (accumulate * 1 term a next b))

(define (factorial b)
  (define (term x)
    x)
  (define (next x)
    (+ x 1))
  (product term 1 next b))

(factorial 5)
