(define (generic-raise x)
  ((get (type-tag x) 'raise) x))

(define (integer->rational x)
  ((get-coercion 'integer 'rational) x))

(define (rational->real x)
  ((get-coercion 'rational 'real) x))

(define (real->complex x)
  ((get-coercion 'real 'complex) x))

(put 'integer 'raise integer->rational)
(put 'rational 'raise rational->real)
(put 'real 'raise real->complex)
