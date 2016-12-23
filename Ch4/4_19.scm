; Looking at this:
; a = 1
; f(x) = (b = 1 + x), (a = 5), (a + b) = (1 + 5 + x)
; f(10) = (b = 1 + 10 = 11) (a = 5) (a + b) = 1 + 5 + 11 = 16

; it seems natural that in a procedural language ben's point should hold

; in _scheme_ though, due to mutual recursion alyssa is probably right. As noted
; in the text, it is most definitely easier to emit a simultaneous definition error...

; to implement this scheme as eva would like, we would need to extract the value of a and b
; to their own lambda; and write something that would execute as

(let ((a 1))
  (lambda (f x)
    (let ((a '*undefined*) (b '*undefined*))
      (set! b (+ a x))
      (set! a 5)
      (+ a b))
    (f 10)))

; hmm this doesn't really work.
; we need to make sure that a's defines come before b,
; so this will toss an error. (alyssa's impl.)

; but for eve's method to work, we need to scan out
; and put the set! for a above b; which would work
; if we built a DAG of dependencies within the defines
; falling back to the outer environment if there was no definition in 
; the current scope.

; so steps are 1. resolve internally (one pass)
; 2. any pure variables that are '*undefined* are 
; attempted to be resolved externally
; 3. compute defined expressions and assign
; 4. repeat with 1. until everything is assigned.
