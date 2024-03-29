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

X_BLOAD     lda #$00
            .byte $2C   ; Skip 2 bytes
X_BRUN  .proc
            lda #$80
            sta BLOADFLAG
            lda #<LOW_RTS
            ldy #>LOW_RTS
            sta RUNAD
            sty RUNAD+1
            lda #$04
            ldy #$01
            jsr OPEN_Y_CHN
            inc PORTB
            jsr BGET_WORD
            cmp #$FF
            bne BL_ERR_1
            iny
            bne BL_ERR_1
GETBLOCK    lda #<LOW_RTS
            ldy #>LOW_RTS
            sta INITAD
            sty INITAD+1
            jsr BGET_WORD
            cmp #$FF
            bne @+
            cpy #$FF
            beq GETBLOCK
@           sta IOCB0+ICBAL,X
            tya
            sta IOCB0+ICBAH,X
            jsr BGET_WORD
            sec
            sbc IOCB0+ICBAL,X
            sta IOCB0+ICBLL,X
            tya
            sbc IOCB0+ICBAH,X
            sta IOCB0+ICBLH,X
            inc IOCB0+ICBLL,X
            bne @+
            inc IOCB0+ICBLH,X
@           jsr CIOV
            tya
            bmi BL_ERR_A
            jsr JSR_INITAD
            lda IOCB1+ICSTA
            cmp #$03
            bne GETBLOCK
            ldx #$10
            lda #ICCLOSE
            sta IOCB0+ICCOM,X
            jsr CIOV
            bit BLOADFLAG
            bpl @+
            jsr JSR_RUNAD
@           lda #$FE
            sta PORTB
LOW_RTS     rts
BL_ERR_1    lda #$01
BL_ERR_A    tay
BL_ERR_Y    jsr DISROM
            tya
            jmp X_ERR

JSR_INITAD  jmp (INITAD)

JSR_RUNAD   jmp (RUNAD)
        .endp

BGET_WORD .proc
            lda #ICGETCHR
            ldx #$10
            sta IOCB0+ICCOM,X
            lda #$00
            sta IOCB0+ICBLL,X
            sta IOCB0+ICBLH,X
            jsr CIOV
            bmi X_BRUN.BL_ERR_Y
            pha
            lda #$00
            sta IOCB0+ICBLL,X
            jsr CIOV
            bmi X_BRUN.BL_ERR_Y
            tay
            pla
            rts
        .endp

; vi:syntax=mads
