(load "evaluator.scm")

(define (list-of-values-ltr exps env)
  (define (list-of-values-ltr-internal exps env start)
    (if (no-operands? exps)
      (cons start '())
      (list-of-values-ltr-internal (rest-operands exps) env (cons start (eval (first-operand exps) env)))))
  (cdr (list-of-values-ltr-internal exps env '())))

(define (list-of-values-rtl exps env)
  (define (list-of-values-rtl-internal exps env start num)
    (if (no-operands? exps)
      (cons start '())
      (list-of-values-rtl-internal (exps) env (cons start (eval (get-exp num exps) env)) (- num 1))))
  (list-of-values-rtl-internal exps env start (get-num-exps exps)))