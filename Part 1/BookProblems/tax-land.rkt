;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname tax-land) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; Data Definion
;; ===========================

;; Price falls into one of three intervals:
;;  - 0 through 1000
;;  - 1000 through 10000
;;  - 10000 and above
;; interp. the price of an item

;; Function Definition
;; ===========================
;; Number -> Number
;; compute the sales tax of the first number
(check-expect (compute-tax 500) 500)
(check-expect (compute-tax 1000) 50)
(check-expect (compute-tax 20000) 1600)

(define (compute-tax p)
  (cond [(<= p 1000) p]
        [(<= 1000 p 10000) (* p .05)]
        [else (* p .08)]))
        