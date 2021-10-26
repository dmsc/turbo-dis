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

X_UINSTR    lda #$5F
            .byte $2C   ; Skip 2 bytes
X_INSTR .proc
            lda #$FF
            sta L00DF
            ldy COMCNT
            dey
            tya
            beq LDDC5
            jsr X_POPINT
LDDC5       sta L00DA
            sty L00DB
            jsr X_POPSTR
            jsr T_FMOVE
            jsr X_POPSTR
            clc
            lda FR0
            adc L00DA
            sta FR0
            lda FR0+1
            adc L00DB
            sta FR0+1
            bcs LDE03
            sec
            lda FR0+2
            sbc L00DA
            sta FR0+2
            lda FR0+3
            sbc L00DB
            sta FR0+3
            bcc LDE03
            ora FR0+2
            beq LDE03
            sec
            lda FR0+2
            sbc FR1+2
            sta L00DC
            lda FR0+3
            sbc FR1+3
            sta L00DD
            bcs LDE06
LDE03       jmp X_N0
LDE06       inc L00DA
            bne LDE0C
            inc L00DB
LDE0C       ldy #$00
            lda (FR1),Y
            eor (FR0),Y
            and L00DF
            bne LDE46
            lda FR0
            sta FR0+4
            lda FR0+1
            sta FR0+5
            lda FR1
            sta FR1+4
            lda FR1+1
            sta FR1+5
            lda FR1+3
            sta L00DE
            ldx FR1+2
            inx
LDE2D       dex
            bne LDE34
            dec L00DE
            bmi LDE59
LDE34       lda (FR0+4),Y
            eor (FR1+4),Y
            and L00DF
            bne LDE46
            iny
            bne LDE2D
            inc FR0+5
            inc FR1+5
            jmp LDE2D
LDE46       inc FR0
            bne LDE4C
            inc FR0+1
LDE4C       lda L00DC
            bne LDE54
            dec L00DD
            bmi LDE03
LDE54       dec L00DC
            jmp LDE06
LDE59       lda L00DA
            ldy L00DB
            jmp X_RET_AY

        .endp

; vi:syntax=mads
