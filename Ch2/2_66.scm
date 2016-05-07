(load "2_63.scm")

(define (key y) y)
(define (lookup-binary-tree given-key tree)
  (cond ((null? tree) #f)
        ((= (key (entry tree)) given-key) (entry tree))
        ((< (key (entry tree)) given-key) (lookup-binary-tree given-key (left-branch tree)))
        ((> (key (entry tree)) given-key) (lookup-binary-tree given-key (right-branch tree)))
        )
  )

(lookup-binary-tree 3 (token-tree))
