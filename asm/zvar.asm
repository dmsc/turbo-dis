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

        ; Zero Variable
ZVAR    .proc
            ldx VVTP
            stx ZTEMP1
            ldy VVTP+1
            sty ZTEMP1+1
ZVAR1       ldx ZTEMP1
            cpx ENDVVT
            lda ZTEMP1+1
            sbc ENDVVT+1
            bcs ZVAR2
            ldy #$00
            lda (ZTEMP1),Y
            and #$FC
            sta (ZTEMP1),Y
            ldy #$02
            ldx #$06
            lda #$00
@           sta (ZTEMP1),Y
            iny
            dex
            bne @-
            lda ZTEMP1
            clc
            adc #$08
            sta ZTEMP1
            lda ZTEMP1+1
            adc #$00
            sta ZTEMP1+1
            bne ZVAR1
ZVAR2       jmp GEN_LNHASH
        .endp

; vi:syntax=mads
