;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ufo-V3-render-line-update) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; =======================

; A WorldState is a Number.
; interpretation number of pixels between the top and the UFO

;; Constants

(define WIDTH 300) ; distances in terms of pixels 
(define HEIGHT 300)
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
    [to-draw render/status]))
 
; WorldState -> WorldState
; computes next location of UFO 
(check-expect (nxt 3) 6)
(define (nxt y)
  (if (<= y LANDED) (+ y 3) y))
 
; WorldState -> Image
; places UFO at given height into the center of MTSCN
; displays: "descending" for y >  "closing in" "landed" 
(check-expect (render 11) (beside/align "bottom" (place-image UFO CTR-X 11 MTSCN) (text "Decending" 24 "black")))
(check-expect (render (- HEIGHT 50)) (beside/align "bottom" (place-image UFO CTR-X (- HEIGHT 20) MTSCN) (text "Closing in" 24 "black")))
(check-expect (render LANDED) (beside/align "bottom" (place-image UFO CTR-X LANDED MTSCN) (text "Landed" 24 "black")))

(define (render y)
  (place-image UFO CTR-X y MTSCN))

; WorldState -> Image
; adds a status line to the scene created by render  
 
(check-expect (render/status 10)
              (place-image (text "descending" 11 "green")
                           10 10
                           (render 10)))

;; WorldState -> Image
;; adds a status line to the scene created by render

(define (render/status y)
  (cond
    [(<= 0 y CLOSE)
     (place-image (text "descending" 11 "green")
                  30 10
                  (render y))]
    [(and (< CLOSE y) (<= y LANDED))
     (place-image (text "closing in" 11 "orange")
                  30 10
                  (render y))]
    [(>= y LANDED)
     (place-image (text "landed" 11 "red")
                  30 10
                  (render y))])) 
                                  







