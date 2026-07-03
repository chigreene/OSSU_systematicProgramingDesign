;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |5.8 Sample Problem|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))


(define-struct r3 [x y z])
; An R3 is a structure:
; (make-r3 Number Number Number)

(define ex1 (make-r3 1 2 2)) ;
(define ex2 (make-r3 -1 0 3))


; R3 -> Number 
; determines the distance of p to the origin 
(define (r3-distance-to-0 p)
  (sqrt (+ (sqr (r3-x p))               ; number
           (sqr (r3-y p))          ; number
           (sqr (r3-z p)))))     ; number

  (check-expect (r3-distance-to-0 ex1)
                (sqrt (+ (sqr (r3-x ex1))
                         (sqr (r3-y ex1))
                         (sqr (r3-z ex1)))))