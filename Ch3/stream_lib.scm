;cribbed from stackoverflow http://stackoverflow.com/questions/14640833/how-is-the-sicp-cons-stream-implemented
(define (memo-func function)
  (let ((already-run? false)
        (result false))
    (lambda ()
      (if (not already-run?)
          (begin (set! result (function))
                 (set! already-run? true)
                 result)
          result))))


(define-syntax delay
  (syntax-rules ()
    ((delay exp)
     (memo-func (lambda () exp)))))

(define (force function)
  (function))

(define the-empty-stream '())
(define (stream-null? stream) (null? stream))
(define (stream-car stream) (car stream))
(define (stream-cdr stream) (force (cdr stream)))

(define-syntax cons-stream
  (syntax-rules ()
    ((cons-stream a b)
     (cons a (memo-func (lambda () b))))))
;end cribbing

(define (stream-map proc . argstreams)
    (if (stream-null? (car argstreams))
      the-empty-stream
      (cons-stream
        (apply proc (map stream-car argstreams))
        (apply stream-map
               (cons proc (map stream-cdr argstreams))))))

(define (stream-ref s n)
  (if (= n 0)
    (stream-car s)
    (stream-ref (stream-cdr s) (- n 1))))

(define (stream-enumerate-interval low high)
  (if (> low high)
    the-empty-stream
    (cons-stream
      low
      (stream-enumerate-interval (+ low 1) high))))

(define (display-line x)
  (display x)
  (newline))

(define (show x)
  (display-line x)
  x)

(define (stream-for-each proc s) 
  (if (stream-null? s)
    'done
    (begin (proc (stream-car s))
           (stream-for-each proc (stream-cdr s)))))

(define (display-stream s) (stream-for-each display-line s))
(define (ones) (cons-stream 1 (ones)))
(define (integers) (cons-stream 1 (add-streams (ones) (integers))))
(define (add-streams s1 s2) (stream-map + s1 s2))
(define (take stream count)
    (newline)
    (cond ((= count 0) '())
          (else (show (stream-car stream)) (take (stream-cdr stream) (- count 1)))))

(define (scale-stream stream factor) 
  (stream-map (lambda (x) (* x factor))
              stream))

(define (interleave s1 s2)
  (if (stream-null? s1)
    s2
    (cons-stream (stream-car s1)
                 (interleave s2 (stream-cdr s1)))))
