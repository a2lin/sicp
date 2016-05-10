(load "2_67.scm")

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge pairs)
  (define (insert alist pair)
    (cond ((null? alist) (list pair))
          ((< (weight (car alist)) (weight pair)) (cons (car alist) (insert (cdr alist) pair)))
          (else (cons pair alist))
          ))
  (if (null? (cdr pairs))
    pairs
    (let ((left (car pairs))
          (right (cadr pairs)))
      (let ((tree (make-code-tree left right)))
        (successive-merge (insert (cddr pairs) tree))))))

;(successive-merge (make-leaf-set (list (list 'A 4) (list 'B 2) (list 'C 1) (list 'D 1))))
