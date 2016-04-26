(define (for-each fn eles)
  (map fn eles))

(for-each (lambda (x) (newline) (display x))
          (list 57 321 88))
