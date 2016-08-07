(load "stream_lib.scm")
(define (absolute-value x)
  (if (< 0 x)
    (* -1 x)
    x))

(define (stream-limit stream tolerance)
  (if (< (absolute-value (- (stream-car stream) (stream-car (stream-cdr stream)))) tolerance)
    (stream-car (stream-cdr stream))
    (stream-limit (stream-cdr stream) tolerance)))
    
(define (sqrt x tolerance)
  (stream-limit (sqrt-stream x) tolerance))

