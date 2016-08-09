;3.66
; (1, 1) -> interleave (1, inf) + (2,2)
; (2,2) -> interleave (2, inf) + (3,3)
; so we know it's like 
; 1,1 1,2 1,3
;     2,2 2,3
;         3,3

; so before (1,100) we should see (2,99) (3,98) (4,97)...
; e.g. n*(n+1)/2 with 100
; +1 from the (99, 99) triangle?

; before (100, 100) we should see (1, 200)
; e.g. n*(n+1)/2 again with 200

; we can see that this could be triangular for us too
; just minus 1 from the (100,100) triangle
