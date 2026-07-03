;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname happiness-guage) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

;; Constants

(define WIDTH 200)
(define HEIGHT 50)

(define OUTLINE (rectangle 100 15 "outline" "black"))

(define BAR-HEIGHT 15)
(define BAR-WIDTH 100)

(define COLOR "red")

;; ================================
;; Data Definiton
;; Happiness is Number(0,100)
;; interp. the amount OUTLINE is full
(define H1 0)
(define H2 50)
(define H3 100)
#;
(define (fn-for-cat c)
  (... c))

;; Template used
;;  - atomic non-distict: Number

;; ===============================
;; Function

;; WS -> WS
;; start the world with (main 100)
;; tracks the happiness bar

(define (main h)
  (big-bang h
    (on-tick update-bar)
    (on-key handle-key)
    (to-draw render-bar)))

;; WS -> WS
;; decreases the bar 0.1 per tick and stops at zero
;;!!!!
(check-expect (update-bar 100) 99.9)
(check-expect (update-bar 0) 0)
(define (update-bar h)
  (cond [(> h 0.1) (- h 0.1)]
        [else h]))

;; WS -> Image
;; renders the happiness bar based of h
(check-expect (render-bar 10) (rectangle 10 BAR-HEIGHT "solid" COLOR))
(define (render-bar h) (rectangle h BAR-HEIGHT "solid" COLOR))


;; WS KeyEvent -> WS
;; on 'down' decrease by 1/5; on 'up' increase by 1/3
(check-expect (handle-key 50 "down") (- 50 (* BAR-WIDTH (/ 1 3))))
(check-expect (handle-key 50 "up") (+ 50 (* BAR-WIDTH (/ 1 5))))

(define (handle-key h ke)
  (cond [(key=? ke "up") (if (> (+ h (* BAR-WIDTH (/ 1 5))) 0) (+ 50 (* BAR-WIDTH (/ 1 5))) h)]
        [(key=? ke "down") (if (> (- h (* BAR-WIDTH (/ 1 3))) 0) (- h (* BAR-WIDTH (/ 1 3))) h)]
        [else h])) 