;3.66
; the previous response was incorrect.

; the order (due to interleaving)
; looks something like a a b a b a b a c a b a c a b a d a
; where a indicates a memeber of the (1,x) series, b indicates
; a member of the (2,x) series, c indicates a member of the (3,x)
; series, and d indicates a member of the (4,x) series.

; as we can see, each value gets introduced (via 1,x), then gets one free
; cycle before it too begins to spawn off children that compete with it
; for 'spots'. As in, we can consider
; a to have 'n/2' spots as it interleaves with b. b then has 'n/2' spots
; of the original 'n/2' a spots as it interleaves with c.
; c then has 'n/2' of the 'n/2' b spots as it interleaves with d, and
; so on.

; therefore we can say roughly ~200 pairs before (1, 100), as we can expect
; roughly 1 in every 2 entries to be (1,x).

; the pattern seems to indicate that (n-1, n) should occur at 2^(n)-2^(n-2)-1, so in this case
; it should be 2^100-2^98-1

; we can expect(100, 100) to occur after ~2^100-1 entries, as each new introduction comes after 2^n entries.
; e.g. (2,2) comes after 2^1 entries, (3,3) after 2^2, and so on.

