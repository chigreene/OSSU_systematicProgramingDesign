;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname UF0-landing-reRun) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
; A WorldState is a Number.
; interpretation number of pixels between the top and the UFO
 
(define WIDTH 300) ; distances in terms of pixels 
(define HEIGHT 100)
(define CLOSING-IN (* (/ 2 3) HEIGHT))
(define CTR-X (/ WIDTH 2))
(define CLOSE (/ HEIGHT 3))
(define MTSCN (empty-scene WIDTH HEIGHT)) ; short for empty scene 
(define UFO (overlay (rectangle 40 1 "solid" "black") (circle 10 "solid" "green") (ellipse 40 10 "solid" "green")))
(define UFO-BOTTOM (/ (image-height UFO) 2))

; WorldState is one of three intervals:
; - [0, CLOSING-IN)
; - [CLOSING-IN, HEIGHT)
; - HEIGHT
; interp. the location of the UFO broken into three different ranges based off distance to HEIGHT
;         aka landed. 



#;
(define (fn-for-world-state ws)
  (cond [(< 0 ws CLOSING-IN) (...)]
        [(and (<= CLOSING-IN ws) (< ws HEIGHT) (...)]
        [else ...])))


; WorldState -> WorldState
(define (main y0)
  (big-bang y0
     [on-tick nxt]
     [to-draw render]))
 
; WorldState -> WorldState
; computes next location of UFO 
(check-expect (nxt 11) 14)
(check-expect (nxt (+ HEIGHT 1)) HEIGHT)
(define (nxt y0)
  (cond [(>= y0 HEIGHT) HEIGHT]
        [else (+ y0 3)])) 

;WorldState -> String
; interp. takes the ws and returns "descending" "closing in" "landed" based on UFO height
; "descending" height 
(check-expect (status (* .5 HEIGHT)) "descending")
(check-expect (status (* .8 HEIGHT)) "closing-in")
(check-expect (status HEIGHT) "landed")

;(define (status y0) "test") ;stub

(define (status y0)
  (cond [(< y0 CLOSING-IN) "descending"]
        [(< y0 HEIGHT) "closing-in"]
        [else "landed"])) 

; WorldState -> Image
; places UFO at given height into the center of MTSCN
(check-expect (render 11) (place-image UFO CTR-X (- 11 UFO-BOTTOM)
                                       (place-image (text (status 11) 12 "black") 40 10 MTSCN))) 
(define (render y0)
  (place-image UFO CTR-X (- y0 UFO-BOTTOM)
               (place-image (text (status y0) 12 "black") 40 10 MTSCN))) 