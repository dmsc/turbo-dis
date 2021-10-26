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

X_DIM   .proc
            ldy STINDEX
            cpy NXTSTD
            bcc DC2
            rts
DC2         jsr EXEXPR
            lsr VTYPE
            bcs DCERR
            sec
            rol VTYPE
            bmi DCSTR
            lda ZTEMP1
            adc #$01
            sta ZTEMP1
            sta VTYPE+4
            lda ZTEMP1+1
            adc #$00
            bmi DCERR
            sta VTYPE+5
            sta ZTEMP1+1
            lda INDEX2
            adc #$01
            sta VTYPE+6
            lda INDEX2+1
            adc #$00
            sta VTYPE+7
            bmi DCERR

            ; JSR AMUL1 in Atari BASIC
            ldy #$00
            sty ZTEMP4
            sty ZTEMP4+1
            ldy #$10
AM1         lda ZTEMP1
            lsr
            bcc @+
            clc
            lda ZTEMP4
            adc FR0+4
            sta ZTEMP4
            lda ZTEMP4+1
            adc FR0+5
            sta ZTEMP4+1
            bmi DCERR
@           ror ZTEMP4+1
            ror ZTEMP4
            ror ZTEMP1+1
            ror ZTEMP1
            dey
            bne AM1

            ; JSR AMUL2 in Atari BASIC
            asl ZTEMP1
            rol ZTEMP1+1
            bmi DCERR
            ldx ZTEMP1+1
            lda ZTEMP1
            asl
            rol ZTEMP1+1
            bmi DCERR
            adc ZTEMP1
            sta ZTEMP1
            tay
            txa
            adc ZTEMP1+1
            sta ZTEMP1+1
            bpl DCEXP

DCERR       jmp ERR_9

DCSTR       lda #$00
            sta FR0+2
            sta FR0+3
            ldy ZTEMP1
            sty FR0+4
            lda ZTEMP1+1
            sta FR0+5
            bne DCEXP
            cpy #$00
            beq DCERR
DCEXP       ldx #ENDSTAR
            jsr EXPAND
            sec
            lda INDEX2   ; SVESA
            sbc STARP
            sta VTYPE+2
            lda INDEX2+1 ; SVESA+1
            sbc STARP+1
            sta VTYPE+3
            jsr RTNVAR

            ; Clear new array/string to zeroes
            lda #$00
            tay
            ldx ZTEMP1+1
            beq ACLR2
@           sta (INDEX2),Y
            iny
            bne @-
            inc INDEX2+1
            dex
            bne @-
ACLR2       ldx ZTEMP1
            beq ACLR3
@           sta (INDEX2),Y
            iny
            dex
            bne @-
ACLR3       jmp X_DIM
        .endp

; vi:syntax=mads
