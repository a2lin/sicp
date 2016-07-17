; if test-and-set is not atomic it suffers from the same problems everything
; else does; where in a multiprocessed environment the tests both occur, and
; then the sets occur, leading to both operations running at the same time.

; the entire usefulness of test-and-set relies upon its atomicity.
