;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                            ;;
;; TurboBasic XL v1.5 disassembly, in MADS format.            ;;
;;                                                            ;;
;; Disassembled and translated to MADS by dmsc, 2017-2021     ;;
;;                                                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; This disassembly is based on the published TurboBasic XL binaries,
; and should be public-domain by now.
;

            ; Check for numeric binary operation
            ; NOTE: This is parsed with a syntax table in Atari BASIC
LOPR    .proc
            jsr SRCONT
            lda SVONTC
            cmp #CPND  ; Any operator before '#' is not binary
            bcc NOTBINOP
            cmp #CNOT  ; Also, 'NOT' is nor binary ...
            beq NOTBINOP
            cmp #CLPRN ; ... but all remaining before '(' are binary
            bcc BINOP
            cmp #CIAND ; Now, check extended operators: '&',
            beq BINOP
            cmp #CIOR  ; '!'
            beq BINOP
            cmp #CEXOR ; 'EXOR'
            beq BINOP
            cmp #CFDIV ; 'DIV'
            beq BINOP
            cmp #CMOD  ; and 'MOD'
            beq BINOP
NOTBINOP    sec
            rts
BINOP       jmp SONT2
        .endp

; vi:syntax=mads
