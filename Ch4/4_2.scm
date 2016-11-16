;a) It seems like for (define x 3),
; it will think that define is an application
; and then do apply (eval define env) (x 3)
; but of course since define is a special form 
; this won't work properly..

; b) The clause should look like this:

((application? exp)
 (apply (eval (operator (rest-application exp)) env)
        (list-of-values (operands (rest-application exp)) env)))

; where rest-application is like
(define (rest-application exp) (cdr exp))

; and the new application? should be
(define (application? exp) (tagged-list? exp 'call))
