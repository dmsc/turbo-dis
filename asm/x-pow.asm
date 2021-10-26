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

JMP_N0      jmp X_N0
JMP_N1      jmp X_N1

POW_0       lda FR1
            bpl JMP_N0
ERR_3E      jmp ERR_3

X_POW   .proc
            jsr X_POPVAL2
            lda FR1
            beq JMP_N1
            lda FR0
            beq POW_0
            bpl LDBC2
            and #$7F
            sta FR0
            lda FR1
            and #$7F
            sec
            sbc #$40
            bcc ERR_3E
            ldx #$04
            cmp #$04
            beq LDBBD
            bcs LDBC2
            tax
            tay
LDBB3       lda FR1+2,Y
            bne ERR_3E
            iny
            cpy #$04
            bne LDBB3
LDBBD       lda FR1+1,X
            lsr
            bcs LDBC3
LDBC2       clc
LDBC3       lda #$00
            ror
            pha
            lda FR1
            cmp #$40
            bne POW_FP
            lda FR1+2
            ora FR1+3
            ora FR1+4
            ora FR1+5
            bne POW_FP
            lda FR1+1
            and #$F0
            lsr
            sta FLPTR
            lsr
            lsr
            adc FLPTR
            sta FLPTR
            lda FR1+1
            and #$0F
            adc FLPTR
            sta FLPTR
            jsr FMOVPLYARG
            lsr FLPTR
            bcs LDBF6
            jsr T_FLD1
LDBF6       jsr FMOVSCR
            lda FLPTR
            beq LDC4D
            jsr LDPLYARG
LDC00       jsr T_FSQ
            bcs ERR_11_
            lsr FLPTR
            bcc LDC00
            jsr FMOVPLYARG
            jsr LD1FPSCR
            jsr T_FMUL
            bcc LDBF6
ERR_11_     jmp ERR_11

ERR_3F      jmp ERR_3

POW_FP      lda FR1+5
            pha
            lda FR1+4
            pha
            lda FR1+3
            pha
            lda FR1+2
            pha
            lda FR1+1
            pha
            lda FR1
            pha
            jsr T_FCLOG
            bcs ERR_3F
            pla
            sta FR1
            pla
            sta FR1+1
            pla
            sta FR1+2
            pla
            sta FR1+3
            pla
            sta FR1+4
            pla
            sta FR1+5
            jsr T_FMUL
            bcs ERR_11_
            jsr T_EXP10
            bcs ERR_11_
LDC4D       pla
            bpl LDC54
            ora FR0
            sta FR0
LDC54       jmp X_PUSHVAL
        .endp

; vi:syntax=mads
