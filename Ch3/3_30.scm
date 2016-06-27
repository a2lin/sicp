(define (ripple-carry-adder n ak bk sk c)
  (if (null? ak)
    'ok
    ((full-adder (car ak) (car bk) c sk c)
     (ripple-carry-adder (n-1) (cdr ak) (cdr bk) (cdr sk) c))))

; for each n bit, we will have one FA delay, so after n bits we will have n FA delays.
; one FA delay is 2 HA delays + 1 OR delay. 1 HA delay is 2 AND delays and 1 OR delay and 1 NEGATE delay.
; therefore 1 FA delay is two + one OR delays + four AND delays + two NEGATE DELAY
; or 3 OR, 4 AND, 2 NGT.
; so for n FAs it's 3n OR, 4n AND, 2n NGT.
