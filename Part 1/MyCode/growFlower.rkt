;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname growFlower) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; ========================
;; Constants

(define WIDTH 400)
(define HEIGHT 600)
(define MTS (empty-scene WIDTH HEIGHT))
(define FLOWER (scale .1 (overlay (circle 15 "solid" "yellow")
                        (pulled-regular-polygon 50 5 1.1 140 "solid" "purple"))))
;; !!! BETTER FLOWER GRAPHIC

;; ========================
;; Data Definition

;; FS is current state of the flower. The state is the flower location x, y, scaler that increase
;;  with i each clock tick

(define-struct flower (x y s))
;; Flower is (make-flower Number Number Number)
;; interp. a flower at position x y and size s

(define FLOWER-1 (make-flower 10 10 5))

#;
(define (fn-for-flower f)
  (... (flower-x f)
       (flower-y f)
       (flower-s f)))

;; Template used:
;;  - Compound: 3 fields

;; ======================
;; Function

;; FS -> FS
;; start with (main (make-flower 50 50 1))

(define (main FS)
      (big-bang FS          ; FS
        (on-tick   grow)    ; FS -> FS
        (to-draw   render)  ; FS -> Image
        (on-key    plant))) ; FS KeyEvent -> FS


;; FS -> FS
;; grow the flower 1% bigger for each clock tick
(check-expect (grow (make-flower 20 20 1)) (make-flower 20 20 1.1))
(define (grow fs)
  (make-flower (flower-x fs) (flower-y fs) (+ (flower-s fs) .1)))

;; Image -> Image
;; scale image based by s field of flower
(check-expect (flower-size FLOWER (make-flower 50 50 2)) (scale 2 FLOWER))

(define (flower-size img fs)
  (scale (flower-s fs) img))

;; FS -> Image
;; render the image of the flower at the x and y coordinate and scale it based off of s
(check-expect (render (make-flower 20 20 3)) (place-image (flower-size FLOWER (make-flower 20 20 3)) 20 20 MTS))
  
(define (render fs) 
  (place-image (flower-size FLOWER fs) (flower-x fs) (flower-y fs) MTS))  
 
;; FS -> FS
;; change the x and y coordinates of the flower to the location clicked and reset size scaler to 1
(check-expect (plant (make-flower 40 40 2) " ") (make-flower
(define (plant fs ke) fs)
        

