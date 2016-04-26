(define (deep-reverse l)
  (if (not (pair? l))
    l
    (let ((rest (cdr l))
          (head (car l)))
      (if (null? rest)
        (if (pair? head)
          (deep-reverse head)
          head)
        (list (deep-reverse rest) (deep-reverse head))))))

(define x (list (list 1 2) (list 3 4)))
(deep-reverse x)
