(define (fringe tree)
  (if (pair? tree)
    (append (fringe (car tree)) (fringe (cdr tree)))
    (if (not (null? tree))
        (list tree)
        (list))))

(define x (list (list 1 2) (list 3 4)))

(fringe x)
