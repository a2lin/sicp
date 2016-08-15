(define (pairs s t) 
  (interleave (stream-map 
                (lambda (x) 
                  (list (stream-car s) x)) t)
              (pairs (stream-cdr s) (stream-cdr t))))

; (pairs integers integers)
; stream-map-> lambda(x), (list (stream-car s) x)), integers
; this makes (1, 1), (1, 2), (1, 3), (1, 4), ...
; then you interleave this with (2, 2)->
; (2, 2), (2, 3), (2, 4), (2, 5)
; seems to work fine..?

; but there is trouble in paradise: interleave needs the first argument
; of both streams, as this is the contract # needs a stream-promise.
; but there is no stream-promise as we will continually stream-cdr ourselves trying
; to get both arguments to interleave to stay put.
; infinite loop// recursive.
