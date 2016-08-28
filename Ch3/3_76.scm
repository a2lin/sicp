(load "stream_lib.scm")
(define (smooth stream)
    (cons-stream (/ (+ (stream-car stream) (stream-car (stream-cdr) stream)) 2)
                 (smooth (stream-cdr stream))))
(define (zero-crossings input-stream)
  (stream-map sign-change-detector input-stream (stream-cdr input-stream)))

(define (smooth-zero-crossings data)
  (zero-crossings (smooth data)))
