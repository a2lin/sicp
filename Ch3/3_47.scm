(define (make-mutex)
  (let ((cell (list false)))
    (define (the-mutex m)
      (cond ((eq? m 'acquire)
             (if (test-and-set! cell)
               (the-mutex 'acquire))) ; retry
            ((eq? m 'release) (clear! cell))))
    the-mutex))
(define (clear! cell) (set-car! cell #f))

(define (test-and-set! cell)
  (if (car cell) #t (begin (set-car! cell true) false)))

(define (make-semaphore n)
  (let ((master-number n)
        (master-mutex make-mutex))
    (define (the-semaphore m)
      (cond ((eq? m 'acquire)
             (master-mutex 'acquire)
             (

(define (test-and-set
