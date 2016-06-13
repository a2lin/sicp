(define (constant-space-cycle-detect li)
  (let ((slow li) (fast li))
    (define (constant-helper)
        (if (eq? slow fast)
          #t
          (begin
            ((set! slow (cdr slow))
            (set! fast (cdr fast))
            (if (null? fast)
              #f
              (begin 
                ((set! fast (cdr fast))
                 (constant-helper))))))))))
