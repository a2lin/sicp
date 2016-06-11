(define (count-pairs x)
  (let ((seen-pairs '()))
    (define (count-pairs x)
      (if (not (pair? x))
        0
        (if (not (in-list x))
          (+ (count-pairs (car x))
             (count-pairs (cdr x))
             1)
          0)
        )
      )
    )
  )

; test list membership
(define (in-list x li)
  (if (null? li)
    #f
    (if (eq? (car li) x)
      #t
      (in-list x (cdr li)))))

