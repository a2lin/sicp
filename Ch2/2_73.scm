; a. because number? and same-variable? are the base cases for the recursion.
;    if they were eaten into the data-directed dispatch we'd have an infinite
;    recursion.

; b.

(define (install-sum-package)
    (define (make e1 e2)
      (list '+ e1 e2))
    (define (lhs sum)
      (cadr sum))
    (define (rhs sum)
      (caddr sum))
    (put 'make 'sum make)
    (put 'lhs 'mul lhs)
    (put 'rhs 'mul rhs))

(define (install-mul-package)
  (define (make e1 e2)
    (list '* e1 e2))
  (define (lhs mul)
    (cadr mul))
  (define (rhs mul)
    (caddr mul))
  (put 'make 'mul make)
  (put 'lhs 'mul lhs)
  (put 'rhs 'mul rhs))

(define (install-exp-package)
  (define (make e1 e2)
    (cond ((and (number? e2) (= e2 0)) 1)
          ((and (number? e2) (= e2 1)) e1)
          ((and (number? e1) (number? e2)) (expt e1 e2))
          (else (list '** e1 e2))))


(define (deriv-sum exp var)
  ((get 'make 'sum) (deriv (('get 'lhs 'sum) exp) var)
        (deriv (('get 'rhs 'sum) rhs exp) var)))

(define (deriv-mul exp var)
  ((get 'make 'sum) (('get 'make 'product) 
                     (('get 'lhs 'mul) exp)
                     (deriv (get 'rhs 'mul) exp))
                    (('get 'make 'product)
                     (('get 'rhs 'mul) exp)
                     (deriv (get 'lhs 'mul) exp))))
