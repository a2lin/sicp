(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define (origin-frame-1 frame)
  (car frame))

(define (edge1-frame-1 frame)
  (cdar frame))

(define (edge2-frame-1 frame)
  (cddar frame))


(define (make-frame origin edge1 edge2)
  (cons origin (cons edge1 edge2)))

(define (origin-frame-2 frame)
  (car frame))

(define (edge1-frame-2 frame)
  (cdar frame))

(define (edge2-frame-2 frame)
  (cddr frame))
