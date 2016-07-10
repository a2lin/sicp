; if we serialize it as shown in 3.39,
; we have the following ones that remain:
; P1 squares 10 and then s sets to 101
; P accesses 10, s sets to 11, p squares for 100
; s sets to 11, p squares it for 121
; we can also get 110 because * x x is not guarded
; the only one that is not possible anymore is 11, as p2 cannot be split.
