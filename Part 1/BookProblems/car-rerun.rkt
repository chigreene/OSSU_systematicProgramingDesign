;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname car-rerun) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; My world program  (make this more specific)

;; =================
;; Constants:

(define WIDTH 500)
(define HEIGHT 200)
(define CTR-Y (/ HEIGHT 2))
(define MTS (empty-scene WIDTH HEIGHT))
(define WHEEL-RADIUS 5)
(define WHEEL (circle WHEEL-RADIUS "solid" "black"))
(define WHEEL-SPACE (rectangle (* 3 WHEEL-RADIUS) 1 "solid" "white"))
(define WHEEL-BASE (beside/align "bottom" WHEEL WHEEL-SPACE WHEEL))
(define CAR-BASE (rectangle (* 9 WHEEL-RADIUS) (* 1.7 WHEEL-RADIUS) "solid" "red"))
(define CAR-TOP (rectangle (* 4 WHEEL-RADIUS) (* 3 WHEEL-RADIUS) "solid" "red"))
(define CAR-BODY (overlay/align "center" "bottom" CAR-BASE CAR-TOP))
(define CAR (overlay/offset WHEEL-BASE 0 (- 0 WHEEL-RADIUS) CAR-BODY))
(define SPEED 3)

(define TREE
  (underlay/xy (circle 10 "solid" "green")
               9 15
               (rectangle 2 20 "solid" "brown")))



;; ==================
;; Data definitions:

;; CS is a Natural
;; interp. postion of right side of the car on x axis

(define C1 0)
(define C2 50)

#;
(define (fn-for-car c)
  (... c))

;; Template rules used:
;; - atomic non-distinct



;; =================
;; Functions:

;; CS -> CS
;; start the world with (main 0)
;; 
(define (main cs)
  (big-bang cs                          ; CS
            (on-tick   advance-car)     ; CS -> CS
            (to-draw   render)))        ; CS -> Image

;; CS -> CS
;; produce the next car position
(check-expect (advance-car 0) 3)

;(define (advance-car cs) 0) ;stub

(define (advance-car cs) (+ cs SPEED))


;; CS -> Image
;; renders car on scene at position indicated by CS
(check-expect (render 10) (place-image CAR (- 10 (/ (image-width CAR) 2)) CTR-Y MTS))
(define (render cs) 
  (place-image CAR (- cs (/ (image-width CAR) 2)) CTR-Y (place-image TREE (* .75 WIDTH) CTR-Y MTS)))