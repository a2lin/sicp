(define (stream-map . argstreams)
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

(define (stream-car stream) (car stream))
(define (stream-cdr stream) (force (cdr stream)))
(define the-empty-stream '())
(define stream-null? null?)
(define (cons-stream a b)
  (cons a (delay b)))

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
(define (add-streams s1 s2) (stream-map + s1 s2))
(define (integers) (cons-stream 1 (add-streams ones integers)))
(define (ones) (cons-stream 1 ones))
