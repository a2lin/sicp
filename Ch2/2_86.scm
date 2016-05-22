; design:
; currently complex numbers currently use scheme-numbers for real part, imaginary part, magnitude, angle
; so we can just force-coerce everything into a real number.
; basicaly nothing can be complex otherwise we're going to have a circular defn problem.
; need to define sin/cos over rational, but we can just coerce rational -> real & do sin/cos over real nr

; alternatively we could just store random things inside & convert it upon retrieval
; actually lets not

(define (generic-sin x)
  (sin (contents (raise x 'real))))

(define (generic-cos x)
  (cos (contents (raise x 'real))))

(define (make-from-any-real-imag real imag)
  (let ((real-real (contents (raise 'real real)))
        (real-imag (contents (raise 'real imag))))
    ((get 'make-from-real-imag 'rectangular) real-real real-imag)))

(define (make-from-any-mag-ang r a)
  (let ((real-r (contents (raise 'real r)))
        (real-a (contents (raise 'real a))))
    ((get 'make-from-any-mag-ang 'polar) real-r real-a)))
