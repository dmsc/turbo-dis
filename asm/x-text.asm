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

X_TEXT  .proc

FNTPTR = MVLNG  ; Use MVLNG as font pointer

            jsr GET2INT
            sta L0099
            bne TS_RTS
            jsr EXEXPR
            ldx ARSLVL
            lda VARSTK0,X
            bmi @+
            ; Convert number to string
            jsr X_STRP
@           jsr X_POPSTR
TXT_NXTCH   lda FR0+2
            ora FR0+3
            beq TS_RTS
            ldy #$00
            sty L00DB
            sty L00DC
            lda (FR0),Y
            bpl @+
            dec L00DB
@           jsr ATA2SCR
            asl
            asl
            sta FNTPTR
            lda #$00
            rol
            asl FNTPTR
            rol
            adc CHBAS
            sta FNTPTR+1
            jsr PREPLOT
            bcs TS_RTS
            ; Plot one row of the character
TXT_NROW    ldy #$08
            sty L00DD
            ldy L00DC
            lda (FNTPTR),Y
            eor L00DB
            sta L00DA
            ldx L00ED
            ldy FR1+3
TXT_NCOL    asl L00DA
            lda (L00DE),Y
            and PLOT_MASK,X
            bcc @+
            ora PLOT_PIX,X
@           sta (L00DE),Y
            dec L00DD
            beq TXT_ECOL
            jsr PLOT_ICOL
            cpy FR1+1
            bcc TXT_NCOL
            ; End of column, increment row
TXT_ECOL    jsr PLOT_IROW.SKP
            inc L00DC
            lda L00DC
            cmp #$08
            bcs @+
            adc L0099
            cmp FR1
            bcc TXT_NROW
            ; Next character
@           lda L009B
            adc #$07
            sta L009B
            bcc @+
            inc L009C
@           inc FR0
            bne @+
            inc FR0+1
@           lda FR0+2
            bne @+
            dec FR0+3
@           dec FR0+2
            jmp TXT_NXTCH

        .endp

            ; Transform ATASCII to screen code
ATASCR_T    .byte $40,$20,$60,$00

ATA2SCR .proc
            tay
            asl
            asl
            rol
            rol
            and #$03
            tax
            tya
            eor ATASCR_T,X
            rts
        .endp

; vi:syntax=mads
