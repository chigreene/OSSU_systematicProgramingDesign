;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |5.8 sample problem redo desigin wit hstructures|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct r3 [x y z])
; An R3 is a structure:
;   (make-r3 Number Number Number)
 
(define ex1 (make-r3 1 2 13))
(define ex2 (make-r3 -1 0 3))

;; R3 -> Number
;; to compute the distance of an object in 3 demensional space to the origin
(check-expect (r3-distance-to-0 ex1) (round (sqrt (+ (sqr 1) (sqr 2) (sqr 13))))) 
              

(define (r3-distance-to-0 R3)
   (sqrt (+ (sqr (r3-x R3))     ; number
            (sqr (r3-y R3))     ; number
            (sqr (r3-z R3)))))  ; number




