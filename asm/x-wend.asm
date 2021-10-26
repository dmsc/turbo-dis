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

X_WEND  .proc
            jsr X_POP
            bcs ERR_24
            cmp #TOK_WHILE
            bne ERR_22
            jsr RETURN
            ldy SVDISP
            dey
            sty NXTSTD
            rts
        .endp

ERR_23      lda #$17
            .byte $2C   ; Skip 2 bytes
ERR_24      lda #$18
            jmp SERROR

; vi:syntax=mads
