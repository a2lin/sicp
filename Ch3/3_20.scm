; x -> (1 2)
; z -> ((1 2) (1 2))
;         x     x
; (set-car! (cdr z) 17)
; cdr z is x
; set the car of x to 17
; x -> (17 2)
; z -> ((17 2) (17 2))
; (car x) is therefore 17.
