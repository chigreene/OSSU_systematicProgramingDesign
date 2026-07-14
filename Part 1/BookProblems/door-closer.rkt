;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname door-closer) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; Constants
;; =======================

;; Data Definition
;; =======================

;; DoorState is one of:
;; - "open"
;; - "locked"
;; - "closed"
;; interp. the state of a automatically closing door

(define LOCKED "locked")
(define CLOSED "closed")
(define OPEN "open")

#;
(define (fn-for-door-state ds)
  (cond [(string=? "open" ds) (...)]
        [(string=? "closed" ds) (...)]
        [(string=? "locked" ds) (...)]))

;; Template rules used:
;;  - one of: 3 cases
;;  - atomic distinct

;; Funtion Definition
;; =======================

;; DS -> DS
;; start the world with (main "closed")
;;
(define (main ds)
  (big-bang ds
    (on-tick door-closer 3)   ; DS -> DS
    (on-key door-action)      ; DS Keyevent
    (to-draw door-render)))   ; DS -> Image


;; DoorState -> DoorState
;; interp. closes the door during one tick
(check-expect (door-closer OPEN) "closed")
(check-expect (door-closer CLOSED) "closed")
(check-expect (door-closer LOCKED) "locked")

;(define (door-closer ds) "close") ; stub

(define (door-closer state-of-door)
  (cond
    [(string=? LOCKED state-of-door) LOCKED]
    [(string=? CLOSED state-of-door) CLOSED]
    [(string=? OPEN state-of-door) CLOSED]))

;; DoorState KeyEvent -> DoorState
;; interp. acts on the door in response to pressing a key
(check-expect (door-action LOCKED "u") CLOSED)
(check-expect (door-action CLOSED "l") LOCKED)
(check-expect (door-action CLOSED " ") OPEN)
(check-expect (door-action OPEN "a") OPEN)
(check-expect (door-action CLOSED "a") CLOSED)
 
(define (door-action s k)
  (cond
    [(and (string=? LOCKED s) (string=? "u" k))
     CLOSED]
    [(and (string=? CLOSED s) (string=? "l" k))
     LOCKED]
    [(and (string=? CLOSED s) (string=? " " k))
     OPEN]
    [else s])) 


;; DoorState -> Image
;; translates the state of the door from s to a large text image
(check-expect (door-render LOCKED) (text "locked" 10 "black"))
(check-expect (door-render OPEN) (text "open" 10 "black"))
(check-expect (door-render CLOSED) (text "closed" 10 "black"))
(define (door-render ds)
  (text ds 10 "black") )

 