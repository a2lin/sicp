(define (try-coercion type-tags args op)
  (define (try-type types-to-try type-tags args op)
    (define (coerce-list type type-tags args)
      (if (null? type-tags)
        '()
        (let ((t1 (car type-tags)))
          (let ((t1->type (get-coercion t1 type)))
            (cond (t1->type 
                    (let ((coerced-rest (coerce-list type (cdr type-tags) (cdr args))))
                      (if (not (eq? coerced-list 'error))
                        (cons (t1->type (car args)) 
                              coerced-rest))))
                  (else 'error)))
        )))
    (if (null? types-to-try)
      'error
      (let ((proc (get op (car types-to-try) (car types-to-try))))
        (if (null? proc)
          (try-type (cdr types-to-try) type-tags args op)
          (let ((coerced-list (coerce-list (car types-to-try) type-tags args)))
            (if (eq? coerced-list 'error)
              (try-type cdr(types-to-try) type-tags args)
              (apply proc coerced-list)))))))
  (let ((response (try-type type-tags type-tags args op)))
    (cond ((eq? response 'error) (error "No method for these types"))
          (else response))))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (try-coercion type-tags args op)))

; evidently this method of coercion does not allow for mixed-argument operations,
; and therefore if the operation is mixed-argument we are going to have a problem
; similarly there are cases where two arguments can go through a 'double coercion'
; as in there is an operation for 'type 3' but we can coerce to at most 'type 2'
; (e.g. hierarchy is type3->type2->type1 and we have one type1 and one type2 object)
