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

STK_DUP2 .proc
            ldx ARSLVL
            dex
            inc ARSLVL
            inc ARSLVL
            clc
LDCC5       lda VARSTK0,X
            sta VARSTK0+2,X
            lda VARSTK0+1,X
            sta VARSTK0+3,X
            txa
            adc #$20
            tax
            bcc LDCC5
            rts
        .endp

X_MOD       jsr STK_DUP2
            jsr X_DIV
            jsr X_FMUL
            jmp X_FSUB

; vi:syntax=mads
