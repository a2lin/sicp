(define (ripple-carry-adder n ak bk sk c)
  (if (null? ak)
    'ok
    ((full-adder (car ak) (car bk) c sk c)
     (ripple-carry-adder (n-1) (cdr ak) (cdr bk) (cdr sk) c))))

; we know from previous that OR = AND + 2NEG
; FA's CARRY bit (the max determinator of the ripple carry adder) =
; one HA SUM + one HA CARRY + one OR delay.
; HA SUM is the greater of 2AND + NEG or OR + AND
; since OR + NEG = AND + 2NEG, we have 2AND + 2NEG vs 2AND + NEG, and 2AND + 2NEG is larger.
; HA CARRY is one AND delay.
; therefore the minimum delay to Carry is AND + 2AND + 2NEG + OR;
; or 3AND + 2 NEG + AND + 2NEG
; or 4AND + 4NEG.
; so it's 4n AND + 4n NEG?
