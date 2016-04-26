(define (fast-expt a b)
  (define (square x)
    (* x x))
  (define (internal-expt a b c)
    (if (= c 0)
        a 
        (if (= 0 (remainder c 2))
          (internal-expt a (* b b) (/ c 2))
          (internal-expt (* a b) b (- c 1))))
    )
  (internal-expt 1 a b)
  )

(define (unfactor base num)
    (define (unfactor-internal count base num)
      (if (= (remainder num base) 0)
          (unfactor-internal (+ 1 count) base (/ num base))
          count))
    (unfactor-internal 0 base num))

(define (cons x y)
  (* (fast-expt 2 x) (fast-expt 3 y)))
(define (car x)
  (unfactor 2 x))
(define (cdr x)
  (unfactor 3 x))

(cons 0 0 )

