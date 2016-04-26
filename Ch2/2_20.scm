(define (same-parity first . rest)
  (define (same-parity-int acc first rest)
    (if (null? rest)
      acc
      (if (= (remainder first 2) (remainder (car rest) 2))
        (same-parity-int (append acc (list (car rest))) first (cdr rest))
        (same-parity-int acc first (cdr rest)))
    ))
  (same-parity-int (list first) first rest)
)

(same-parity 1 2 3 4 5 6 7)
(same-parity 2 3 4 5 6 7)
