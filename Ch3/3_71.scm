(load "stream_lib.scm")
(define (weighted-pairs s t weight)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (merge-weighted weight
                    (stream-map (lambda (x) (list (stream-car s) x))
                                (stream-cdr t))
                    (weighted-pairs (stream-cdr s) (stream-cdr t) weight))))

(define (ramanujan-filter stream)
  (cond ((stream-null? stream) '())
        ((= (stream-car stream) (stream-car (stream-cdr stream)))
               (cons-stream (stream-car stream)
                            (stream-filter
                              pred
                              (stream-cdr stream))))
         (else (ramanujan-filter (stream-cdr stream)))))

(define (ramanujan-weight pair)
  (* (car pair) (car pair) (car pair) (cadr pair) (cadr pair) (cadr pair))

(define (ramanujan)
  (ramanujan-filter
    (weighted-pairs (integers) (integers) ramanujan-weight)))

(take (ramanujan) 2)
