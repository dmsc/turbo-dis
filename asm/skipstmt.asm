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

; Skip until a statement:
;  X = statement to search
;  A = statement that increases the search count (loop of above)
;  Y = ELSE statement if searching ENDIF
SKIP_STMT   ldy #$FF
SKIP_ELSE .proc
            stx SKP_SEARCH+1
            sta SKP_INCR+1
            sty SKP_ELSE+1
            lda #$00
            sta FR0+3
            lda STMCUR
            sta SAVCUR
            lda STMCUR+1
            sta SAVCUR+1
SKP_LOOP    ldy NXTSTD
            cpy LLNGTH
            bcs LF762
            lda (STMCUR),Y
            sta NXTSTD
            iny
            lda (STMCUR),Y
            iny
            sty STINDEX
SKP_SEARCH  cmp #$00
            beq LF740
SKP_INCR    cmp #$00
            beq LF749
SKP_ELSE    cmp #$00
            bne SKP_LOOP
            lda FR0+3
            bne SKP_LOOP
SKP_RTS     rts
LF740       lda FR0+3
            beq SKP_RTS
            dec FR0+3
            jmp SKP_LOOP
LF749       cmp #$07
            bne @+
            ldy NXTSTD
            dey
            lda (STMCUR),Y
            cmp #CTHEN
            beq SKP_LOOP
@           inc FR0+3
            bne SKP_LOOP
SKP_ERR     jsr RESCUR
.def :ERR_22
            lda #$16
            jmp SERROR
LF762       ldy #$01
            lda (STMCUR),Y
            bmi SKP_ERR
            clc
            lda LLNGTH
            adc STMCUR
            sta STMCUR
            bcc @+
            inc STMCUR+1
@           ldy #$01
            lda (STMCUR),Y
            bmi SKP_ERR
            iny
            lda (STMCUR),Y
            sta LLNGTH
            iny
            sty NXTSTD
            jmp SKP_LOOP
        .endp

; vi:syntax=mads
