; a) we have 6 possible orders:
; a b c -> 100 (+ 10 - 20 ) / 2 = 45
; a c b -> 100 + 10 / 2 - 20 = 35
; b a c -> 100 - 20 + 10 / 2 = 45
; b c a -> 100 - 20 / 2 + 10 = 50
; c a b -> 100 / 2 + 10 - 20 = 40
; c b a -> 100 / 2 - 20 + 10 = 40

; so the distinct values are 35, 40, 45, 50

; b) if we relax the condition that allows the processes to be interleaved, we have even more possibilities.

; try this on for size::
; we can potentially get 110.
; 100 
; a checks, sees 100, b checks, sees 100, c checks, sees 100
; b replaces 100 with 80
; c replaces 100 with 50
; a replaces 100 with 110

; many more are possible.
