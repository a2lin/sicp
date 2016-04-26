(define (accumulate func initial seq)
  (if (null? seq)
    initial
    (func (car seq) 
          (accumulate func initial (cdr seq)))))

(define (enumerate-interval start end)
    (if (> start end)
      ()
      (cons start (enumerate-interval (+ 1 start) end))))

(define (flatmap proc seq)
  (accumulate append () (map proc seq)))

(define (unique-pairs n)
  (flatmap (lambda (x) (map (lambda (y) (list x y)) (enumerate-interval 1 (- x 1)))) (enumerate-interval 1 n)))

(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum?
               (flatmap
                 (lambda (i)
                   (map (lambda (j) (list i j))
                        (enumerate-interval 1 (- i 1))))
                 (enumerate-interval 1 n)))))


(define (new-prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum?
               (unique-pairs n))))

(unique-pairs 3)
