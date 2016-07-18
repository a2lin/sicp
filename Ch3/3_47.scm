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
        (master-mutex-list (list))
        (master-mutex make-mutex))
    (define (the-semaphore m)
      (cond ((eq? m 'acquire)
             (master-mutex 'acquire)
             (- n 1)
             (if (< 0 n)
               (append (master-mutex-list) (list make-mutex)))
             (master-mutex 'release))
            ((eq? m 'release)
             (master-mutex 'acquire)
             (+ n 1)
             (if (and (> 0 n) (not (null? master-mutex-list)))
               (let (free-mutex (car master-mutex-list))
                 (set! master-mutex-list (cdr master-mutex-list))
                 (free-mutex 'release)
                 (master-mutex 'release))))))))

               


(define (test-and-sett
