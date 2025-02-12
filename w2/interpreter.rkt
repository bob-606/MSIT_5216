#lang racket
(require racket/match)

; Define the environment as a hash table
(define env (make-hash))

; Function to evaluate expressions
(define (eval-expr expr)
  (match expr
    [(? number? n) n] ; Numbers evaluate to themselves
    [(? symbol? id) (hash-ref env id)] ; Look up identifiers
    [`(+ ,e1 ,e2) (+ (eval-expr e1) (eval-expr e2))] ; Addition
    [`(if ,cond ,then ,else) (if (eval-expr cond) (eval-expr then) (eval-expr else))] ; Conditional
    [else (error "Invalid expression: " expr)]))

; Function to evaluate statements
(define (eval-stmt stmt)
  (match stmt
    [`(let ,id ,val) (hash-set! env id (eval-expr val))] ; Variable assignment
    [`(print ,expr) (displayln (eval-expr expr))] ; Print statement
    [else (error "Invalid statement: " stmt)]))

; Function to evaluate a program
(define (eval-program program)
  (for-each eval-stmt program))

; Example program
(define program
  '[(let x 5)
    (let y 10)
    (print (+ x y))])

; Run the program
(eval-program program) ; Output: 15
