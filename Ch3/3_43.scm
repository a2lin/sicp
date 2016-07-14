; if the processes are run sequentially, the acct balances are 10, 20, 30 in some order.
; in the first version, we could do the following:
; a exchange 1, 2 | b exchange 1, 3
; 1. a check account 1 balance
; 2. a check account 2 balance
; 3. b check account 1 balance
; 4. b check account 3 balance
; 5. a withdraw amt account 1
; 6. b withdraw amt account 1
; 7. a deposit amt account 2
; 8. b deposit amt account 3

; since the procedure itself is not synchronized, if multiple people access them
; we can interleave the accesses.

; in the second version, we can no longer do this, as the serializer is the combination of
; both serializers. (in effect, taking a lock on both accounts).
