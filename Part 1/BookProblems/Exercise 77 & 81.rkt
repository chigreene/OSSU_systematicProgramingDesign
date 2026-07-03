;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Exercise 77 & 81|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 77 & 81

(define-struct time (h m s))
;; Time is (make-time Number Number Number)
;; Interp. the amount of time past midnight

(define TIME-1 (make-time 2 10 0))

;; Time -> Natural
;; takes a data from time struct and outputs the number
;; of seconds
(check-expect (number-of-seconds TIME-1) 7800)

(define (number-of-seconds t)
  (+ (time-s t)
     (* 60 (+ (* 60 (time-h t))
              (time-m t)))))