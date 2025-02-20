#lang racket

;; Basic fee calculation
(define basic-fee
  (λ (days-overdue daily-rate)
    (* days-overdue daily-rate)))

;; Fiction books fee (higher rate after first week)
(define fiction-fee
  (λ (days-overdue)
    (+ (basic-fee (min days-overdue 7) 0.50)
       (basic-fee (max (- days-overdue 7) 0) 1.00))))

;; Non-fiction books fee (flat rate)
(define non-fiction-fee
  (λ (days-overdue)
    (basic-fee days-overdue 0.75)))

;; Reference books fee (higher flat rate)
(define reference-fee
  (λ (days-overdue)
    (basic-fee days-overdue 1.50)))

;; Student discount (20% off)
(define student-discount
  (λ (fee)
    (* fee 0.80)))

;; Senior citizen discount (30% off)
(define senior-discount
  (λ (fee)
    (* fee 0.70)))


;; Main fee calculation function
(define calculate-overdue-fee
  (λ (book-category days-overdue user-type)
    (let ([base-fee
           (cond
             [(eq? book-category 'fiction) (fiction-fee days-overdue)]
             [(eq? book-category 'non-fiction) (non-fiction-fee days-overdue)]
             [(eq? book-category 'reference) (reference-fee days-overdue)]
             [else (basic-fee days-overdue 0.50)])])  ; Default fee
      (cond
        [(eq? user-type 'student) (student-discount base-fee)]
        [(eq? user-type 'senior) (senior-discount base-fee)]
        [else base-fee]))))

;; Example usage and demonstration
(define (round-to-cents amount)
  (/ (round (* amount 100)) 100))

(define (demonstrate-fee-calculation)
  (displayln "Fee Calculation Examples:")
  (printf "Fiction book overdue by 10 days (regular user): $~a~n"
          (round-to-cents (calculate-overdue-fee 'fiction 10 'regular)))
  (printf "Non-fiction book overdue by 5 days (student): $~a~n"
          (round-to-cents (calculate-overdue-fee 'non-fiction 5 'student)))
  (printf "Reference book overdue by 3 days (senior): $~a~n"
          (round-to-cents (calculate-overdue-fee 'reference 3 'senior))))

(demonstrate-fee-calculation)
