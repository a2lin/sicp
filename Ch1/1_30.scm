(define (inc x)
  (+ x 1))

(define (cube x)
  (* x x x))

(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a)  (+ result (term a)))))
  (iter a 0))

(sum cube 0 inc 3)
