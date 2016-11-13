(load "stream_lib.scm")
(define (rand-update x)
  (modulo (+ (* x 1103515245) 12345) 32768))

(define random-init 0)

(define random-numbers
  (cons-stream
    random-init
    (stream-map rand-update random-numbers)))

(define (parse-command command)
  (cond ((equal? (car command) "generate") (list))
        (else (list (cdr command)))))

(define z (cons-stream 
            (cons "generate" '())
            (cons-stream
              (cons "generate" '())
              (cons-stream
                (cons "reset" 5)
                (cons-stream
                  (cons "generate" '())
                  (cons-stream
                    (cons "generate" '())
                    the-empty-stream))))))

(define (rand-cmd cmd-stream init)
  (define next
    (if (equal? cmd-stream the-empty-stream)
      the-empty-stream 
      (let ((test (parse-command (stream-car cmd-stream))))
        (cond ((equal? test the-empty-stream)
               (cons-stream
                 init
                 (rand-cmd (stream-cdr cmd-stream) (rand-update init))))
              (else
                (cons-stream
                  (car test)
                  (rand-cmd (stream-cdr cmd-stream) (rand-update (car test)))
                  )
                )
              )
        )
      )
    )
  next
  )
(rand-update 5)
(rand-update (rand-update 5))
(rand-update 3)
(take (rand-cmd z 3) 5)
