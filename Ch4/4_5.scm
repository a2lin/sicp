(define (cond-aug-predicate? clause)
  (eq? (car (cond-actions clause)) '=>))
(define (cond-aug-predicate clause)
  (let ((predicate-value (eval (cond-predicate clause))))
    (if predicate-value
      ((eval (cdr (cond-actions clause))) predicate-value)
      false)))
