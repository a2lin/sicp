(define (enumerate-interval a b)
  (if (> a b)
    ()
    (cons a (enumerate-interval (+ a 1) b))))

(define (accumulate fn initial seq)
  (if (null? seq)
    initial
    (fn (car seq)
        (accumulate fn initial (cdr seq)))))

(define (flatmap proc seq)
  (accumulate append () (map proc seq)))

(define (order-triple n s)
  (filter (lambda (x) (= s (accumulate + 0 x))) (flatmap (lambda (a) (flatmap (lambda (b) (map (lambda (c) (list c b a)) (enumerate-interval 1 (- b 1)))) (enumerate-interval 2 (- a 1)))) (enumerate-interval 3 n))))
(order-triple 4 7)
