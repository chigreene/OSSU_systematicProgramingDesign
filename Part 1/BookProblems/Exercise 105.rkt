;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Exercise 105|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A Coordinate is one of :
; - a NegativeNumber
; interpretation on the y axis, distance from top
; - a positiveNumber
; interpretation on the x axis, distance from left
; - a Posn
; interpretation an ordinary Cartesian point

(define coord-0 -1)
(define coord-1 -5)
(define coord-2 1)
(define coord-3 5)
(define coord-4 (make-posn 2 2))
(define coord-5 (make-posn 5 5))