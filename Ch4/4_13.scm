(define (make-unbound! var env)
  (let ((frame (first-frame env)))
    (define (scan vars vals)
      (cond ((eq? (car vars) var)
             (begin 
               (set-car! frame (cdr vars)) 
               (set-cdr! frame (cdr vals))))
            ((eq? (cadr vars) var)
             (begin
               (set-cdr! vars (cddr vars))
               (set-cdr! vals (cddr vals))))
            (else (scan (cdr vars) (cdr vals)))))
    (scan (frame-variables frame) (frame-values frame))))
