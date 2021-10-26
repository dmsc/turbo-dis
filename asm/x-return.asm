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

X_RETURN .proc
            jsr X_POP
            bcs RETURN.ERR_16
            cmp #TOK_GOSUB
            beq RETURN
            cmp #TOK_ON
            beq RETURN
            cmp #TOK_EXEC
            bne X_RETURN
            beq RETURN.ERR_16
        .endp

RETURN  .proc
            ldy SVDISP
            cmp (TSLNUM),Y
            bne ERR_15
            lda TSLNUM+1
            beq ERR_15
            sta STMCUR+1
            lda TSLNUM
            sta STMCUR
            dey
            lda (STMCUR),Y
            sta NXTSTD
            ldy #$02
            lda (STMCUR),Y
            sta LLNGTH
            rts

ERR_15      lda #$0F
            .byte $2C   ; Skip 2 bytes
ERR_16      lda #$10
            .byte $2C   ; Skip 2 bytes
        .endp

ERR_26      lda #$1A
            jmp SERROR

; vi:syntax=mads
