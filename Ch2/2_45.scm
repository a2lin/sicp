(define (split f1 f2)
  (define (internal-split painter n)
    (if (= n 0)
      painter
      (let ((smaller (internal-split painter (- n 1))))
        (f1 painter (f2 smaller smaller)))))
  internal-split
  )
