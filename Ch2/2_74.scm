; division data structures vary (so each division has a tag)
; other tag is what kind of operation, so you have a 2-d get.

; file is a list ('division, 'set_of_records)
; the file must be tagged with the division
(define (get-record file employee)
  ((get (division file) 'record) (data file) employee))

; accessor for the list (division, file) -> file 
(define (division file) 
  (car file))

; accessor for the list (division, file) -> file
(define (data file)
  (cadr file))

; this retrieves a division-specific record, and then uses the
; division-specific salary code to retrieve the salary
; (this allows the division salary code to operate on its
; custom division format)
(define (get-salary file employee)
  ((get (division file) 'salary) (get-record file) employee))

; this returns #f if the employee can not be found int he file
; alternatively, it retrieves 'name from each employee file
(define (find-employee-record name files)
  (if (null? files)
    #f
    (let ((res ((get (division file) 'name (get-record file)) name (car files))))
      (if res
        res
        (find-employee-record name (cdr files))))))

; to take over a new company, the company's files must be tagged with a new
; division tag.
; in addition, the methods for 'name, 'salary, 'record accession must be
; implemented. No other changes need be made.
