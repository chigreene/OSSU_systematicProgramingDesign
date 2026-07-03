;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname hyper-car-reRun) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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

;; An AnimationState is a Number.
;; interpretation the number of clock ticks 
;; since the animation started

(define A1 0)
(define A2 5)

#;
(define (fn-for-animationState s)
  (... s))

;; Template rules used:
;; - atomic non-distinct



;; =================
;; Functions:

;; AS -> AS
;; start the world with (main (/ WIDTH 2))
;; 
(define (main as)
  (big-bang as                          ; AS
            (on-tick   tock)            ; AS -> AS
            (on-mouse  hyper)           ; AS Integer Integer MouseEvent -> AS
            (to-draw   render)))        ; AS -> Image

;; AS -> AS
;; advance tock for each clock tick.  
(check-expect (tock 0) 1)

;(define (tock as) 0) ;stub

(define (tock as) (add1 as))
 

;; AS -> Image
;; renders car on scene at x coord tied to clock tick AS
(check-expect (render 10) (place-image CAR (- 10 (/ (image-width CAR) 2)) CTR-Y MTS))
(define (render as) 
  (place-image CAR (sin-tick (- as (/ (image-width CAR) 2))) CTR-Y (place-image TREE (* .75 WIDTH) CTR-Y MTS)))

;; AS -> Number
;; takes the current clock tick and uses it as the input for sin and scales output to fill WIDTH of scene
;(check-expect (sin-tick 3.14) (* WIDTH (sin 3.14)))

(define (sin-tick as)
  (+ (/ WIDTH 2) (* (/ WIDTH 2) (sin (/ as 8)))))

;; AS -> AS
;; interp. when the mouse is clicked the car is placed at the x coordinates of the click
(check-expect (hyper 10 100 0 "button-down") 100)
(check-expect (hyper 10 100 0 "drag") 10)
(define (hyper as x y me)
  (cond [(mouse=? me "button-down") (find-as x)]
        [else
         as])) 

;; AS -> Number
;; interp. take world state as and convert it to the value that gives the output of
;; (sin-tick (- as (/ (image-width CAR) 2)))
;(check-expect (find-as 1))

(define (find-as target-x)
  (+ (* 8 (asin (/ (- (* 2 target-x) WIDTH) WIDTH)))
     (/ (image-width CAR) 2))) 
              