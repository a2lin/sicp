(define (triples s t u)
  (cons-stream
    (list (stream-car s) (stream-car t) (stream-car u))
    (interleave
        (interleave
          (stream-map (lambda (x) (list (stream-car s) (stream-car t) x))
                        (stream-cdr u))
          (triples s (stream-cdr t) (stream-cdr u)))
        (triples (stream-cdr s) (stream-cdr t) (stream-cdr u)))))
