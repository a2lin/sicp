; so insert-queue returns the modified queue as a value
; the queue is a dual-ptr where the first is the head and the last is the tail
; if you insert-queue you will get the head pointing to the list and the tail
; pointing to the last element

; therefore 'a will appear twice in the print, once as the list and once as the tail element
; if the queue is printed normally.
