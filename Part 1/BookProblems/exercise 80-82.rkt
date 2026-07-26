;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |exercise 80-82|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct movie [title producer year])
; movie is a structure (make-movie String String Number)
; interp. movie is information of a movie 

(define-struct person [name hair eyes phone])
; person is a structure (String String String Number)
; perosn is information about a person

(define-struct pet [name number])
; pet is a structure (Name Number)
; (make-pet n num)
; with n as name
; with num as number


(define-struct CD [artist title price])
; CD is a structure (String String Number)
; (make-CD a t p)
; a is artist
; t is title
; p is price


(define-struct sweater [material size producer])
; sweater is a stucture (String Number String)
; (make-sweater m s p)
; m is material
; s is size
; p is producer

(define-struct time-past-midnight [hours minutes seconds])
; time-past-midnight is a structure (Number Number Number)
; (make-time-past-midnight h m s)
; h is hour
; m is minute
; s is seconds

(define-struct 3-letter-word [Letter1 Letter2 Letter3])
; 3-letter-word is a structure (Letter Letter Letter)
; (make-3-letter-word L1 L2 L3)represents a 3 letter word in the english language
; L1 is the first letter
; L2 is the second letter
; L3 is the third letter



; A Color is one of: 
; — "white"
; — "yellow"
; — "orange"
; — "green"
; — "red"
; — "blue"
; — "black"
(define color-ex1 (make-color "white"))

; H is a Number between 0 and 100.
; interpretation represents a happiness value
(define number-ex1 (make-h 10))

(define-struct person [fstname lstname male?])
; A Person is a structure:
;   (make-person String String Boolean)
(define person-ex1 (make-person "Chris" "Greene" #true))

(define-struct dog [owner name age happiness])
; A Dog is a structure:
;   (make-dog Person String PositiveInteger H)
(define dog-ex1 (make-dog "Chris" "Sally" 10 2))

; A Weapon is one of: 
; — #false
; — Posn
; interpretation #false means the missile hasn't 
; been fired yet; a Posn means it is in flight
(define weapon-ex1 #false)
(define weapon-ex2 (make-posn 10 20))