(define (list->tree elements)
    (car (partial-tree elements (length elements))))
(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result (partial-tree (cdr non-left-elts)
                                              right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts (cdr right-result)))
                (cons (make-tree this-entry left-tree right-tree)
                      remaining-elts))))))))

; this recursive building trees. split list in half. recurse on left half. recurse on left half
; after recursing l + r -> build l, r, c and return up.

;(partial-tree (list 1 3 5 7 9 11) 6)
;(list 5 (list 1 '() (list 3 '() '()) ) (list 9 (list 7 '() '()) (list 11 '() '())))  ; partial-tree

; o(n)
