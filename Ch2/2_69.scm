(load "2_67.scm")

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge pairs)
  (if (null? (cdr pairs))
    pairs
    (let ((left (car pairs))
          (right (cadr pairs)))
      (let ((tree (make-code-tree left right)))
        (successive-merge (adjoin-set tree (cddr pairs)))
        ))))
;(successive-merge (make-leaf-set (list (list 'A 4) (list 'B 2) (list 'C 1) (list 'D 1))))
