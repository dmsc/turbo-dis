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

X_UNTIL .proc
            jsr EXEXPR
            jsr X_POP
            bcs ERR_23
            cmp #TOK_REPEAT
            bne ERR_22
            ldx ARSLVL
            ldy ARGSTK1,X
            bne RET
            lda #$04
            jsr RCONT
            lda #TOK_REPEAT
            jmp RETURN
RET         rts
        .endp

; vi:syntax=mads
