(load "2_67.scm")

(define (encode message tree)
  (if (null? message)
    '()
    (append (encode-symbol (car message) tree)
            (encode (cdr message) tree))))

(define (encode-symbol symbol tree)
  (if (leaf? tree)
    (if (eq? (symbol-leaf tree) symbol)
      (list)
      #f)
    (let ((left (encode-symbol symbol (left-branch tree)))
          (right (encode-symbol symbol (right-branch tree))))
      (cond ((not (eq? #f left)) (cons 0 left ))
            ((not (eq? #f right)) (cons 1 right))
            (else #f)))))

;(encode (list 'A 'D 'A 'B 'B 'C 'A) sample-tree)
;0 1 1 0 0 1 0 1 0 1 1 1 0
