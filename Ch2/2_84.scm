; provides raise
(load "2_83.scm")

; this algorithm will be pretty simple. whichever one is lower will see the 
; other type it gets raised to the top. So, we just get both tags
; and raise one while checking the other.

(define (which-higher a b)
  (let ((type-a (type-tag a))
        (type-b (type-tag b)))
    (define (max-raise a)
      (let ((raised-val ((get (type-tag a) 'raise) a)))
        (if (null? raised-val)
          type-a
          (if (eq? (type-tag raised-val) (type-b))
            type-b
            (max-raise raised-val)))))))

(define (successive-raise a type)
  (if (eq? (type-tag a) type)
    a
    (successive-raise ((get (type-tag a) 'raise) a) type)))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
        (apply proc (map contents args))
        (if (= (length args) 2)
          (let ((type-to-coerce (which-higher (car args) (cadr args))))
            (let ((a1 (successive-raise a1 type-to-coerce))
                  (a2 (successive-raise a2 type-to-coerce)))
              (let ((proc (get op (list type-to-coerce type-to-coerce))))
                (if proc
                  (apply-generic op a1 a2)
                  (error "No methods for these types"
                         (list type-to-coerce type-to-coerce)))))))))))
