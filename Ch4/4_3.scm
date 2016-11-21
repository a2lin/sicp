(load "evaluator.scm")
; data-directed eval
; strategy: make a table w/ fn and have generic methods pull
; tags out and call the relevant fn

; assoc feature
; fns are stored in an assoc list where the primary list is pair of data -> next ptr records;
; first record is ('*table,'()), rest is ptrs of data, next.
; assoc goes thru this table left to right looking for key, else returns false.
(define (assoc key records)
  (cond ((null? records) false)
        ((equal? key (caar records)) (car records))
        (else (assoc key (cdr records)))))

; 1-d table for procs
(define (make-table)
  (let ((local-table (list '*table*)))
    (define (lookup key)
      (let ((record (assoc key (cdr local-table))))
        (if record
          (cdr record)
          false)))
    (define (insert! key value)
      (let ((record (assoc key (cdr table))))
        (if record
          (set-cdr! record value)
          (set-cdr! table
                    (cons (cons key value)
                          (cdr table)))))
      'ok)
     (define (dispatch m)
        (cond ((eq? m 'lookup-proc) lookup)
              ((eq? m 'insert-proc!) insert!)
              (else (error "Unknown operation: TABLE" m))))
      dispatch))

(define operation-table (make-table))
(define get (operation-table 'lookup-proc))
(define put (operation-table 'insert-proc!))

(define (install-eval-procs)
  (define (eval-self-eval exp env) exp)
  (define (eval-variable exp env) (lookup-variable-value exp env)) ; get the variable value
  (define (eval-quotation exp env) (cadr exp)) ; get the text of the quote
  (define (eval-assignment exp env)
    (set-variable-value! (assignment-variable exp)
                         (eval (assignment-value exp) env)
                         env)
    'ok)
  (define (eval-definition exp env)
    (define-variable! (definition-variable exp)
                      (eval (definition-value exp) env)
                      env)
    'ok)
  (define (eval-if exp env)
    (if (true? (eval (if-predicate exp) env))
      (eval (if-consequent exp) env)
      (eval (if-alternative exp) env)))

  (define (eval-lambda exp env)
    (make-procedure (lambda-parameters exp)
                    (lambda-body exp)
                    env))
  (define (eval-begin exp env)
    (eval-sequence (begin-actions exp env)))
  (define (eval-cond exp env)
    (eval (cond->if exp) env))
  (define (eval-application exp env)
    (apply (eval (operator exp) env)
           (list-of-values (operands exp env))))
  (put 'self-evaluating eval-self-eval)
  (put 'variable eval-variable)
  (put 'quoted eval-quotation)
  (put 'assignment eval-assignment)
  (put 'definition eval-definition)
  (put 'if eval-if)
  (put 'lambda eval-lambda)
  (put 'begin eval-begin)
  (put 'cond eval-cond)
  (put 'application eval-application)
  )

(define (eval exp env)
  (define (tag exp)
    car exp)
  (define (val exp)
    (cdr exp))
  (let (fn (get (tag exp)))
    (fn (val exp) env)))
