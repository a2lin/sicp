; deque pair (contains start and end ptr)
(define (make-deque) cons('() '()))

; deque internal accessors
(define (front-ptr deque) (car deque))
(define (rear-ptr deque) (cdr deque))
(define (set-front-ptr! deque item) (set-car! deque item))
(define (set-rear-ptr! deque item) (set-cdr! deque item))

; custom 'item' type -> forward-ptr, item, rear-ptr
(define (create-item forward-ptr item reverse-ptr) (cons forward-ptr (cons item reverse-ptr)))
(define (retrieve-forward item) (car item))
(define (retrieve-reverse item) (cddr item))
(define (retrieve-item item) (cdar item))

; deque api
; deque queue accessors
(define (empty-deque? deque) (null? (front-ptr deque)))
(define (front-deque deque)
  (if (empty-deque? deque)
    (error "FRONT called with an empty deque" deque)
    (car (front-ptr deque))))
(define (rear-deque deque)
  (if (empty-deque? deque)
    (error "REAR called with an empty deque" deque)
    (car (rear-ptr deque))))

; deque insert modifiers
(define (front-insert-deque! deque ele)
  (let ((new-ele (create-item (front-ptr deque) ele '())))
    (cond (empty-queue? deque) (set-front-ptr! new-ele) (set-rear-ptr! new-ele)
          (else (set-front-ptr! new-pair)))))

(define (rear-insert-deque! deque ele)
  (let ((new-pair (create-item '() ele (rear-ptr deque))))
    (cond (empty-queue? deque) (set-front-ptr! new-pair) (set-rear-ptr! new-pair)
          (set-rear-ptr! new-pair))))

; deque delete modifiers
(define (front-delete-deque! deque)
  (cond ((null? (cdr (front-ptr deque))) (set-front-ptr! deque '()) (set-rear-ptr! deque '()))
        (else (set-front-ptr! deque (cdr front-ptr deque)))))
(define (rear-delete-deque! deque)
  (let ((prev-ele (retrieve-reverse (rear-ptr deque))))
    (cond ((null? prev-ele) (set-front-ptr! deque '()) (set-rear-ptr! deque '()))
          (else (set-rear-ptr! prev-ele)))))
