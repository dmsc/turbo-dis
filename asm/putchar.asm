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

PUTEOL      lda #CR
PUTCHAR     ldx L00B5
PUTCHR1     tay
            jsr GLPX
PRCX        lda IOCB0+ICAX1,X
            sta ICAX1Z
            lda IOCB0+ICAX2,X
            sta ICAX2Z
            jsr PDUM_ROM
CIOERR_Y    tya
            jmp CIOERR_A

; vi:syntax=mads
