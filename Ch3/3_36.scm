(define a (make-connector))
(define b (make-connector))
(set-value! a 10 'user)

; initially a has constratings '()
; initially the value is 'false

; at the time of evaluating 'set-value! we execute set-my-value for 'a
; set-my-value 10 setter (user)
; a-connector -> (false, false, '())
; b-connector -> (false, false, '())
; set-my-value! a 10 'user

; a-connector -> (10 'user '())
; constraints is '(), so nothing happens in the for-each-except loop. 
; (at this point setter is 'user)
