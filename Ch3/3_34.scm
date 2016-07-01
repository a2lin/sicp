; the flaw in this idea comes from the constraint system.
; The proposed system looks like this:

(load "3_33_runner.scm")
(define (squarer a b)
  (multiplier a a b))

(define A (make-connector))
(define B (make-connector))
(squarer A B)
(probe "A" A)
(probe "B" B)

(set-value! B 25 'user)

; as you can see, this system only goes forwards (change A, get changed B).
; if we try to make it go backwards by setting B, it will complain that A is not set
; as multiplier needs the end result and one of the operands to go backwards.
