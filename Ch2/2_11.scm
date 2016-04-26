(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
  (define (neg? v)
    (< 0 v))
  (define (pos? v)
    (>= 0 v))
  (let ((lx (lower-bound x))
        (ly (lower-bound y))
        (ux (upper-bound x))
        (uy (upper-bound y)))
    (cond ((and (neg? lx) (neg? ly) (neg? ux) (neg? uy)) (make-interval (* lx ly) (* ux uy)))
          ((and (pos? lx) (pos? ly) (pos? ux) (pos? uy)) (make-interval (* ux uy) (* lx ly)))
          ((and (neg? lx) (neg? ly) (neg? ux) (pos? uy)) (make-interval (* lx ly) (* lx uy)))
          ((and (neg? lx) (neg? ly) (pos? ux) (neg? uy)) (make-interval (* lx ly) (* ux ly)))
          ((and (neg? lx) (pos? ly) (pos? ux) (pos? uy)) (make-interval (* ux uy) (* lx uy)))
          ((and (pos? lx) (neg? ly) (pos? ux) (pos? uy)) (make-interval (* ux uy) (* ux ly)))
          ((and (neg? lx) (pos? ly) (neg? ux) (pos? uy)) (make-interval (* ux ly) (* lx uy)))
          ((and (pos? lx) (neg? ly) (pos? ux) (neg? uy)) (make-interval (* lx uy) (* ux ly)))
          ((and (neg? lx) (neg? ly) (pos? ux) (pos? uy)) (make-interval (max (* lx ly) (* ux uy)) (min (* ux ly) (* lx uy))))
          )
    )
  )

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

(mul-interval (make-interval 3 7) (make-interval -2 -1))
