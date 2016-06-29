; evidently lifo != fifo
; since the 'actions' are SETs on the final wire value, we have
; the following:

; start with (0, 1)
; next step -> first wire goes to 1.
; 1&1 = 1, so put 1 into the agenda for t->and-delay
; step after that -> second wire goes to 0.
; we have 1&0 -> second wire goes to 0, so put 0 into the agenda for t->and-delay.

; if we do lifo, we will see 1.
; if we do fifo, we will see 0.
