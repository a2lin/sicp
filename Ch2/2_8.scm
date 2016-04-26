(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (mul-interval x
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y)))))

(define (make-interval a b) (cons a b))
(define (upper-bound interval)
    (cdr interval))
(define (lower-bound interval)
  (car interval))

(define (sub-interval a b)
  (let ((l1 (lower-bound a))
        (l2 (lower-bound b))
        (r1 (upper-bound a))
        (r2 (upper-bound b)))
    (make-interval (- l1 r2) (- r1 l2))))

(sub-interval (make-interval 1 3) (make-interval 5 7))
