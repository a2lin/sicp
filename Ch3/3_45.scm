; we have a deadlock? (balance-serializer  (balanced-serializer deposit))
; may not let the current system re-acquire the balanced-serializer
; a re-entrant lock fixes this issue though.. so this depends on
; serializer implementation.
