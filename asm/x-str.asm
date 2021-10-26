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

X_STRP  .proc
            jsr X_POPVAL
            jsr T_FASC
            ldy #$FF
LDA3C       iny
            lda (INBUFF),Y
            bpl LDA3C
            and #$7F
            sta (INBUFF),Y
            iny
            lda INBUFF
            bne RET_STR_A
        .endp

; vi:syntax=mads
