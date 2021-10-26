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

        ; FP assign to destination variable
X_FPASIGN .proc
            ldy OPSTKX
            bne LC682
            dec ARSLVL
            ldx ARSLVL
            dec ARSLVL
            lda VARSTK1,X
            jsr VAR_PTR
            ldy #$02
            lda ARGSTK0+1,X
            sta (WVVTPT),Y
            iny
            lda ARGSTK1+1,X
            sta (WVVTPT),Y
            iny
            lda ARGSTK2+1,X
            sta (WVVTPT),Y
            iny
            lda ARGSTK3+1,X
            sta (WVVTPT),Y
            iny
            lda ARGSTK4+1,X
            sta (WVVTPT),Y
            iny
            lda ARGSTK5+1,X
            sta (WVVTPT),Y
            rts
LC682       lda #$80
            sta L00B1
            rts
        .endp

; vi:syntax=mads
