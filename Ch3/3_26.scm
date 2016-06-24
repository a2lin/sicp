(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right) (list entry left right))

(define (element-of-set x set)
  (cond ((null? set) '())
        ((= x (entry set)) entry)
        ((< x (entry set))
         (element-of-set? x (left-branch set)))
        ((> x (entry set))
         (element-of-set? x (right-branch set)))))

(define (adjoin-set x set)
  (cond ((null? set) (make-tree x '() '()))
        ((= x (entry set)) set)
        ((< x (entry set))
         (make-tree (entry set) 
                    (adjoin-set x (left-branch set))
                    (right-branch set)))
        ((> x (entry set))
         (make-tree (entry set)
                    (left-branch set)
                    (adjoin-set x (right-branch set))))))

(define assoc element-of-set)
(define (lookup key-list table)
  (define (lookup-helper key table)
    (let ((record (assoc key (cdr table))))
      (if record
        cdr record)))
  (cond ((null? key-list) #f)
        ((null? (cdr key-list)) (lookup-helper (car key-list) table))
        (else
          (let ((next-table (lookup-helper (car key-list) table)))
            (lookup (cdr key-list) (cdr next-table))))))

(define (insert! key-list value table)
  (define (insert-element key value)
    (let ((record (assoc key (cdr table))))
      (if record
        (set-cdr! record value)
        (set-cdr! table
                  (adjoin-set (cons key value) (cdr table))))))
  (define (insert-helper key)
    (let ((subtable (assoc key (cdr table))))
      (if subtable
        subtable
        (let ((new-table (adjoin-set (list key) (cdr table))))
          (set-cdr! table new-table)
          new-table))))
  (cond ((null? key-list) 'ok)
        ((null? (cdr key-list)) (insert-element (car key-list) value) 'ok)
        (else (insert! (cdr key-list) value (insert-helper (car key-list))))))


