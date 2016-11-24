(define (let? exp) (tagged-list? exp 'let))
(define (let-parameters exp) (cadr exp))
(define (let-body exp) (caddr exp))
(define (let-paired-lists exp)
  (if (null? exp)
    (cons '() '())
    (let ((cvar (caar exp)) (cexp (cdar exp)))
      (let ((paired-list-result (let-paired-internal (cdr exp))))
        (cons (cons cvar (car paired-list-result)) (cons cexp (cdr paired-list-result)))))))

(define (let->combination exp)
  (let ((paired-list (let-paired-lists (let-parameters exp))))
    (let ((let-params (car paired-list)) (let-exps (cdr paired-list)))
      (make-begin (make-lambda (let-params) (let-body exp)) (let-exps)))))

(define (make-let parameters body)
  (cons 'let (cons parameters body)))
