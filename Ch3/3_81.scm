(load "stream_lib.scm")
(define random-numbers
  (cons-stream
    random-init
    (stream-map rand-update random-numbers)))

(define random-number-stream request-stream rand0)
