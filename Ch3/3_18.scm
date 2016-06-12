(define (cycle-detect li)
  (define (in-list x li)
    (if (null? li)
      #f
      (if (eq? x (car li))
        #t
        (cycle-detect x (cdr li)))))
  (let ((seen-pts '()))
    (define (cycle-detect-helper li)
      (cons seen-pts li)
      (if (in-list (cdr li) seen-pts)
        #t
        (cycle-detect-helper (cdr li)))))
    (cycle-detect-helper li))
