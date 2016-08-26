(define (make-zero-crossings input-stream old-avpt last-value)
  (let ((avpt (/ (+ (stream-car input-stream)
                    last-value)
                 2)))
    (cons-stream
      (sign-change-detector avpt old-avpt)
      (make-zero-crossings
        (stream-cdr input-stream) avpt (stream-car input-stream)))))
