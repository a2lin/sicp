; this is an implementation of radix division.
; the function calculates num * radix over den for some radix.

; let's take (1, 7, 10) for example. We begin with  1 * 10/ 7, and this results in a quotient
; of 1 which is emitted, and 3 which continues.
; then 3*10/7 results in 4 which is emitted, and 2 which continues, and this proceeds
; ad infinitum because of streams.

; let's take 3, 8, 10 for example, and we end up with 30/8 -> 3 which is emitted, and 6
; which continues, then 7 emitted, 4 continues, etc.

; the more elements read, the more the radix is assumed to have been applied to the quotient
; initially. If we know what the original numeric versus the denominator was, we can use this
; to do decimal division.

; by changing the radix we can do division in different bases.
