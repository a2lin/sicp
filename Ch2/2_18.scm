(define (reverse l)
  (define (reverse-internal acc l)
    (if (null? l)
      acc
      (reverse-internal (append (list (car l)) acc) (cdr l))))
  (reverse-internal (list (car l)) (cdr l)))
(reverse (list 1 4 9 16 25))
