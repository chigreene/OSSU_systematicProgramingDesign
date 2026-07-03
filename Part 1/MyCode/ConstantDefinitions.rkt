;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ConstantDefinitions) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require lang/htdp-beginner)


;Question 1
(define FOO (* 2 3))
(define BAR (* FOO 2 ))
;Solve
(* FOO BAR)
(* (* 2 3) (* FOO 2))
(* (* 2 3) (* (* 2 3) 2))
(* 6 (* 6 2))
(* 6 12)
72

;Question 2
