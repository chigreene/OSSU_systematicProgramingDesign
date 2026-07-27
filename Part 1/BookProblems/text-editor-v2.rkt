;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname text-editor-v2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
;; ==========================

(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor String String)
; interpretation (make-editor s t) describes an editor
; whose visible text is (string-append s t) with 
; the cursor displayed between s and t

(define EX1 (make-editor "abc" "def"))
(define EX2 (make-editor "ab" "cdef"))
(define EX3 (make-editor "" "abcdef"))
(define EX4 (make-editor "abcdef" ""))
(define EX5 (make-editor "aaaaaaaaaaa"
                         "aaaaaaaaaaaa"))

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
(check-expect (edit EX1 "a") (make-editor "abca" "def"))
(check-expect (edit EX1 "b") (make-editor "abcb" "def"))
(check-expect (edit EX1 "c") (make-editor "abcc" "def"))
(check-expect (edit EX1 "d") (make-editor "abcd" "def"))
(check-expect (edit EX1 "e") (make-editor "abce" "def"))
(check-expect (edit EX1 "f") (make-editor "abcf" "def"))
(check-expect (edit EX1 "g") (make-editor "abcg" "def"))
(check-expect (edit EX1 "h") (make-editor "abch" "def"))
(check-expect (edit EX1 "i") (make-editor "abci" "def"))
(check-expect (edit EX1 "j") (make-editor "abcj" "def"))
(check-expect (edit EX1 "k") (make-editor "abck" "def"))
(check-expect (edit EX1 "l") (make-editor "abcl" "def"))
(check-expect (edit EX1 "m") (make-editor "abcm" "def"))
(check-expect (edit EX1 "n") (make-editor "abcn" "def"))
(check-expect (edit EX1 "o") (make-editor "abco" "def"))
(check-expect (edit EX1 "p") (make-editor "abcp" "def"))
(check-expect (edit EX1 "q") (make-editor "abcq" "def"))
(check-expect (edit EX1 "r") (make-editor "abcr" "def"))
(check-expect (edit EX1 "s") (make-editor "abcs" "def"))
(check-expect (edit EX1 "t") (make-editor "abct" "def"))
(check-expect (edit EX1 "u") (make-editor "abcu" "def"))
(check-expect (edit EX1 "v") (make-editor "abcv" "def"))
(check-expect (edit EX1 "w") (make-editor "abcw" "def"))
(check-expect (edit EX1 "x") (make-editor "abcx" "def"))
(check-expect (edit EX1 "y") (make-editor "abcy" "def"))
(check-expect (edit EX1 "z") (make-editor "abcz" "def"))
(check-expect (edit EX1 " ") (make-editor "abc " "def"))
 
;; Backspace tests
(check-expect (edit EX1 "\b") (make-editor "ab" "def"))
(check-expect (edit EX3 "\b") (make-editor "" "abcdef"))
 
;; Left arrow tests
(check-expect (edit EX1 "left") (make-editor "ab" "cdef"))
(check-expect (edit EX3 "left") (make-editor "" "abcdef"))
(check-expect (edit EX4 "left") (make-editor "abcde" "f"))
 
;; Right arrow tests
(check-expect (edit EX1 "right") (make-editor "abcd" "ef"))
(check-expect (edit EX3 "right") (make-editor "a" "bcdef"))
(check-expect (edit EX4 "right") (make-editor "abcdef" ""))
 
;; Edge case: unrecognized key
(check-expect (edit EX1 "\t") EX1)

;; Text input greater than current field
(check-expect (edit EX5 "a") EX5)
 
(define (edit ed ke)
  (cond [(key=? ke "\b")(cond [(string=? (editor-pre ed) "") ed]
                              [else (make-editor (substring (editor-pre ed)
                                                 0
                                                 (- (string-length (editor-pre ed)) 1))
                                      (editor-post ed))])]
        [(>= (image-width (text (string-append (editor-pre ed) (editor-post ed)) 16 "black")) WIDTH) ed]
        [(key=? ke "a") (make-editor (string-append (editor-pre ed) "a") (editor-post ed))]
        [(key=? ke "b") (make-editor (string-append (editor-pre ed) "b") (editor-post ed))]
        [(key=? ke "c") (make-editor (string-append (editor-pre ed) "c") (editor-post ed))]
        [(key=? ke "d") (make-editor (string-append (editor-pre ed) "d") (editor-post ed))]
        [(key=? ke "e") (make-editor (string-append (editor-pre ed) "e") (editor-post ed))]
        [(key=? ke "f") (make-editor (string-append (editor-pre ed) "f") (editor-post ed))]
        [(key=? ke "g") (make-editor (string-append (editor-pre ed) "g") (editor-post ed))]
        [(key=? ke "h") (make-editor (string-append (editor-pre ed) "h") (editor-post ed))]
        [(key=? ke "i") (make-editor (string-append (editor-pre ed) "i") (editor-post ed))]
        [(key=? ke "j") (make-editor (string-append (editor-pre ed) "j") (editor-post ed))]
        [(key=? ke "k") (make-editor (string-append (editor-pre ed) "k") (editor-post ed))]
        [(key=? ke "l") (make-editor (string-append (editor-pre ed) "l") (editor-post ed))]
        [(key=? ke "m") (make-editor (string-append (editor-pre ed) "m") (editor-post ed))]
        [(key=? ke "n") (make-editor (string-append (editor-pre ed) "n") (editor-post ed))]
        [(key=? ke "o") (make-editor (string-append (editor-pre ed) "o") (editor-post ed))]
        [(key=? ke "p") (make-editor (string-append (editor-pre ed) "p") (editor-post ed))]
        [(key=? ke "q") (make-editor (string-append (editor-pre ed) "q") (editor-post ed))]
        [(key=? ke "r") (make-editor (string-append (editor-pre ed) "r") (editor-post ed))]
        [(key=? ke "s") (make-editor (string-append (editor-pre ed) "s") (editor-post ed))]
        [(key=? ke "t") (make-editor (string-append (editor-pre ed) "t") (editor-post ed))]
        [(key=? ke "u") (make-editor (string-append (editor-pre ed) "u") (editor-post ed))]
        [(key=? ke "v") (make-editor (string-append (editor-pre ed) "v") (editor-post ed))]
        [(key=? ke "w") (make-editor (string-append (editor-pre ed) "w") (editor-post ed))]
        [(key=? ke "x") (make-editor (string-append (editor-pre ed) "x") (editor-post ed))]
        [(key=? ke "y") (make-editor (string-append (editor-pre ed) "y") (editor-post ed))]
        [(key=? ke "z") (make-editor (string-append (editor-pre ed) "z") (editor-post ed))]
        [(key=? ke " ") (make-editor (string-append (editor-pre ed) " ") (editor-post ed))]
        [(key=? ke "\b")(cond [(string=? (editor-pre ed) "") ed]
                              [else (make-editor (substring (editor-pre ed)
                                                 0
                                                 (- (string-length (editor-pre ed)) 1))
                                      (editor-post ed))])]
        [(key=? ke "left") (cond [(string=? (editor-pre ed) "") ed]
                                 [else (make-editor (substring (editor-pre ed)
                                                 0
                                                 (- (string-length (editor-pre ed)) 1))
                                      (string-append
                                       (string-ith (editor-pre ed)
                                                   (- (string-length (editor-pre ed)) 1))
                                       (editor-post ed)))])]
        [(key=? ke "right") (cond [(string=? (editor-post ed) "") ed]
                                  [else (make-editor (string-append
                                          (editor-pre ed) (string-ith (editor-post ed) 0))
                                         (substring (editor-post ed)
                                                 1
                                                 (string-length (editor-post ed))))])]
        [else ed]))  

 
;; Editor -> Image
;; consumes editor and renders data as information on the screen
(define (render d) (place-image (beside (text (editor-pre d) 16 "black")
                           CURSOR
                           (text (editor-post d) 16 "black")) CTR-X CTR-Y MTS))




