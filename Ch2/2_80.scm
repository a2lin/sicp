; if we had equ from 2_79:
(load "2_79.scm")
(define (=zero? a)
  (apply-generic 'equ a (apply-generic 'sub a a)))

