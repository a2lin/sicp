(load "evaluator.scm")
(define true #t)
(define false #f)
(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
        ((lambda? exp) (make-procedure (lambda-parameters exp)
                                       (lambda-body exp)
                                       env))
        ((begin? exp)
         (eval-sequence (begin-actions exp) env))
        ((and? exp) (eval-and exp env))
        ((or? exp) (eval-or exp env))
        ((cond? exp) (eval (cond->if exp) env))
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else
          (error "Unknown expression type: EVAL" exp))))

; we expect 'and' to be a tagged list that looks like
; ('and <expr1> <expr2> <expr3> '())
(define (and? exp)
  (tagged-list? exp 'and))

(define (eval-and exp env) 
  (define (process-and exprs result)
    (if (eq? false result) ;and requires all clauses to be true
      false
      (let ((result (eval (first-exp exprs))))
        (if (last-exp? exprs)
          result ;if we haven't succeeded yet, the last expr's result is the answer
          (process-and (rest-exps exprs) result)))))
  (process-and (cdr exp) true)
  )

; we expect 'or' to be a tagged list that looks like
; ('or <expr1> <expr2> <expr3> '())
(define (or? exp)
  (tagged-list? exp 'or))

; we expect short-circuit behavior here.
(define (eval-or exp env) 
  (define (process-or exprs result)
    (if (eq? true result) ; or requires any clause to be true
      true
      (let ((result (eval (first-exp exprs))))
        (if (last-exp? exprs)
          result ; if we haven't succeeded yet, the last expr's result is the answer
          (process-or (rest-exprs exprs) result)))))
  (process-or (cdr exp) false)
  )
