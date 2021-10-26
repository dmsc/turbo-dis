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

HEX_WORD .proc
            jsr T_LDBUFA
            ldy #$00
            lda FR0+1
            beq LDA11
            jsr HEX_BYTE
LDA11       lda FR0
HEX_BYTE    pha
            lsr
            lsr
            lsr
            lsr
            jsr HEX_DIGIT
            pla
            and #$0F
HEX_DIGIT   ora #'0'
            cmp #'9'+1
            bcc LDA26
            adc #'A'-'9'-2      ; -1 because carry is SET
LDA26       sta (INBUFF),Y
            iny
            rts
        .endp

X_HEXP      jsr X_POPINT
            jsr HEX_WORD
            lda #<LBUFF
            bne RET_STR_A

; vi:syntax=mads
