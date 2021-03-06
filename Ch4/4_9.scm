; (while (cond-exp) (body))
(define (while? exp) (tagged-list? exp 'while))
(define (while-cond exp)
  (car exp))
(define (while-body exp)
  (cadr exp))
(define (eval-while exp env)
  (if (eval (while-cond exp))
    (eval-while exp env)
    'ok))
