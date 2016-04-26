(define (enumerate-interval a b)
  (if (> a b)
    ()
    (append (list a) (enumerate-interval (+ 1 a) b))))

(define (accumulate fn initial seq)
    (if (null? seq)
        initial
        (fn (car seq)
            (accumulate fn initial (cdr seq)))))

(define (flatmap proc seq)
    (accumulate append () (map proc seq)))

(define (safe? k positions)
  (if (null? positions)
    #t
    (if (= k (cadar positions))
      (let ((kpos (car positions)))
          (= 0 (let ((x (car kpos))
                     (y (cadr kpos)))
                     (accumulate (lambda (pos acc) (+ acc (let ((posx (car pos))
                                                                (posy (cadr pos)))
                                                                (cond ((and (= x posx) (= y posy)) 0) 
                                                                      ((= x posx) 1)
                                                                      ((= y posy) 1)
                                                                      ((= (- (abs (- posx x)) (abs (- posy y))) 0) 1)
                                                                      (else 0)))))
                              0
                              positions))))
     (safe? k (cdr positions))
  )))

(define (adjoin-position new-row k rest-of-queens)
  (append (list (list new-row k)) rest-of-queens))

(define empty-board ())

(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
            (lambda (positions) (safe? k positions))
            (flatmap
              (lambda (rest-of-queens)
                (map (lambda (new-row)
                       (adjoin-position new-row k rest-of-queens))
                     (enumerate-interval 1 board-size)))
              (queen-cols (- k 1))))))
  (queen-cols board-size))

(queens 8)
