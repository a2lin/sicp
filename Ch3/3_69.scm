(define (triples s t u)
  (stream-cons (list (stream-car s) (stream-car t) (stream-car u))
               (interleave
                 (stream-map (lambda (x y) (list (stream-car s) x y)) stream-cdr 
                 (triples s (stream-cdr t) (stream-cdr u)))))
