(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (accumulate op initial (cdr sequence)))))

(define (map p sequence)
  (accumulate (lambda (x y) (cons (p x) y)) () sequence))
(define (append seq1 seq2)
  (accumulate cons seq2 seq1))
(define (length sequence)
  (accumulate (lambda (x y) (+ 1 y)) 0 sequence))

(define testlist (list 1 2 3 4))
(define testlist2 (list 2 3 4 5))
(map (lambda (x) (+ 1 x)) testlist)
(append testlist testlist2)
(length testlist)
