(load "stream_lib.scm")
(define (weighted-pairs s t weight)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (merge-weighted weight
                    (stream-map (lambda (x) (list (stream-car s) x))
                                (stream-cdr t))
                    (weighted-pairs (stream-cdr s) (stream-cdr t) weight))))

(define (pairs-filter stream)
  (cond ((stream-null? stream) '())
        ((= (stream-car stream) (stream-car (stream-cdr stream)) (stream-car (stream-cdr (stream-cdr stream))))
         (cons-stream (stream-car stream) (cons-stream (stream-car (stream-cdr stream)) (cons-stream (stream-car (stream-cdr (stream-cdr stream)))
                      (stream-filter
                        pred
                        (stream-cdr stream))))))
        (else (pairs-filter (stream-cdr stream)))))

(define (pairs-weight pair)
  (+ (* (car pair) (car pair)) (* (cadr pair) (cadr pair))))

(define (pairs)
  (pairs-filter
    (weighted-pairs (integers) (integers) (pairs-weight))))
