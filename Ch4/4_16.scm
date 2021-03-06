; 
;(define (f x)
;  (define (even? n) 
;    (if (= n 0) 
;      true 
;      (odd? (- n 1)))) 
;  (define (odd? n) 
;    (if (= n 0) 
;      false 
;      (even? (- n 1)))) 
;  ⟨rest of body of f⟩)
;
; Design mechanism to make this valid:: both need
; to be added at the same time

(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars) 
             (env-loop (enclosing-environment env))) 
            ((eq? var (car vars)) 
             (if (eq? (car vals) '*UNASSIGNED*)
               (error "unassigned")
               (car vals)))
            (else (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
      (error "Unbound variable" var)
      (let ((frame (first-frame env)))
        (scan (frame-variables frame)
              (frame-values frame)))))
  (env-loop env))

;b)
; pass-through
(define (make-assignment variable value)
  (let ((assign-pair (cons variable value)))
    (cons 'set assign-pair)))

(define (scan-out-defines)
 (let ((let-list ()) (new-body ()))
   (define (internal-scan body)
     (if (null? body)
       (make-let let-list new-body)
       (if (definition? (car body))
         (begin
           (cons (cons (definition-variable (car body)) '*unassigned*) let-list)
           (cons (make-assignment (definition-variable (car body)) (definition-value (car body))) new-body)
           (internal-scan (cdr body)))
         (begin
           (cons (cdr body) new-body) 
           (internal-scan (cdr body))))
       )
     )
   )
 )

;c)
; This needs to be in make-procedure for performance, as (procedure-body) is called and we don't want to constantly rewrite.
; Alternatively with stateful program we can cache the value.
