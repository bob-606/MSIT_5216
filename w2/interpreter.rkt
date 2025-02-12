#lang racket
(require racket/match)

;;; --- Interpreter Implementation ---
(define env (make-hash))

(define (eval-expr expr)
  (match expr
    [(? number? n) n]
    [(? symbol? id) (hash-ref env id)]
    [`(+ ,e1 ,e2) (+ (eval-expr e1) (eval-expr e2))]
    [`(- ,e1) (- (eval-expr e1))] 
    [`(- ,e1 ,e2) (- (eval-expr e1) (eval-expr e2))] 
    [`(if ,cond ,then ,else) (if (eval-expr cond) (eval-expr then) (eval-expr else))]
    [else (error "Invalid expression: " expr)]))

(define (eval-stmt stmt)
  (match stmt
    [`(let ,id ,val) (hash-set! env id (eval-expr val))]
    [`(print ,expr) (displayln (eval-expr expr))]
    [else (error "Invalid statement: " stmt)]))

(define (eval-program program)
  (for-each eval-stmt program))


;;; --- Test Programs ---

;; Test 1: Basic arithmetic
(define program1
  '((let a 10)
    (let b 20)
    (print (+ a b)))) ; Output: 30

;; Test 2: Variable reassignment
(define program2
  '((let x 5)
    (print x)     ; Output: 5
    (let x 10)
    (print x)))   ; Output: 10

;; Test 3: Nested addition
(define program3
  '((let a 1)
    (let b (+ a 2))
    (let c (+ (+ a b) 5))
    (print c))) ; Output: 9

;; Test 4: Truthy conditional 
(define program4
  '((let x 5)
    (let y (if x 100 200))
    (print y))) ; Output: 100

;; Test 5: Nested conditionals
(define program5
  '((let a 3)
    (let b 0)
    (print (if (+ a b) 
               (+ a (if (+ b 5) 20 30))
               0)))) ; Output: 23

;; Test 6: Zero is truthy
(define program6
  '((let x 0)
    (print (if x 1 0)))) ; Output: 1

;; Test 7: Multiple prints
(define program7
  '((print 5)
    (print (+ 3 4)))) ; Output: 5 then 7

;; Test 8: Undefined variable (error)
(define program8
  '((print z))) ; Error: z not found

;; Test 9: Complex conditional (FIXED)
(define program9
  '((let score 85)
    (let result (if (+ score (- 100)) 
                     (+ score 15)
                     0)) ; Added closing )
    (print result))) ; Output: 100


;;; --- Run Tests ---
(define (run-test program test-name)
  (displayln (format "~n=== Running Test: ~a ===" test-name))
  (hash-clear! env)
  (eval-program program))

;; Run all valid tests
(run-test program1 "Basic Arithmetic")
(run-test program2 "Variable Reassignment")
(run-test program3 "Nested Addition")
(run-test program4 "Truthy Conditional")
(run-test program5 "Nested Conditionals")
(run-test program6 "Zero is Truthy")
(run-test program7 "Multiple Prints")
(run-test program9 "Complex Conditional")
