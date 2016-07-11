; if x is 10, we have 2 procedures that do the following
; 1: 2 accesses, then a SET
; 2: 3 accesses, then a SET.

; 10^6 -> 10*10, then 100*100*100. (or vice-versa)
; 10^4 -> 10 * (10*10*10) (second procedure finishes in between first procedure accesses)
; 10^2 -> 10 * 10 | 10*10*10 -> 100 set after (overwrite)
; 10^3 -> 10*10 | 10*10*10 -> 1000 set after (overwrite)
; 10^5 -> 10*100*100 ( second, third accesses after first procedure finishes)
; 10 ^ 4 -> 10*10*100 -> (third access after first procedure finishes)
