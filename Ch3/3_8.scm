(define (f-helper)
  (let ((bool 0))
    (lambda (x)
      (if (= bool 0)
        (begin (set! bool 1)
               x)
        (begin (set! bool 0)
               0)))))
(define f (f-helper))
(+ (f 0) (f 1))
(+ (f 1) (f 0))