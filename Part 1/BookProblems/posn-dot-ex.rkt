;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname posn-dot-ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define MTS (empty-scene 100 100))
(define DOT (circle 3 "solid" "red"))
 
; A Posn represents the state of the world.
 
; Posn -> Posn 
(define (main p0)
  (big-bang p0
    [on-tick x+]
    [on-mouse reset-dot]
    [to-draw scene+dot])) 

; Posn -> Posn
; interp. increase the posn-x by 3
(check-expect (x+ (make-posn 10 10)) (make-posn 13 10))
(define (x+ p0)
  (posn-up-x p0 (+ 3 (posn-x p0))))

; Posn -> Posn
; interp. replaces the x field in posn p0 with n
(check-expect (posn-up-x (make-posn 0 5) 5) (make-posn 5 5))
(define (posn-up-x p n)
  (make-posn n (posn-y p))) 

; Posn -> Image
; interp. adds a DOT to MTS at x location
(check-expect (scene+dot (make-posn 10 20)) (place-image DOT 10 20 MTS))
(check-expect (scene+dot (make-posn 30 50)) (place-image DOT 30 50 MTS))
              
;(define (scene+dot p0) MTS) ;stub
(define (scene+dot p0) 
  (place-image DOT
               (posn-x p0)
               (posn-y p0)
               MTS))

; Posn MouseEvent -> Posn
; for mouse clicks, (make-posn x y); otherwise p
(check-expect (reset-dot (make-posn 10 10) 5 5 "button-down") (make-posn 10 10))
(check-expect (reset-dot (make-posn 10 10) 5 5 "button-up") (make-posn 5 5))

(define (reset-dot p0 x y me)
  (cond [(mouse=? me "button-up") (make-posn x y)]
        [else p0])) 