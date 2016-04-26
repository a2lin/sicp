(define (accumulate fn initial sequence)
  (if (null? sequence)
    initial
    (fn (car sequence)
        (accumulate fn initial (cdr sequence)))))

(define (count-leaves t)
  (accumulate (lambda (x y) (+ x y)) 0 (map (lambda (x) (if (pair? x) (count-leaves x) 1)) t)))

(define x (cons (list 1 2) (list 3 4)))
(count-leaves x)
