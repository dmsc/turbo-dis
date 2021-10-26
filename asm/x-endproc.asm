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

RET_ON_EXEC lda #TOK_ON
            bne RETURN

X_ENDPROC   jsr X_POP
            bcs ERR_28
            cmp #TOK_EXEC
            beq RETURN
            cmp #TOK_ENDPROC ; Used to signal "ON * EXEC"
            beq RET_ON_EXEC
            cmp #TOK_ON
            beq ERR_28
            cmp #TOK_GOSUB
            bne X_ENDPROC
            ; BUG: This should fall-through to ERR_28, instead it generates "ERROR 104"
ERR_LABEL   sec
            sbc #$A4    ; Generate ERROR from label type, $C1 -> ERR-29, $C2 -> ERR-30
            .byte $2C   ; Skip 2 bytes
ERR_28      lda #$1C
            jmp SERROR

; vi:syntax=mads
