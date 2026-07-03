;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ufo-V2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; =======================

; A WorldState is a Number.
; interpretation number of pixels between the top and the UFO

;; Constants

(define WIDTH 300) ; distances in terms of pixels 
(define HEIGHT 100)
(define CTR-X (/ WIDTH 2))
(define CLOSE (/ HEIGHT 3)) 


(define MTSCN (empty-scene WIDTH HEIGHT)) ; short for empty scene 

;; Graphical Constants

(define UFO-BODY (ellipse 70 18 "solid" "green"))
(define UFO-CANOPY (circle 17 "solid" "black"))
(define UFO (overlay/align "middle" "bottom" (add-line UFO-BODY 0 10 70 10 "black") UFO-CANOPY))

(define LANDED (- HEIGHT (/ (image-height UFO) 2)))

;; ==============================
;; Functions

             
; WorldState -> WorldState
(define (main y0)
  (big-bang y0
     [on-tick nxt]
     [to-draw render]))
 
; WorldState -> WorldState
; computes next location of UFO 
(check-expect (nxt 150) 153)
(define (nxt y)
  (if (>= y LANDED) (+ y 3) y))
 
; WorldState -> Image
; places UFO at given height into the center of MTSCN
; displays: "descending" for y >  "closing in" "landed" 
(check-expect (render 11) (beside/align "bottom" (place-image UFO CTR-X 11 MTSCN) (text "Decending" 24 "black")))
(check-expect (render (- HEIGHT 20)) (beside/align "bottom" (place-image UFO CTR-X (- HEIGHT 20) MTSCN) (text "Closing in" 24 "black")))
(check-expect (render LANDED) (beside/align "bottom" (place-image UFO CTR-X LANDED MTSCN) (text "Landed" 24 "black")))

(define (render y)
  (beside/align "bottom" (place-image UFO CTR-X y MTSCN)
                (place-image (cond
                               [(< CLOSE y) (text "Decending" 24 "black")]
                               [(< 0 y CLOSE) (text "Closing in" 24 "black")]
                               [(= 0 y) (text "Landed" 24 "black")]))))
                               







