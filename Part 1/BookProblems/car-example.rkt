;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname car-example) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;;===========================
;; constants

(define WIDTH 500)
(define HEIGHT 300)

(define Y-CAR (- HEIGHT 25))

(define MTS (empty-scene WIDTH HEIGHT))

(define WHEEL-RADIUS 5)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))

;; Graphical Constants

(define WHEEL
  (circle WHEEL-RADIUS "solid" "black"))

(define BODY
  (rectangle (* 8 WHEEL-RADIUS) (* 2.25 WHEEL-RADIUS) "solid" "red"))

(define ROOF
  (rectangle (* 4 WHEEL-RADIUS) (* 1.5 WHEEL-RADIUS) "solid" "red"))

(define SPACE
  (rectangle (* 2 WHEEL-RADIUS) WHEEL-RADIUS "solid" "white"))

(define BOTH-WHEELS
  (beside WHEEL SPACE WHEEL))

(define CAR
  (above ROOF
         (overlay/align/offset "middle" "bottom"
                 BOTH-WHEELS
                 0
                 (* -1 WHEEL-RADIUS)
                 BODY)))
         
;; ==========================
;; Data Definition

; An AnimationState is a Number.
; interpretation the number of clock ticks 
; since the animation started

(define car-location 0)

;; ==========================
;; functions

; AnimationState -> AnimationState
; launches the program from some initial state; start with (main 0)
(define (main as)
   (big-bang as
     (on-tick tock)
     (on-mouse hyper)
     (to-draw render)))
 
; AnimationState -> AnimationState 
; each tock equals 3
(check-expect (tock 0) 1)
(check-expect (tock 2) 3)
 
(define (tock as) (add1 as))
 
; AnimationState -> Image
; places the car into the BACKGROUND scene,
; and for each tock move the car to the right
(check-expect (render 0)
              (place-image CAR 0 Y-CAR MTS))
(check-expect (render 2)
              (place-image CAR 6 Y-CAR MTS))

 (define (render as)
   (place-image CAR (- (/ WIDTH 2) (* (/ WIDTH 2) (sin (/ as 6)))) Y-CAR MTS))

; AnimationState Number Number String -> AnimationState
; places the car at x-mouse
; if the given me is "button-down"
 (check-expect (hyper 21 10 20 "enter") 21)
 (check-expect (hyper 42 10 20 "button-down") 10)
 (check-expect (hyper 42 10 20 "move") 42)
 
(define (hyper x-position-of-car x-mouse y-mouse me)
 (cond
    [(string=? "button-down" me) (sin x-mouse)]
    [else x-position-of-car]))
 