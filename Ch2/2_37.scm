(define (accumulate fn initial sequence)
  (if (null? sequence)
    initial
    (fn (car sequence)
        (accumulate fn initial (cdr sequence)))))

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
    ()
    (cons (accumulate op init (map car seqs))
          (accumulate-n op init (map cdr seqs)))))

(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(define (matrix-*-vector m v)
  (map (lambda (x) (dot-product x v)) m))

(define (transpose mat)
  (accumulate-n cons () mat))

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (x) (matrix-*-vector n x)) m)))

(define matrix (list (list 1 2 3 4) (list 4 5 6 6) (list 6 7 8 9)))
(define vec (list 1 1 1 1))
(matrix-*-vector matrix vec)
(transpose matrix)
(matrix-*-matrix matrix matrix)
