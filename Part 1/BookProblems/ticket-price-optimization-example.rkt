;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ticket-price-optimization-example) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Constants

(define BASE-ATTENDANCE 120)
(define BASE-TICKET-PRICE 5.00)
(define PRICE-INCREMENT 0.10)
(define AVERAGE-ATTENDANCE 15)
(define FIXED-COST 180)
(define COST-PER-ATTENDEE .04)

;; Functions

(define (attendees ticket-price)
  (- BASE-ATTENDANCE (* (- ticket-price BASE-TICKET-PRICE) (/ AVERAGE-ATTENDANCE PRICE-INCREMENT))))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price)
  (+ FIXED-COST (* COST-PER-ATTENDEE (attendees ticket-price))))

(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))

(profit 2.8)
(profit 2.9)
(profit 3)
(profit 3.1)
(profit 3.2)
(profit 3.3)
(profit 3.4)
(profit 3.5)
(profit 3.6)
(profit 3.7)

(define (profit2 price)
  (- (* (+ 120
           (* (/ 15 0.1)
              (- 5.0 price)))
        price)
     (+ 180
        (* 0.04
           (+ 120
              (* (/ 15 0.1)
                 (- 5.0 price)))))))

(profit2 2.8)
(profit2 2.9)
(profit2 3)
(profit2 3.1)
