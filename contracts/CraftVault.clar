;; CraftVault: Handmade Pattern and Design Exchange Platform
;; Version: 1.0.0
(define-constant ERR-NOT-AUTHORIZED (err u1))
(define-constant ERR-PATTERN-NOT-FOUND (err u2))
(define-constant ERR-ALREADY-SHARED (err u3))
(define-constant ERR-INVALID-STATUS (err u4))
(define-constant ERR-INVALID-COMPLEXITY (err u5))
(define-constant ERR-INVALID-CRAFT-TYPE (err u6))
(define-constant ERR-INVALID-SKILL-LEVEL (err u7))
(define-constant ERR-INVALID-PATTERN-NAME (err u8))
(define-constant ERR-INVALID-INSTRUCTIONS (err u9))
(define-constant MIN-COMPLEXITY u1)
(define-data-var next-pattern-id uint u1)
(define-map pattern-archive
    uint
    {
        artisan: principal,
        pattern-name: (string-utf8 50),
        instructions: (string-utf8 200),
        craft-type: (string-utf8 15),
        skill-level: (string-utf8 10),
        sharing-status: (string-utf8 15),
        complexity-rating: uint
    }
)
(define-private (validate-craft-type (craft-type (string-utf8 15)))
    (or 
        (is-eq craft-type u"Knitting")
        (is-eq craft-type u"Crochet")
        (is-eq craft-type u"Sewing")
        (is-eq craft-type u"Quilting")
        (is-eq craft-type u"Embroidery")
        (is-eq craft-type u"Woodworking")
    )
)
(define-private (validate-skill-level (skill-level (string-utf8 10)))
    (or 
        (is-eq skill-level u"Starter")
        (is-eq skill-level u"Beginner")
        (is-eq skill-level u"Intermediate")
        (is-eq skill-level u"Advanced")
        (is-eq skill-level u"Expert")
    )
)
(define-private (validate-text-format (text (string-utf8 200)) (min-length uint) (max-length uint))
    (let 
        (
            (text-length (len text))
        )
        (and 
            (>= text-length min-length)
            (<= text-length max-length)
        )
    )
)
(define-public (share-pattern 
    (pattern-name (string-utf8 50))
    (instructions (string-utf8 200))
    (craft-type (string-utf8 15))
    (skill-level (string-utf8 10))
    (complexity-rating uint)
)
    (let
        (
            (pattern-id (var-get next-pattern-id))
        )
        (asserts! (validate-text-format pattern-name u3 u50) ERR-INVALID-PATTERN-NAME)
        (asserts! (validate-text-format instructions u10 u200) ERR-INVALID-INSTRUCTIONS)
        (asserts! (>= complexity-rating MIN-COMPLEXITY) ERR-INVALID-COMPLEXITY)
        (asserts! (validate-craft-type craft-type) ERR-INVALID-CRAFT-TYPE)
        (asserts! (validate-skill-level skill-level) ERR-INVALID-SKILL-LEVEL)
        
        (map-set pattern-archive pattern-id {
            artisan: tx-sender,
            pattern-name: pattern-name,
            instructions: instructions,
            craft-type: craft-type,
            skill-level: skill-level,
            sharing-status: u"open",
            complexity-rating: complexity-rating
        })
        (var-set next-pattern-id (+ pattern-id u1))
        (ok pattern-id)
    )
)
(define-public (restrict-pattern (pattern-id uint))
    (let
        (
            (pattern (unwrap! (map-get? pattern-archive pattern-id) ERR-PATTERN-NOT-FOUND))
        )
        (asserts! (is-eq tx-sender (get artisan pattern)) ERR-NOT-AUTHORIZED)
        (asserts! (is-eq (get sharing-status pattern) u"open") ERR-INVALID-STATUS)
        (ok (map-set pattern-archive pattern-id (merge pattern { sharing-status: u"restricted" })))
    )
)
(define-read-only (get-pattern (pattern-id uint))
    (ok (map-get? pattern-archive pattern-id))
)
(define-read-only (get-artisan (pattern-id uint))
    (ok (get artisan (unwrap! (map-get? pattern-archive pattern-id) ERR-PATTERN-NOT-FOUND)))
)