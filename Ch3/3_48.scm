; this prevents the dual-sided acquisition problem
; by enforcing a strict acquisition order. It can 
; never be that you and another process want
; the same resources and both processes have
; parts of the resources since to get the later
; resources you must have consumed the priors.


(define (make-account-and-serializer balance) 
  (let ((number-serializer (make-serializer))
        (number 0))
    (define (withdraw amount)
      (if (>= balance amount)
        (begin (set! balance (- balance amount)) balance) "Insufficient funds"))
    (define (deposit amount)
      (set! balance (+ balance amount)) balance)

    (define (get-number)
      (let ((old-number number))
        (set! number (+ 1 number))
        old-number))

    (let ((balance-serializer (make-serializer))
          (acct-number (number-serializer get-number)))
      (define (dispatch m)
        (cond ((eq? m 'withdraw) (balance-serializer withdraw)) 
              ((eq? m 'deposit) (balance-serializer deposit)) 
              ((eq? m 'balance) balance)
              ((eq? m 'serializer) balance-serializer)
              ((eq? m 'number) number)
              (else (error "Unknown request: MAKE-ACCOUNT" m)))) 
      dispatch)))


(define (serialized-exchange account1 account2)
  (define (exchange less1 less2)
    (let ((serializer1 (less1 'serializer))
          (serializer2 (less2 'serializer)))
      ((serializer1 (serializer2 exchange))
       account1
       account2)))
  (if (< (account1 'number) (account2 'number))
    (exchange account1 account2)
    (exchange account2 account1)))
