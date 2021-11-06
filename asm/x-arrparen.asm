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

ATEMP = SCANT

X_ARRCOMMA  inc COMCNT
X_RPAREN    ldy OPSTKX
            pla
            pla
            jmp EXOPOP

X_DIMLPAREN lda #$40
            sta ADFLAG

X_ARRLPAREN .proc

            bit ADFLAG
            bpl ALP1
            lda ARSLVL
            sta ATEMP
            dec ARSLVL
ALP1        lda COMCNT
            tay
            beq ALP2
            dec COMCNT
            jsr X_POPINT
            bmi ERR_9_
ALP2        sty INDEX2+1
            sta INDEX2
            jsr X_POPINT
            bmi ERR_9_
            sta ZTEMP1
            sty ZTEMP1+1
            jsr X_POPVAL
            bit ADFLAG
            bvc ALP3
            lda #$00
            sta ADFLAG
            rts

ERR_9_      jmp ERR_9

ALP3        lsr VTYPE
            bcc ERR_9_
            lda ZTEMP1
            cmp FR0+2
            lda ZTEMP1+1
            sbc FR0+3
            bcs ERR_9_
            lda INDEX2
            cmp FR0+4
            lda INDEX2+1
            sbc FR0+5
            bcs ERR_9_
            lda FR0+5
            bne AMUL1
            ldy FR0+5
            dey
            bne AMUL1
            lda ZTEMP1
            sta ZTEMP4
            lda ZTEMP1+1
            sta ZTEMP4+1
            jmp AMUL6
AMUL1       ldy #$00            ; Multiply index by DIM2
            sty ZTEMP4
            sty ZTEMP4+1
            ldy #$10
AMUL1L      lsr FR0+5
            ror FR0+4
            bcc AMUL1A
            clc
            lda ZTEMP4
            adc ZTEMP1
            sta ZTEMP4
            lda ZTEMP4+1
            adc ZTEMP1+1
            sta ZTEMP4+1
AMUL1A      asl ZTEMP1
            rol ZTEMP1+1
            dey
            bne AMUL1L
AMUL6       clc                 ; Multiply index by 6
            lda INDEX2
            adc ZTEMP4
            sta ZTEMP1
            lda INDEX2+1
            adc ZTEMP4+1
            asl ZTEMP1
            rol
            sta ZTEMP1+1
            tay
            lda ZTEMP1
            asl
            rol ZTEMP1+1
            adc ZTEMP1
            tax
            tya
            adc ZTEMP1+1
            tay
            txa
            adc FR0
            tax
            tya
            adc FR0+1
            tay
            txa
            adc STARP
            sta ZTEMP1
            tya
            adc STARP+1
            sta ZTEMP1+1
            bit ADFLAG
            bpl ALP8
            ldx ATEMP
            stx ARSLVL
            dec ARSLVL
            ldy #$00
            sty ADFLAG
            lda ARGSTK0,X
            sta (ZTEMP1),Y
            iny
            lda ARGSTK1,X
            sta (ZTEMP1),Y
            iny
            lda ARGSTK2,X
            sta (ZTEMP1),Y
            iny
            lda ARGSTK3,X
            sta (ZTEMP1),Y
            iny
            lda ARGSTK4,X
            sta (ZTEMP1),Y
            iny
            lda ARGSTK5,X
            sta (ZTEMP1),Y
            rts
ALP8        inc ARSLVL
            ldx ARSLVL
            ldy #$05
            lda (ZTEMP1),Y
            sta ARGSTK5,X
            dey
            lda (ZTEMP1),Y
            sta ARGSTK4,X
            dey
            lda (ZTEMP1),Y
            sta ARGSTK3,X
            dey
            lda (ZTEMP1),Y
            sta ARGSTK2,X
            dey
            lda (ZTEMP1),Y
            sta ARGSTK1,X
            dey
            lda (ZTEMP1),Y
            sta ARGSTK0,X
            lsr VARSTK0,X
            rts
        .endp

; vi:syntax=mads
