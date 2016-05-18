(define (=zero? a)
  (apply-generic 'zero a))

(define (equ? a b)
  (=zero? (apply-generic 'sub a b)))

; could also do something like
(define (equ? a b)
  (apply-generic 'equ a b))

(define (equ-scheme-num a b)
  (= a b))

(define (equ-rat-num a b)
  (and (= (numer a) (numer b)) (= (denom a) (denom b))))

(define (equ-complex-num a b)
  (and (= (real-part a) (real-part b)) (= (imag-part a) (imag-part b))))

(put 'equ 'scheme-num equ-scheme-num)
(put 'equ 'rational equ-rat-num)
(put 'equ 'complex equ-complex-num)
