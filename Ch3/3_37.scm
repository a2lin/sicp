(load "3_33_runner.scm")

(define (c+ x y)
  (let ((z (make-connector)))
    (adder x y z)
    z ))
(define (c* x y)
  (let ((z (make-connector)))
    (multiplier x y z)
  z))
(define (cv x)
  (let ((y (make-connector)))
    (constant x y)
  y))
(define (c- x y)
  (let ((neg (make-connector))
        (negy (make-connector))
        (result (make-connector)))
    (constant -1 neg)
    (multiplier neg y negy)
    (adder x negy result)
    result))
(define (c/ x y)
  (let ((quot (make-connector)))
    (multiplier quot y x)
    quot))

(define (celsius-fahrenheit-converter x)
  (c+ (c* (c/ (cv 9) (cv 5))
          x)
      (cv 32)))
(define C (make-connector))
(define F (celsius-fahrenheit-converter C))
(probe "celsius" C)
(probe "fahrenheit" F)
(set-value! F 212 'user)
