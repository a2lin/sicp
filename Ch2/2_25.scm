(let ((one (list 1 3 (list 5 7) 9))
      (two (list (list 7)))
      (three (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7))))))))
    (newline)
    (display "one = ")
    (display (car (cdr (car (cdr (cdr one))))))
    (newline)
    (display "two = ")
    (display (car (car two)))
    (newline)
    (display "three = ")
    (display (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr three)))))))))))))
    (newline)
 )
