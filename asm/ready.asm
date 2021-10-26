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

; Print READY prompt
PREADY  .proc
            ldx #$06
@           stx CIX
            lda READYMSG,X
            jsr PUTCHAR
            ldx CIX
            dex
            bpl @-
            rts

READYMSG    .byte CR, 'YDAER', CR
        .endp

; vi:syntax=mads
