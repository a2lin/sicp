(load "stream_lib.scm")
(define (rand-update x)
  (modulo (+ (* x 1103515245) 12345) 32768))

(define random-init 0)

(define random-numbers
  (cons-stream
    random-init
    (stream-map rand-update random-numbers)))


(define (parse-command-stream command-stream)
  (stream-map 
    (lambda (x) 
      (cond ((eq? (car x) "generate") ('()))
            (list (cdr x)))) command-stream))

(define z (cons-stream 
            (cons "generate" '())
            (cons-stream
              (cons "reset" 5)
              (cons-stream
                (cons "generate" '())
                the-empty-stream))))


(take (parse-command-stream z) 3)
