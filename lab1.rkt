#lang racket
;; Exercise 1.1: Below is a sequence of expressions.  What is the
;;      result printed by the interpreter in response to each expression?
;;      Assume that the sequence is to be evaluated in the order in which
;;      it is presented.

10 ;; 10

(+ 5 3 4) ;; 12

(- 9 1) ;; 8

(/ 6 2) ;; 3

(+ (* 2 4) (- 4 6)) ;; 6

(define a 3) ;; a <- 3

(define b (+ a 1)) ;; b <- a + 1

(+ a b (* a b)) ;; 19

(= a b) ;; #f

(if (and (> b a) (< b (* a b))) ;; 4
    b
    a)

(cond
  [(= a 4) 6] ;; 16
  [(= b 4) (+ 6 7 a)]
  [else 25])

(+ 2 (if (> b a) b a)) ;; 6

(* (cond
     [(> a b) a] ;; 16
     [(< a b) b]
     [else -1])
   (+ a 1))

;; *Exercise 1.2:* Translate the following expression into prefix
;; form.

;; 5 + 4 + (2 - (3 - (6 + 4/5)))
;; -----------------------------
;;        3(6 - 2)(2 - 7)

;; mi r/
(/ (+ (+ 5 4) (- 2 (- 3 (+ 6 (/ 4 5))))) (* 3 (* (- 6 2) (- 2 7))))

;; *Exercise 1.3:* Define a procedure that takes three numbers as
;;     arguments and returns the sum of the squares of the two larger
;;     numbers.
;;
(define (return-sq-two-max x y z) ;; Nota: mi primera implementacion no es tan "Lispy

  (cond
    [(and (> x y) (> x z))
     (+ (* x x)
        (if (> y z)
            (* y y)
            (* z z)))]
    [(and (> y x) (> y z))
     (+ (* y y)
        (if (> x z)
            (* x x)
            (* z z)))]
    [(and (> z y) (> z x))
     (+ (* z z)
        (if (> x y)
            (* x x)
            (* y y)))]
    [else 0]))

;; Una implementacion un poco funcional :)
(define (sum-square x y)
  (+ (* x x) (* y y))) ;; procedure que retorna la suma de cuadrados de dos numeros

(define (square-two-max x y z)
  (cond
    [(and (>= (+ x y) (+ y z)) (>= (+ x y) (+ x z))) (sum-square x y)]
    [(and (>= (+ x z) (+ y z)) (>= (+ x z) (+ x y))) (sum-square x z)]
    [else (sum-square y z)]))
