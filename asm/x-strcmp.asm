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

STRCMP      jsr X_POPSTR
            jsr T_FMOVE
            jsr X_POPSTR
            ldy #$00
STRCMP1     lda FR0+2
            bne STRCMP2
            lda FR0+3
            beq STRCMP3
            dec FR0+3
STRCMP2     dec FR0+2
            tax
STRCMP3     php
            lda FR1+2
            bne STRCMP4
            lda FR1+3
            beq STRCMP9
            dec FR1+3
STRCMP4     dec FR1+2
            plp
            beq STRCMP7
            lda (FR0),Y
            cmp (FR1),Y
            bne STRCMP6
            inc FR0
            bne STRCMP5
            inc FR0+1
STRCMP5     inc FR1
            bne STRCMP1
            inc FR1+1
            bne STRCMP1
STRCMP6     bcs STRCMP8
STRCMP7     iny
            clc
STRCMP8     rts
STRCMP9     plp
            sec
            rts

; vi:syntax=mads
