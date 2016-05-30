(define (make-account balance password)
  (define (call-the-cops)
    (newline)
    (display "Called the cops."))
  (let ((incorrect 0))
      (define (withdraw amount)
        (if (>= balance amount)
          (begin (set! balance (- balance amount))
                 balance)
          "Insufficient Funds"))
      (define (deposit amount)
        (set! balance (+ balance amount))
        balance)
      (define (dispatch user-password m)
        (if (eq? password user-password)
          (begin (set! incorrect 0)
                 (cond ((eq? m 'withdraw) withdraw)
                       ((eq? m 'deposit) deposit)
                       (else (error "Unknown request -- MAKE ACCOUNT"
                                    m))))
          (if (= 7 incorrect)
            (lambda (x) call-the-cops)
            (begin (set! incorrect (+ 1 incorrect))
                   (lambda (x) "INCORRECT PASSWORD")))))
      dispatch))

(define acc (make-account 100 'secret-password))
((acc 'secret-password 'withdraw) 40)
((acc 'some-other-password 'deposit) 50)
((acc 'some-other-password 'deposit) 50)
((acc 'some-other-password 'deposit) 50)
((acc 'some-other-password 'deposit) 50)
((acc 'some-other-password 'deposit) 50)
((acc 'some-other-password 'deposit) 50)
((acc 'some-other-password 'deposit) 50)
