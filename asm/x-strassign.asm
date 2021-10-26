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

X_STRASIGN  jsr X_POPSTR

RISASN  .proc
            lda FR0
            sta L0099
            lda FR0+1
            sta L009A
            lda FR0+2
            sta MVLNG
            ldy FR0+3
            sty MVLNG+1
            ldy OPSTKX
            beq XSA1
            lda #$80
            sta L00B1
            jsr EXOPOP
            lda FR0+3
            ldy FR0+2
            rol L00B1
            bcs XSA2A
XSA1        jsr X_POPSTR
            lda FR0+5
            ldy FR0+4
XSA2A       cmp MVLNG+1
            bcc XSA3
            bne XSA4
            cpy MVLNG
            bcs XSA4
XSA3        sta MVLNG+1
            sty MVLNG
XSA4        clc
            lda FR0
            sta L009B
            adc MVLNG
            tay
            lda FR0+1
            sta L009C
            adc MVLNG+1
            tax
            sec
            tya
            sbc STARP
            sta ZTEMP3
            txa
            sbc STARP+1
            sta ZTEMP3+1
            jsr DO_MOVEUP
            lda VNUM
            jsr GETVAR
            sec
            lda ZTEMP3
            sbc FR0
            tay
            lda ZTEMP3+1
            sbc FR0+1
            tax
            lda #$02
            and L00B1
            beq XSA5
            lda #$00
            sta L00B1
            cpx FR0+3
            bcc XSA6
            bne XSA5
            cpy FR0+2
            bcs XSA5
XSA6        rts

XSA5        sty FR0+2
            stx FR0+3
            jmp RTNVAR
        .endp

; vi:syntax=mads
