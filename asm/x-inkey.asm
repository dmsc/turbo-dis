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

X_INKEYP .proc
            lda CH
            ldy #$00
            cmp #$C0
            bcs RET_STR_LY
            ldx #MUTED_KEYS_N-1
LDA55       cmp MUTED_KEYS,X
            beq RET_STR_LY
            dex
            bpl LDA55
            jsr GETKEYE
            jmp RET_CHRP
        .endp

; vi:syntax=mads
