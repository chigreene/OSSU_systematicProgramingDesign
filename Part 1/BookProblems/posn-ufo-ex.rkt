;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname posn-ufo-ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct ufo [loc vel])
; A UFO is a structure: 
;   (make-ufo Posn Vel)
; interpretation (make-ufo p v) is at location
; p moving at velocity v



(define-struct loc [x y])
; the position of a UFO
;    (make-loc x y)
; interp. (make-loc x y) the x and y coordinates of the ufo\

(define p1 (make-loc 10 10))
(define p2 (make-loc 20 20))

(define-struct vel [x y])
; the velocity of the UFO in the x and y plain
;    (make-vel x y)
; interp. (make-vel x y) the velocity in the x and y coord

(define v1 (make-vel 8 -3))
(define v2 (make-vel -5 -3))

(define ufo1 (make-ufo p1 v1))
(define ufo2 (make-ufo p2 v2))

; Loc Vel -> Loc
; adds v to p
(check-expect (posn+ p1 v1) (make-loc 18 7))
(check-expect (posn+ p1 v2) (make-loc 5 7))
 
(define (posn+ p v)
  (make-loc (+ (loc-x p) (vel-x v))
             (+ (loc-y p) (vel-y v)))) 

; UFO -> UFO
; increases the x position by one of the UFO per clock tick
(check-expect (ufo-move-1 (make-ufo (make-loc 10 10) (make-vel 3 3)))
              (make-ufo (make-loc 13 13) (make-vel 3 3)))


(define (ufo-move-1 ufo)
  (make-ufo (posn+ (ufo-loc ufo) (ufo-vel ufo))
            (ufo-vel ufo))) 

