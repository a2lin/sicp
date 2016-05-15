; explicit-dispatch -> dispatch based on type
; data-directed -> dispatch based on type, operation
; message-passing -> dispatch based on operation

; don't use explicit-dispatch if a lot of types are going
; to be added, since each function is going to have to
; change for each type added. 

; don't use message-passing if a lot of operations are
; going to be added, since each described type is
; goign to have to change for each operation added.

; therefore for lots of types -> message-passing, data-directed
; for lots of operations -> explicit-dispatch, data-directed
