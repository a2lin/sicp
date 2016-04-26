(define nil (list))
(define (square-list items)
  (if (null? items)
    nil
    (cons (* (car items) (car items)) (square-list (cdr items)))))
(define (square-list-map items)
  (map (lambda (x) (* x x)) items))

(square-list (list 1 2 3 4))
(square-list-map (list 1 2 3 4))

