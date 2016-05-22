; projection operations.
(define (project-complex->real x)
  (apply-tag 'real (real-part x)))
    
(define (project-real->integer x)
  (apply-tag 'integer (round x)))

(put project-complex->real 'project 'complex)
(put project-real->integer 'project 'real)

(define (drop x)
    (let ((project-x (get 'project (type-tag x))))
          (if (null? project-x )
            x
            (let ((projected-val (project-x x)))
              (if (eq? x (successive-raise projected-val (type-tag projected-val)) )
                (drop projected-val)
                projected-val)))))

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
                  (drop (apply-generic op a1 a2))
                  (error "No methods for these types"
                         (list type-to-coerce type-to-coerce)))))))))))
