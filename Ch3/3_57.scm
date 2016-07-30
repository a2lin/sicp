; using the definition of fibs based on the add-streams procedure, we have:
; (define fibs
;    (cons-stream
;     0
;     (cons-stream 1 (add-streams (stream-cdr fibs) fibs))))

; with memoization we have the following:
; 0, <stream>
; 0, 1, stream<add <evaluated 1> <stream>>
; but 1 was evaluated and cached, so we have only 1 evaluation at this period.

; without memoization:
; now unfortunately if 1 is not evaluated we have 2 evaluations at this step.
; now that we have 2 evaluations, to get the next stream we have to evaluate the next stream,
; which causes 4 evaluations (as the top element is double-evaluated).
; and this continues exponentially.
