(define (make-queue)
  (let ((front-ptr '())
        (rear-ptr '()))
    (define (set-front-ptr! item)
      (set! front-ptr item))
    (define (set-rear-ptr! item)
      (set! rear-ptr item))
    (define (empty-queue?)
      (null? front-ptr))
    (define (insert-queue!)
      (lambda (item)
        (let ((new-pair (cons item '()))) 
            (cond ((empty-queue?) (set-front-ptr! new-pair) (set-rear-ptr! new-pair))
                  (else (set-cdr! rear-ptr new-pair) (set-rear-ptr! new-pair))))))
    (define (delete-queue!)
      (cond ((empty-queue?) (error "DELETE! called with an empty queue"))
            (else (set-front-ptr! (cdr front-ptr)))))
    (define (dispatch m) 
      (cond ((eq? m "insert") (insert-queue!))
            ((eq? m "delete") (delete-queue!))))
    dispatch))
