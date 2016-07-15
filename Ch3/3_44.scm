; in the exchange problem, the values of the accounts need to be accurate throughout the transaction
; since it's essentially two {withdraw, deposit} chunks together.

; in the transfer problem, the value of the account only needs to be accurate at the time of transaction.
; you'll still end up with the correct answer even if in the interim something happened to the account as long
; as the withdraw and deposit are synchronized.

; essentially, with exchange there's the possibility of the a1, a2, a1, a3 transfers causing a break between
; value identification and action.
; a1, a2 difference is calculated. a1, a3 difference is calculated.
; then all of them are applied.

; however with transfer there's essentially this:
; a1, a2, a1, a3
; a1, a2 withdraw-operation (value is changed).
; a1, a3 withdraw-operation (value is changed again).
; all checks are accompanied by the value-change so we don't have a problem. 
