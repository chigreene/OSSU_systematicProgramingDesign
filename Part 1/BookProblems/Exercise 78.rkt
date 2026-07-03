;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Exercise 78|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 78

;; Letter is one of:
;;  - "a"
;;  - "b"
;;  - "c"
;;  - "d"
;;  - "e"
;;  - "f"
;;  - "g"
;;  - "h"
;;  - "i"
;;  - "j"
;;  - "k"
;;  - "l"
;;  - "m"
;;  - "n"
;;  - "o"
;;  - "p"
;;  - "q"
;;  - "r"
;;  - "s"
;;  - "t"
;;  - "u"
;;  - "v"
;;  - "w"
;;  - "x"
;;  - "y"
;;  - "z"
;; interp. a one letter string for each letter in the alphabet
;; #false denotes excetional case.


(define-struct word (l1 l2 l3))
;; word is (make-Word Letter Letter Letter)
;; interp. a three letter word composed of three strings from Letter
;; data definition. 

(define WORD-1 (make-word "c" "a" "t"))
(define WORD-2 (make-word "c" "a" "r"))
(define WORD-3 (make-word "c" "a" "t"))

;; Word Word -> Word
;; takes two Words compares them are returns a word that indicates when
;; the letters agree or disagree. if the two agree it returns the word.
(check-expect (compare-words WORD-1 WORD-2) (make-word "c" "a" false))
(check-expect (compare-words WORD-1 WORD-3) (make-word "c" "a" "t"))

(define (compare-words w1 w2)
  (make-word
   [compare-letters (word-l1 w1) (word-l1 w2)]
   [compare-letters (word-l2 w1) (word-l2 w2)]
   [compare-letters (word-l3 w1) (word-l3 w2)]))


;; Letter Letter -> Letter
;; compares two letters.
;; Produces
;; - #false if the Letters are not equal.
;; - a Letter value otherwise.
(check-expect (compare-letters "a" "a") "a")
(check-expect (compare-letters "a" "b") #false)
(check-expect (compare-letters "a" #false) #false)
(check-expect (compare-letters #false #false) #false)

(define (compare-letters l1 l2)
  (cond
    [(and (string? l1) (string? l2))
     (cond
       [(string=? l1 l2) l1]
       [else #false])]
     [else #false]))




