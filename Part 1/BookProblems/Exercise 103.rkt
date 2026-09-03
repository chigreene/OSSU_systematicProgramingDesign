;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Exercise 103|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct spider (legs space))
;; Spider is (make-spider Number Number)
;; interp. a spider with number of legs remaining and space as the amount of space needed to contain the spider. 

(define SPIDER-1 (make-spider 8 10))

#;
(define (fn-for-spider s)
  (... (spider-legs s)     ; number
       (spider-space s)))  ; number
;; template rules used:
;;  - compound: 2 fields

(define-struct elephant (space))
;; Elephant is (make-elephant Number)
;; interp. a elephant and the amount of size needed to contain the spider

(define ELEPHANT-1 (make-elephant 100))

#;
(define (fn-for-elephant e)
  (... (elephant-size e)))  ; number
;; template rules used:
;;  - compound: 1 field

(define-struct boa (length girth))
;; Boa is a (make-boa Number Number)
;; interp. a boa and its length and girth is numbers

(define BOA-1 (make-boa 300 10))

#;
(define (fn-for-boa b)
  (... (boa-length b)
       (boa-girth b)))
;; template rules used:
;;  - compound: 2 field

(define-struct armadillo (health space))
;; Armadillos is a (make-armadillo Number Number)
;; interp. a armadillo and its remaining health and the space needed to store it for transport

(define ARMADILLO-1 (make-armadillo 100 30))

#; (define (fn-for-armadillo a)
     (... (armadillo-health a)
          (armadillo-space a)))
;; template rules used:
;;  - compound: 2 fields
                            


;; Animal is one of:
;;  - Spider
;;  - Elephant
;;  - Boa
;; interp. the type of animal

#;
(define (fn-for-animal as)
  (cond [(string=? "spider" as) (...)]
        [(string=? "elephant" as) (...)]
        [(string=? "boa" as) (...)]))

;; template rules used:
;;  - one of: 3 cases
;;  - atomic distinct: "spider"
;;  - atomic distinct: "elephant"
;;  - atomic distinct: "boa"