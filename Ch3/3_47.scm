(define (make-mutex)
  (let ((cell (list #f)))
    (define (the-mutex m)
      (cond ((eq? m 'acquire)
             (if (test-and-set! cell)
               (the-mutex 'acquire))) ; retry
            ((eq? m 'release) (clear! cell))))
    the-mutex))
(define (clear! cell) (set-car! cell #f))

(define (test-and-set! cell)
  (if (car cell) #t (begin (set-car! cell #t) #f)))

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

; we're going to make a list of test-and-set cells
; and go along them #busywaitin' until we find an empty one.
(define (make-semaphore-test-set n)
  (define (make-cells n cells)
    (if (eq? n 0) 
      cells
      (cons #f (make-cells (- n 1) cells))))
  (let ((cell-list (make-cells n))
        ; we need a 'test-and-set' that synchronizes
        ; operations on our semaphore, this way we avoid
        ; getting into undesired states.
        (master-cell (list #f)))

    (define (clear! cell) (set-car! cell #f))
    (define (occupy! cell) (set-car! cell #t))

    (define (release-sempahore)
      (define (actual-release cell-head)
        ; if there's nothing left to free, we're in an invalid state
        ; since we the freers should always be able to free
        (if (null? cell-head)
          (error "Semaphore is in an invalid state, cannot release unchecked semaphore")
          ; if it's occupied, should just free it (we don't care which one is which)
          (if (car cell-head)
            (clear! cell-head)
            ; otherwise, we need to check the other ones. in correct operation, we always
            ; are able to find one eventually.
            (actual-release (cdr cell-head)))))
      (actual-release cell-list)
      (clear! master-cell))

    (define (acquire-semaphore)
      (define (actual-acquire cell-head)
        (if (null? cell-head)
          ; if we have no more cells to test acquires, we need to start over and wait in line.
          ; clear first, this way we can give the cell over to a 'freer'. otherwise
          ; we will deadlock for sure.
          (begin (clear! master-cell) (the-semaphore 'acquire))
          (if (car cell-head)
            ; someone is in this cell, we need to move on
            (actual-acquire (cdr cell-head))
            ; we can set this, cell is free.
            (occupy! cell-head))))
      (actual-acquire cell-list)
      ; free so we don't deadlock
      (clear! master-cell))

    (define (the-semaphore s)
      (cond ((eq? m 'acquire)
             (if (test-and-set! master-cell)
               (the-semaphore 'acquire) 
               (acquire-semaphore)))
            ((eq? m 'release)
             (if (test-and-set! master-cell)
               (the-semaphore 'release)
               (release-semaphore)))))))

