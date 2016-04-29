(define (equal? a b)
  (if (and (null? a) (null? b))
    #t
    (if (and (pair? a) (pair? b))
      (if (eq? (car a) (car b))
        (equal? (cdr a) (cdr b))
        #f
        )
      (eq? a b)
      )
    )
  )

(equal? '(this is a list) '(this is a list))
(equal? '(this is a list) '(this (is a) list))
