(define (all x)
  (if (null? x)

(define (=polyzero? val)
  (if (eq? (type-tag val) 'polynomial)
    (let ((polycoeff (coeff (contents val))))
      (all (map =polyzero? coeff))
