#lang sicp
;; Exercise 1.1: Below is a sequence of expressions. What is the
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
;; ;; Nota: mi primera implementación no es tan "Lispy"
(define (return-sq-two-max x y z)
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

;; Una implementación un poco funcional :)
(define (sum-square x y)
  (+ (* x x) (* y y))) ;; procedimiento que retorna la suma de cuadrados de dos números

(define (square-two-max x y z)
  (cond
    [(and (>= (+ x y) (+ y z)) (>= (+ x y) (+ x z))) (sum-square x y)]
    [(and (>= (+ x z) (+ y z)) (>= (+ x z) (+ x y))) (sum-square x z)]
    [else (sum-square y z)]))

;; *Exercise 1.4:* Observe that our model of evaluation allows for
;;      combinations whose operators are compound expressions. Use this
;;      observation to describe the behavior of the following procedure:

;;            (define (a-plus-abs-b a b)
;;              ((if (> b 0) + -) a b))

;; R/ Evalúa si (b > 0). Si es así, entonces se hace la suma (+ a b).
;; De lo contrario, se usa la resta (- a b), lo cual equivale a calcular:
;; (a + |b|) porque a - (-b).

;; *Exercise 1.5:* Ben Bitdiddle has invented a test to determine
;;  whether the interpreter he is faced with is using
;;  applicative-order evaluation or normal-order evaluation. He
;;  defines the following two procedures:
;;
;;       (define (p) (p))
;;
;;
;;       (define (test x y)
;;         (if (= x 0)
;;             0
;;             y))
;;
;;  Then he evaluates the expression
;;
;;          (test 0 (p))
;;
;;  What behavior will Ben observe with an interpreter that uses
;;  applicative-order evaluation? What behavior will he observe with
;;  an interpreter that uses normal-order evaluation? Explain your
;;  answer. (Assume that the evaluation rule for the special form
;;  `if' is the same whether the interpreter is using normal or
;;  applicative order: The predicate expression is evaluated first,
;;  and the result determines whether to evaluate the consequent or
;;  the alternative expression.)

;; r/ Bajo la evaluación por orden normal, el intérprete primero
;; sustituye los valores 0 y (p) en la expresión if. Luego, la nueva
;; expresión if se evalúa en su conjunto y da como resultado 0.

;; En la evaluación por orden aplicativa, el intérprete comienza
;; evaluando 0 y (p) por separado. Luego, (p) comenzará a auto-referenciarse
;; en un bucle infinito.


;; *Exercise 1.6:* Alyssa P. Hacker doesn't see why `if' needs to be
;; provided as a special form.  "Why can't I just define it as an
;; ordinary procedure in terms of `cond'?" she asks.  Alyssa's friend
;; Eva Lu Ator claims this can indeed be done, and she defines a new
;; version of `if':

;;      (define (new-if predicate then-clause else-clause)
;;         (cond (predicate then-clause)
;;            (else else-clause)))

;; Eva demonstrates the program for Alyssa:
;; (new-if (= 2 3) 0 5) => 5

;; (new-if (= 1 1) 0 5) => 0

;; Delighted, Alyssa uses new-if to rewrite the square-root
;; program:
;; (define (sqrt-iter guess x)
;;   (new-if (good-enough? guess x)
;;           guess
;;           (sqrt-iter (improve guess x) x)))
;; What happens when Alyssa attempts to use this to compute
;; square roots? Explain

;; R/ el problema es que new-if es una función y no una forma especial.
;; Esto significa que cada parámetro se evalúa antes de que se aplique
;; el procedimiento. Por lo tanto (good-enough? guess x) y (sqrt-iter (improve guess x) x)
;; se evalúan siempre, independientemente del resultado de (good-enough? guess x).
;; Dado que la segunda alternativa sqrt-iter (improve guess x) x llama a la función
;; recursivamente, esto resulta en un bucle infinito. En este caso, new-if nunca
;; se ejecuta.
