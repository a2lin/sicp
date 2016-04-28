; graphics 
(define device (make-graphics-device (car (enumerate-graphics-types))))
(define (draw-line pointA pointB)
  (graphics-draw-line device (car pointA) (cdr pointA) (car pointB) (cdr pointB)))

; vector math
(define (make-vect x y)
    (cons x y))
(define (xcor-vect vect)
    (car vect))
(define (ycor-vect vect)
    (cdr vect))
(define (add-vect vec1 vec2)
    (make-vect (+ (xcor-vect vec1) (xcor-vect vec2)) (+ (ycor-vect vec1) (ycor-vect vec2))))
(define (sub-vect vec1 vec2)
    (make-vect (- (xcor-vect vec1) (xcor-vect vec2)) (- (ycor-vect vec1) (ycor-vect vec2))))
(define (scale-vect scalar vec)
    (make-vect (* scalar (xcor-vect vec)) (* scalar (ycor-vect vec))))

; segment accessors
(define (make-segment vec1 vec2)
    (cons vec1 vec2))
(define (start-segment segment)
    (car segment))
(define (end-segment segment)
    (cdr segment))

; frame accesssors
(define (origin-frame frame)
  (car frame))
(define (edge1-frame frame)
  (cadr frame))
(define (edge2-frame frame)
  (cddr frame))

; frame coordinate map
(define (frame-coord-map frame)
  (lambda (v)
    (add-vect
      (origin-frame frame)
      (add-vect (scale-vect (xcor-vect v)
                            (edge1-frame frame))
                (scale-vect (ycor-vect v)
                            (edge2-frame frame))))))

(define (make-frame origin edge1 edge2)
  (cons origin (cons edge1 edge2)))

(define base-frame
  (make-frame (make-vect -1 -1) (make-vect 2 0) (make-vect 0 2)))

; segment painter
(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
      (lambda (segment)
        (draw-line
          ((frame-coord-map frame) (start-segment segment))
          ((frame-coord-map frame) (end-segment segment))))
      segment-list)))

; painter definitions

; outline painter
(define outline-painter 
  (list (make-segment (make-vect 0 0) (make-vect 1 0))
        (make-segment (make-vect 1 0) (make-vect 1 1))
        (make-segment (make-vect 1 1) (make-vect 0 1))
        (make-segment (make-vect 0 1) (make-vect 0 0))))

(define x-painter
  (list (make-segment (make-vect 0 0) (make-vect 1 1))
        (make-segment (make-vect 0 1) (make-vect 1 0))))

(define diamond-painter
  (list (make-segment (make-vect 0.5 0) (make-vect 1 0.5))
        (make-segment (make-vect 1 0.5) (make-vect 0.5 1))
        (make-segment (make-vect 0.5 1) (make-vect 0 0.5))
        (make-segment (make-vect 0 0.5) (make-vect 0.5 0))))

(define wave
  (list (make-segment (make-vect 0 0.8) (make-vect 0 0.7))
        (make-segment (make-vect 0 0.7) (make-vect 0.2 0.5))
        (make-segment (make-vect 0.2 0.5) (make-vect 0.3 0.65))
        (make-segment (make-vect 0.3 0.65) (make-vect 0.35 0.57))
        (make-segment (make-vect 0.35 0.57) (make-vect 0.3 0))
        (make-segment (make-vect 0.3 0) (make-vect 0.4 0))
        (make-segment (make-vect 0.4 0) (make-vect 0.52 0.3))
        (make-segment (make-vect 0.52 0.3) (make-vect 0.65 0))
        (make-segment (make-vect 0.65 0) (make-vect 0.75 0))
        (make-segment (make-vect 0.75 0) (make-vect 0.65 0.5))
        (make-segment (make-vect 0.65 0.5) (make-vect 1 0.2))
        (make-segment (make-vect 1 0.2) (make-vect 1 0.4))
        (make-segment (make-vect 1 0.4) (make-vect 0.7 0.7))
        (make-segment (make-vect 0.7 0.7) (make-vect 0.55 0.7))
        (make-segment (make-vect 0.55 0.7) (make-vect 0.6 0.85))
        (make-segment (make-vect 0.6 0.85) (make-vect 0.55 1))
        (make-segment (make-vect 0.55 1) (make-vect 0.4 1))
        (make-segment (make-vect 0.4 1) (make-vect 0.35 0.85))
        (make-segment (make-vect 0.35 0.85) (make-vect 0.4 0.7))
        (make-segment (make-vect 0.4 0.7) (make-vect 0.35 0.7))
        (make-segment (make-vect 0.35 0.7) (make-vect 0.2 0.65))
        (make-segment (make-vect 0.2 0.65) (make-vect 0 0.8))
        ))

;((segments->painter wave) base-frame)
