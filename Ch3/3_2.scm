(define (make-monitored f)
  (let ((calls 0))
    (lambda (x)
      (if (eq? x 'how-many-calls?)
        calls  
        (begin
          (set! calls (+ 1 calls))
          (f x))))))

(define s (make-monitored sqrt))
(s 100)
(s 'how-many-calls?)
