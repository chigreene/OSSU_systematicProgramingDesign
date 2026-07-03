;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Mouse) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)


(overlay/offset 

(overlay/offset (circle 65 "solid" "red") 100 100 

(overlay/offset (circle 20 "solid" "white") -30 40

(overlay/offset (circle 20 "solid" "white") 30 40
                (add-solid-curve (circle 100 "solid" "red")
                20 100 -80 2/3 180 100 80 2/3 "white"))
                ))
                120 -73 (circle 65 "solid" "red"))