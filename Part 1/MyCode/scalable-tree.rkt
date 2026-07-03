;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname scalable-tree) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; constants

(define WIDTH 500)
(define HEIGHT 500)

(define T 1)

;; graphical constants

(define MTSCN (empty-scene WIDTH HEIGHT))

;; functions

(define (trunk T) (rectangle (* 15 T) (* 45 T) "solid" "brown"))
(define (branches T) (triangle (* 60 T) "solid" "green"))
(define (tree T) (overlay/offset (trunk T) 0 (* -44 T) (branches T))) 