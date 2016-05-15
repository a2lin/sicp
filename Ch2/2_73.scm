; a. because number? and same-variable? are the base cases for the recursion.
;    if they were eaten into the data-directed dispatch we'd have an infinite
;    recursion.

; b.

(define (install-sum-package)
    (define (make e1 e2)
      (cond ((and (number? e1) (= e1 0)) e2)
            ((and (number? e2) (= e2 0)) e1)
            ((and (number? e1) (number? e2)) (+ e1 e2))
            (else (list '+ e1 e2))))
    (define (lhs sum)
      (car sum))
    (define (rhs sum)
      (cadr sum))
    (put 'make '+ make)
    (put 'lhs '* lhs)
    (put 'rhs '* rhs))

(define (install-mul-package)
  (define (make e1 e2)
    (cond ((or (and (number? e1) (= e1 0)) (and (number? e2) (= e2 0))) 0)
          ((and (number? e1) (= e1 1)) e2)
          ((and (number? e2) (= e2 1)) e1)
          ((and (number? e1) (number? e2)) (* e1 e2))
          (else (list '* e1 e2))))
  (define (lhs mul)
    (car mul))
  (define (rhs mul)
    (cadr mul))
  (put 'make '* make)
  (put 'lhs '* lhs)
  (put 'rhs '* rhs))

(define (install-exp-package)
  (define (make e1 e2)
    (cond ((and (number? e2) (= e2 0)) 1)
          ((and (number? e2) (= e2 1)) e1)
          ((and (number? e1) (number? e2)) (expt e1 e2))
          (else (list '** e1 e2))))
  (define (lhs exp)
    (car exp))
  (define (rhs exp)
    (cadr exp))
  (put 'make '** make)
  (put 'lhs '** lhs)
  (put 'rhs '** rhs))

(define (deriv-sum exp var)
  ((get 'make '+) (deriv (('get 'lhs '+) exp) var)
        (deriv (rhs exp) var)))

(define (deriv-mul exp var)
  ((get 'make '+) (('get 'make '*) 
                     (('get 'lhs '*) exp)
                     (deriv (get 'rhs '*) exp))
                    (('get 'make '*)
                     (('get 'rhs '*) exp)
                     (deriv (get 'lhs '*) exp))))

(define (deriv-exp exp var)
  ((get 'make '*) ((get 'lhs '**) exp)
                ((get 'make '**) ((get 'rhs '**) exp)
                                     (if (number? ((get 'lhs '**) exp))
                                       (- ((get 'lhs '**) exp) 1)
                                       (list '- ((get 'lhs '**) exp) 1)
                                       )
                                     )
                )
  )


(put 'deriv '+ deriv-sum)
(put 'deriv '* deriv-mul)
(put 'deriv '** deriv-exp)

(define (deriv exp var)
   (cond ((number? exp) 0)
         ((variable? exp) (if (same-variable? exp var) 1 0))
         (else ((get 'deriv (operator exp)) (operands exp)
                                            var))))
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

  
