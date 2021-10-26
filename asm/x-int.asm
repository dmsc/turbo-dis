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

X_DIV       jsr X_FDIV

X_TRUNC .proc
            jsr X_POPVAL
            lda FR0
            and #$7F
            sec
            sbc #$40
            bcc X_INT.SETZ
            tax
            lda #$00
LDAF6       cpx #$04
            bcs X_INT.RETVAL
            sta FR0+2,X
            inx
            bcc LDAF6
        .endp

X_INT   .proc
            jsr X_POPVAL
            lda FR0
            and #$7F
            sec
            sbc #$40
            bcc LDB3A
            tax
            cpx #$04
            bcs X_FRAC.INCRET
            lda #$00
            tay
LDB13       ora FR0+2,X
            sty FR0+2,X
            inx
            cpx #$04
            bne LDB13
            bit FR0
            bpl RETVAL
            tay
            beq RETVAL
ADD1        lda #$C0
            sta FR1
            ldy #$01
            sty FR1+1
            dey
            sty FR1+2
            sty FR1+3
            sty FR1+4
            sty FR1+5
            jsr T_FADD
RETVAL      jmp X_PUSHVAL
LDB3A       asl FR0
SETZ        jsr T_ZFR0
            bcc RETVAL
            bcs ADD1
        .endp

; vi:syntax=mads
