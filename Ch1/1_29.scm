(define (cube x)
  (* x x x))

(define (simpson f a b n)
  (define (next c k n)
    (cond ((= k n) 1)
          ((= c 1) 4)
          ((= c 2) 4)
          ((= c 4) 2)))
  (define h
    (* (/ (- b a) n)))
  (define (iter acc c k)
    (cond ((= k n) acc)
          (else (iter (+ acc (* c (f (+ a (* k h))))) (next c k n) (+ 1 k)))))
  (* (/ h 3) (iter 0 1 0)))

(simpson cube 0 1 1000)
