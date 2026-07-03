;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname first-HtDF-problem) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Problem: design a fucntino that pluralizes a given word.
;;          (Pluralize means to convert the word to its plural form.)
;;          For simplicity you may assume that just adding s is enough to
;;          pluralize a word.

;String -> String     signature
;take a string input and  add an 's' to the end
;;(define (pluralize n) "s")    ;Stub poor example
(define (pluralize str) str) ;stub better solution. 

;;(pluralize "car") should produce "cars"

(check-expect (pluralize "car") "")

