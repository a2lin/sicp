(car ''abracadabra)
(quote abracadabra)
; 'abracadabra can be replaced by (quote abracadabra)
; ''abracadabra is thus (quote (quote abracadabra))
; and thus the car of this 'listlike object' becomes (quote abracadabra)
; strangely, you would expect that (car (quote abracadabra)) returns quote,
; but this is not the case as it throws an error.
; perhaps this is because (quote abracadabra) resolves to the symbol
; abracadabra.. and therefore has no 'car' ability, whereas
; (quote (quote abracadabra)) resolves to (quote abracadabra) which
; is treated as a 'listlike' object.
