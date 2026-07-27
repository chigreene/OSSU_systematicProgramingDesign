;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname text-editor-v1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)


;; CONSTANTS
;; ==========================

(define WIDTH 200)
(define HEIGHT 200)
(define CTR-X (/ WIDTH 2))
(define CTR-Y (/ HEIGHT 2))
(define MTS (empty-scene WIDTH HEIGHT))
(define CURSOR (rectangle 1 20 "solid" "red"))

;; DATA DEFINITION
;; =========================

(define-struct editor [text index])
;; Editor is a structure
;;  (make-editor String Number)
;; interp. (make-editor t i) describes a string and index to track
;; the cursor location a point of new letter insertion or deletion.

(define EX1 (make-editor "abcdef" 3))
(define EX2 (make-editor "abcdef" 2))
(define EX3 (make-editor "abcdef" 0))
(define EX4 (make-editor "abcdef" 6))
(define EX5 (make-editor "aaaaaaaaaaaaaaaaaaaaaaa" 3))

;; FUNCTIONS
;; ================================

;; WS -> WS
;; start world with (main (make-editor "" ""))
(define (main ws)
  (big-bang ws            ; WS
    (on-key edit)         ; WS
    (to-draw render)))    ; WS

;; Editor KeyEvent -> Editor
;; adjusts value of pre and post data fields to simulate a cursor moving along the string of text resulting from
;; appending pre and post
(check-expect (edit EX1 "a") (make-editor "abcadef" 3))
(check-expect (edit EX1 "b") (make-editor "abcbdef" 3))
(check-expect (edit EX1 "c") (make-editor "abccdef" 3))
(check-expect (edit EX1 "d") (make-editor "abcddef" 3))
(check-expect (edit EX1 "e") (make-editor "abcedef" 3))
(check-expect (edit EX1 "f") (make-editor "abcfdef" 3))
(check-expect (edit EX1 "g") (make-editor "abcgdef" 3))
(check-expect (edit EX1 "h") (make-editor "abchdef" 3))
(check-expect (edit EX1 "i") (make-editor "abcidef" 3))
(check-expect (edit EX1 "j") (make-editor "abcjdef" 3))
(check-expect (edit EX1 "k") (make-editor "abckdef" 3))
(check-expect (edit EX1 "l") (make-editor "abcldef" 3))
(check-expect (edit EX1 "m") (make-editor "abcmdef" 3))
(check-expect (edit EX1 "n") (make-editor "abcndef" 3))
(check-expect (edit EX1 "o") (make-editor "abcodef" 3))
(check-expect (edit EX1 "p") (make-editor "abcpdef" 3))
(check-expect (edit EX1 "q") (make-editor "abcqdef" 3))
(check-expect (edit EX1 "r") (make-editor "abcrdef" 3))
(check-expect (edit EX1 "s") (make-editor "abcsdef" 3))
(check-expect (edit EX1 "t") (make-editor "abctdef" 3))
(check-expect (edit EX1 "u") (make-editor "abcudef" 3))
(check-expect (edit EX1 "v") (make-editor "abcvdef" 3))
(check-expect (edit EX1 "w") (make-editor "abcwdef" 3))
(check-expect (edit EX1 "x") (make-editor "abcxdef" 3))
(check-expect (edit EX1 "y") (make-editor "abcydef" 3))
(check-expect (edit EX1 "z") (make-editor "abczdef" 3))
(check-expect (edit EX1 " ") (make-editor "abc def" 3))
 
;; Backspace tests
(check-expect (edit EX1 "\b") (make-editor "abcdef" 3))
(check-expect (edit EX3 "\b") (make-editor "abcdef" 0))
 
;; Left arrow tests
(check-expect (edit EX1 "left") (make-editor "abcdef" 2))
(check-expect (edit EX3 "left") (make-editor "abcdef" 0))
(check-expect (edit EX4 "left") (make-editor "abcdef" 5))
 
;; Right arrow tests
(check-expect (edit EX1 "right") (make-editor "abcdef" 4))
(check-expect (edit EX3 "right") (make-editor "abcdef" 1))
(check-expect (edit EX4 "right") (make-editor "abcdef" 6))
 
;; Edge case: unrecognized key
(check-expect (edit EX1 "\t") EX1)

;; Text input greater than current field
(check-expect (edit EX5 "a") EX5)

(define (edit ed ke)
  (cond [(string=? ke "a") (... (editor-text ed) (editor-index ed))]
        [(string=? ke "b") (... (editor-text ed) (editor-index ed))]
        [(string=? ke "c") (... (editor-text ed) (editor-index ed))]
        [(string=? ke "d") (... (editor-text ed) (editor-index ed))]
        [(string=? ke "e") (... (editor-text ed) (editor-index ed))]
        [(string=? ke "f") (... (editor-text ed) (editor-index ed))]
        [(string=? ke "g") (... (editor-text ed) (editor-index ed))]
        [(string=? ke "h") (... (editor-text ed) (editor-index ed))]
        [(string=? ke "i") (... (editor-text ed) (editor-index ed))]
        [(string=? ke "j") (... (editor-text ed) (editor-index ed))]
        [(string=? ke "k") (... (editor-text ed) (editor-index ed))]
        [(string=? ke "l") (... (editor-text ed) (editor-index ed))]
        [(string=? ke "m") (... (editor-text ed) (editor-index ed))]
        [(string=? ke "n") (... (editor-text ed) (editor-index ed))]
        [(string=? ke "o") (... (editor-text ed) (editor-index ed))]
        [(string=? ke "p") (... (editor-text ed) (editor-index ed))]
        [(string=? ke "q") (... (editor-text ed) (editor-index ed))]
        [(string=? ke "r") (... (editor-text ed) (editor-index ed))]
        [(string=? ke "s") (... (editor-text ed) (editor-index ed))]
        [(string=? ke "t") (... (editor-text ed) (editor-index ed))]
        [(string=? ke "u") (... (editor-text ed) (editor-index ed))]
        [(string=? ke "v") (... (editor-text ed) (editor-index ed))]
        [(string=? ke "w") (... (editor-text ed) (editor-index ed))]
        [(string=? ke "x") (... (editor-text ed) (editor-index ed))]
        [(string=? ke "y") (... (editor-text ed) (editor-index ed))]
        [(string=? ke "z") (... (editor-text ed) (editor-index ed))]
        [(string=? ke " ") (... (editor-text ed) (editor-index ed))]
        [(string=? ke "left") (... (editor-text ed) (editor-index ed))]
        [(string=? ke "right") (... (editor-text ed) (editor-index ed))]))

;; Editor -> String
;; Creates string-first
;; interp. the string ahead of cursor location
(check-expect (string-first EX1) "abc")
(define (string-first ed) (substring (editor-text ed) 0 (editor-index ed)))
 
;; Editor -> String
;; Creates string-last
;; Creates the string after the cursor
(check-expect (string-last EX1) "def")
(define (string-last ed) (substring (editor-text ed)
                                    (editor-index ed)
                                    (string-length (editor-text ed))))  

;; String -> String
;; create string-remove-last
;; interp. removes the last letter from a string
;; !!!
(define (string-remove-last ed) "") 

;; Editor -> Image
;; Consumes editor and renders the data as information on the screen
;; as a basic string of text with a cursor at locaiton index
(check-expect (render (make-editor "Hello World" 11)) (place-image (beside (text "Hello World" 16 "black") CURSOR) CTR-X CTR-Y MTS))

(define (render ed)
  (place-image (beside (text (editor-text ed) 16 "black") CURSOR CTR-X CTR-Y MTS)))