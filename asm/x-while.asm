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

X_WHILE .proc
            jsr X_GS
            jsr EXEXPR
            ldx ARSLVL
            lda ARGSTK1,X
            bne X_UNTIL.RET
            jsr X_POP
            lda #TOK_WHILE
            ldx #TOK_WEND
            jmp SKIP_STMT
        .endp

; vi:syntax=mads
