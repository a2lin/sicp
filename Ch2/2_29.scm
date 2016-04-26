(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (car (cdr mobile)))

(define (branch-length branch)
    (car branch))

(define (branch-structure branch)
    (car (cdr branch)))

(define (total-weight mobile)
  (if (null? mobile)
    0
    (let ((lb (left-branch mobile))
          (rb (right-branch mobile)))
      (+ (branch-length lb) (branch-length rb) (total-weight (branch-structure lb)) (total-weight (branch-structure rb))))))

(define (is-balanced mobile)
  (if (null? mobile)
    #t
    (let ((lb (left-branch mobile))
          (rb (right-branch mobile)))
      (and (= (branch-length lb) (branch-length rb)) (is-balanced (branch-structure lb)) (is-balanced (branch-structure rb))))))
