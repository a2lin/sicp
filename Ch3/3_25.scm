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
                  (cons (cons key value) (cdr table))))))
  (define (insert-helper key)
    (let ((subtable (assoc key (cdr table))))
      (if subtable
        subtable
        (let ((new-table (cons (list key) (cdr table))))
          (set-cdr! table new-table)
          new-table))))
  (cond ((null? key-list) 'ok)
        ((null? (cdr key-list)) (insert-element (car key-list) value) 'ok)
        (else (insert! (cdr key-list) value (insert-helper (car key-list))))))
