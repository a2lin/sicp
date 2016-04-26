(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

(define (make-segment start end)
  (cons start end))
(define (start-segment segment)
  (car segment))
(define (end-segment segment)
  (cdr segment))

(define (make-point x y)
  (cons x y))
(define (x-point point)
  (car point))
(define (y-point point)
  (cdr point))

(define (midpoint-segment segment)
  (let ((startX (x-point (start-segment segment)))
        (startY (y-point (start-segment segment)))
        (endX (x-point (end-segment segment)))
        (endY (y-point (end-segment segment))))
    (make-point (/ (+ startX endX) 2) (/ (+ startY endY) 2))))

(print-point (midpoint-segment (make-segment (make-point 1 2) (make-point 3 4)))) 


