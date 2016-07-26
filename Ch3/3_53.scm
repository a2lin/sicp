(load "3_50.scm")
(load "3_52.scm")
(define (add-streams s1 s2) (stream-map-mult + s1 s2))
(define s (cons-stream 1 (add-streams s s)))
; prediction is that this is:
; powers of 2 (e.g. 1, 2, 4, 8)
