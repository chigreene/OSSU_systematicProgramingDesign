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
(check-expect (edit EX1 "a") (make-editor "abcadef" 4))
(check-expect (edit EX1 "b") (make-editor "abcbdef" 4))
(check-expect (edit EX1 "c") (make-editor "abccdef" 4))
(check-expect (edit EX1 "d") (make-editor "abcddef" 4))
(check-expect (edit EX1 "e") (make-editor "abcedef" 4))
(check-expect (edit EX1 "f") (make-editor "abcfdef" 4))
(check-expect (edit EX1 "g") (make-editor "abcgdef" 4))
(check-expect (edit EX1 "h") (make-editor "abchdef" 4))
(check-expect (edit EX1 "i") (make-editor "abcidef" 4))
(check-expect (edit EX1 "j") (make-editor "abcjdef" 4))
(check-expect (edit EX1 "k") (make-editor "abckdef" 4))
(check-expect (edit EX1 "l") (make-editor "abcldef" 4))
(check-expect (edit EX1 "m") (make-editor "abcmdef" 4))
(check-expect (edit EX1 "n") (make-editor "abcndef" 4))
(check-expect (edit EX1 "o") (make-editor "abcodef" 4))
(check-expect (edit EX1 "p") (make-editor "abcpdef" 4))
(check-expect (edit EX1 "q") (make-editor "abcqdef" 4))
(check-expect (edit EX1 "r") (make-editor "abcrdef" 4))
(check-expect (edit EX1 "s") (make-editor "abcsdef" 4))
(check-expect (edit EX1 "t") (make-editor "abctdef" 4))
(check-expect (edit EX1 "u") (make-editor "abcudef" 4))
(check-expect (edit EX1 "v") (make-editor "abcvdef" 4))
(check-expect (edit EX1 "w") (make-editor "abcwdef" 4))
(check-expect (edit EX1 "x") (make-editor "abcxdef" 4))
(check-expect (edit EX1 "y") (make-editor "abcydef" 4))
(check-expect (edit EX1 "z") (make-editor "abczdef" 4))
(check-expect (edit EX1 " ") (make-editor "abc def" 4))
 
;; Backspace tests
(check-expect (edit EX1 "\b") (make-editor "abdef" 2))
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
  (cond [(key=? ke "\b")(cond [(= (editor-index ed) 0)  ed]
                              [else (make-editor (string-append (string-remove-last ed) (string-last ed))
                                        (- (editor-index ed) 1))])]
        [(>= (image-width (text (editor-text ed) 16 "black")) WIDTH) ed]
        [(string=? ke "a") (make-editor (string-append (string-first ed) "a" (string-last ed))
                                        (+ 1 (editor-index ed)))]
        [(string=? ke "b") (make-editor (string-append (string-first ed) "b" (string-last ed))
                                        (+ 1 (editor-index ed)))] 
        [(string=? ke "c") (make-editor (string-append (string-first ed) "c" (string-last ed))
                                        (+ 1 (editor-index ed)))]
        [(string=? ke "d") (make-editor (string-append (string-first ed) "d" (string-last ed))
                                        (+ 1 (editor-index ed)))]
        [(string=? ke "e") (make-editor (string-append (string-first ed) "e" (string-last ed))
                                        (+ 1 (editor-index ed)))]
        [(string=? ke "f") (make-editor (string-append (string-first ed) "f" (string-last ed))
                                        (+ 1 (editor-index ed)))]
        [(string=? ke "g") (make-editor (string-append (string-first ed) "g" (string-last ed))
                                        (+ 1 (editor-index ed)))]
        [(string=? ke "h") (make-editor (string-append (string-first ed) "h" (string-last ed))
                                        (+ 1 (editor-index ed)))]
        [(string=? ke "i") (make-editor (string-append (string-first ed) "i" (string-last ed))
                                        (+ 1 (editor-index ed)))]
        [(string=? ke "j") (make-editor (string-append (string-first ed) "j" (string-last ed))
                                        (+ 1 (editor-index ed)))]
        [(string=? ke "k") (make-editor (string-append (string-first ed) "k" (string-last ed))
                                        (+ 1 (editor-index ed)))]
        [(string=? ke "l") (make-editor (string-append (string-first ed) "l" (string-last ed))
                                        (+ 1 (editor-index ed)))]
        [(string=? ke "m") (make-editor (string-append (string-first ed) "m" (string-last ed))
                                        (+ 1 (editor-index ed)))]
        [(string=? ke "n") (make-editor (string-append (string-first ed) "n" (string-last ed))
                                        (+ 1 (editor-index ed)))]
        [(string=? ke "o") (make-editor (string-append (string-first ed) "o" (string-last ed))
                                        (+ 1 (editor-index ed)))]
        [(string=? ke "p") (make-editor (string-append (string-first ed) "p" (string-last ed))
                                        (+ 1 (editor-index ed)))]
        [(string=? ke "q") (make-editor (string-append (string-first ed) "q" (string-last ed))
                                        (+ 1 (editor-index ed)))]
        [(string=? ke "r") (make-editor (string-append (string-first ed) "r" (string-last ed))
                                        (+ 1 (editor-index ed)))]
        [(string=? ke "s") (make-editor (string-append (string-first ed) "s" (string-last ed))
                                        (+ 1 (editor-index ed)))]
        [(string=? ke "t") (make-editor (string-append (string-first ed) "t" (string-last ed))
                                        (+ 1 (editor-index ed)))]
        [(string=? ke "u") (make-editor (string-append (string-first ed) "u" (string-last ed))
                                        (+ 1 (editor-index ed)))]
        [(string=? ke "v") (make-editor (string-append (string-first ed) "v" (string-last ed))
                                        (+ 1 (editor-index ed)))]
        [(string=? ke "w") (make-editor (string-append (string-first ed) "w" (string-last ed))
                                        (+ 1 (editor-index ed)))]
        [(string=? ke "x") (make-editor (string-append (string-first ed) "x" (string-last ed))
                                        (+ 1 (editor-index ed)))]
        [(string=? ke "y") (make-editor (string-append (string-first ed) "y" (string-last ed))
                                        (+ 1 (editor-index ed)))]
        [(string=? ke "z") (make-editor (string-append (string-first ed) "z" (string-last ed))
                                        (+ 1 (editor-index ed)))]
        [(string=? ke " ") (make-editor (string-append (string-first ed) " " (string-last ed))
                                        (+ 1 (editor-index ed)))]
        [(string=? ke "left") (cond [(= (editor-index ed) 0) ed]
                                    [else (make-editor (editor-text ed) (- (editor-index ed) 1))])]
        [(string=? ke "right") (cond [(= (editor-index ed) (string-length (editor-text ed))) ed]
                                     [else (make-editor (editor-text ed) (+ (editor-index ed) 1))])]
       
        [else ed])) 
  
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
(check-expect (string-remove-last EX1) "ab")
(define (string-remove-last ed) (substring (string-first ed) 0 (- (editor-index ed) 1)))

;; Editor -> Image
;; Consumes editor and renders the data as information on the screen
;; as a basic string of text with a cursor at locaiton index
(check-expect (render (make-editor "Hello World" 11))
              (place-image (beside (text "Hello World" 16 "black") CURSOR)
                           CTR-X
                           CTR-Y
                           MTS))
(check-expect (render (make-editor "Hello World" 5))
              (place-image (beside (text "Hello" 16 "black")
                                   CURSOR
                                   (text " World" 16 "black"))
                           CTR-X
                           CTR-Y
                           MTS))

(define (render ed)
  (place-image (beside (text (string-first ed) 16 "black")
                                   CURSOR
                                   (text (string-last ed) 16 "black"))
                           CTR-X
                           CTR-Y
                           MTS))  