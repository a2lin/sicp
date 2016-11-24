(load "4_6.scm")
(define (count-clause exp)
  (define (count-clause-internal exp nu)
    (if (null? exp)
      nu
      (count-clause-internal (cdr exp) (+ 1 nu))))
  (count-clause-internal exp 0))

(define (named-let? let-exp) (eq? (count-clause let-exp) 3))

(define (let-parameters exp)
  (if (named-let? exp)
    (cons (cons (car exp) (make-lambda (cadr exp) (cddr exp))) (cadr exp))
    (cadr exp)))
