;
;(try try)

; (define (run-forever) (run-forever))
; (define (try p)
;   (if (halts? p p) (run-forever) 'halted))

; this is a problem because if we could detect that it halted
; then we would make it run forever, and if we detected
; that it didn't run forever, we would halt;
; and the second implementation of try would run the opposite
; of the first, but if the first wouldn't halt, then it wouldn't
; do what the second intended.
