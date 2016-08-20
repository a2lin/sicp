(load "stream_lib.scm")

(define (merge s1 s2)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else
          (let ((s1car (stream-car s1))
                (s2car (stream-car s2)))
            (cond ((< s1car s2car)
                   (cons-stream
                     s1car
                     (merge (stream-cdr s1) s2)))
                  ((> s1car s2car)
                   (cons-stream
                     s2car
                     (merge s1 (stream-cdr s2))))
                  (else
                    (cons-stream
                      s1car
                      (merge (stream-cdr s1)
                             (stream-cdr s2)))))))))

(define (merge-weighted weight s1 s2)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else
          (let ((s1car (stream-car s1))
                (s2car (stream-car s2)))
            (cond ((< (weight s1car) (weight s2car))
                   (cons-stream
                     s1car
                     (merge-weighted weight (stream-cdr s1) s2)))
                  ((> (weight s1car) (weight s2car))
                   (cons-stream
                     s2car
                     (merge-weighted weight s1 (stream-cdr s2))))
                  (else
                    (cons-stream
                      s1car
                      (cons-stream
                        s2car
                        (merge-weighted weight (stream-cdr s1)
                             (stream-cdr s2))))))))))

(define (pairs s t)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (interleave
      (stream-map (lambda (x) (list (stream-car s) x))
                  (stream-cdr t))
      (pairs (stream-cdr s) (stream-cdr t)))))

(define (weighted-pairs s t weight)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (merge-weighted weight
        (stream-map (lambda (x) (list (stream-car s) x))
                    (stream-cdr t))
        (weighted-pairs (stream-cdr s) (stream-cdr t) weight))))


(define (stream-filter pred stream)
  (cond ((stream-null? stream) '())
        ((pred (stream-car stream))
         (cons-stream (stream-car stream)
                      (stream-filter
                        pred
                        (stream-cdr stream))))
        (else (stream-filter pred (stream-cdr stream)))))

(define (problem-pairs s t weight f)
  (stream-filter f
    (cons-stream
        (list (stream-car s) (stream-car t))
        (merge-weighted weight
                        (stream-map (lambda (x) (list (stream-car s) x))
                                    (stream-cdr t))
                        (problem-pairs (stream-cdr s) (stream-cdr t) weight f)))))

(take (problem-pairs (integers) (integers) 
        (lambda (x) (+ (* 2 (car x)) (* 3 (cadr x)) (* 5 (car x) (cadr x)))) 
        (lambda (x) (not (or (remainder (car x) 3) (remainder (car x) 5) (remainder (car x) 2)
                             (remainder (cadr x) 3) (remainder (cadr x) 5) (remainder (cadr x) 2))))) 10)
;(take (weighted-pairs (integers) (integers) (lambda (x) (+ (car x) (cadr x)))) 10)
