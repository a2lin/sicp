(define (reverse-right sequence)
  (fold-right (lambda (x y) (append y (list x))) () sequence))
(define (reverse-left sequence)
  (fold-left (lambda (x y) (cons y x)) () sequence)) 

(define sequence (list 1 2 3 4))
(reverse-right sequence)
(reverse-left sequence)
