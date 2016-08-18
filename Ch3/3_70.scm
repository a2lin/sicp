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
      (merge-weighted weight
        (stream-map (lambda (x) (list (stream-car s) x))
                    (stream-cdr t))
        (stream-map (lambda (x) (list x (stream-car s)))
                    (stream-cdr t)))
      (pairs (stream-cdr s) (stream-cdr t)))))

(take (weighted-pairs (integers) (integers) (lambda (x) (+ (car x) (cadr x)))) 10)
