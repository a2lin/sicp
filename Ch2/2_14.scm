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

(define (make-center-percent center percent-tolerance)
  (let ((tolerance (* center percent-tolerance)))
    (make-interval (+ center tolerance) (- center tolerance))))

(define (percent interval)
  (let ((midpoint (/ (+ (upper-bound interval) (lower-bound interval)) 2.0)))
    (/ (- (upper-bound interval) midpoint) midpoint)))

(define (center interval)
  (/ (+ (lower-bound interval) (upper-bound interval)) 2.0))

(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
                (add-interval r1 r2)))
(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval one
                  (add-interval (div-interval one r1)
                                (div-interval one r2)))))

(define (print-percent interval)
  (newline)
  (display (center interval))
  (display "+-")
  (display (percent interval))
  (display "%"))

(print-percent (par1 (make-center-percent 3 0.002) (make-center-percent 3 0.002)))
(print-percent (par2 (make-center-percent 3 0.002) (make-center-percent 3 0.002)))

