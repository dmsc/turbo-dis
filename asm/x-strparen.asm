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

X_STRLPAREN .proc
            lda COMCNT
            beq XSLP2
            jsr POPINT_NZ
            sty INDEX2+1
            sta INDEX2
XSLP2       jsr POPINT_NZ
            sec
            sbc #1
            sta ZTEMP1
            tya
            sbc #0
            sta ZTEMP1+1
            jsr X_POPVAL
            lda ADFLAG
            bpl XSLP3
            ora COMCNT
            sta ADFLAG
            ldy FR0+5
            lda FR0+4
            jmp XSLP4
XSLP3       lda FR0+2
            ldy FR0+3
XSLP4       ldx COMCNT
            beq XSLP6
            dec COMCNT
            cpy INDEX2+1
            bcc XSLER
            bne XSLP5
            cmp INDEX2
            bcc XSLER
XSLP5       ldy INDEX2+1
            lda INDEX2
XSLP6       sec
            sbc ZTEMP1
            sta FR0+2
            tax
            tya
            sbc ZTEMP1+1
            sta FR0+3
            bcc XSLER
            tay
            bne XSLP7
            txa
            beq XSLER
XSLP7       jsr GSTRAD
            clc
            lda FR0
            adc ZTEMP1
            sta FR0
            lda FR0+1
            adc ZTEMP1+1
            sta FR0+1
            bit ADFLAG
            bpl XSLP8
RTS_0B      rts

XSLP8       jmp X_PUSHVAL

POPINT_NZ   jsr X_POPINT
            bne RTS_0B
            tax
            bne RTS_0B
XSLER       lda #$05
            jmp SERROR
        .endp

; vi:syntax=mads
