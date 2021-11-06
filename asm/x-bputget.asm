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

X_BPUT      lda #ICPUTCHR
            .byte $2C   ; Skip 2 bytes
X_BGET      lda #ICGETCHR
            pha
            jsr GETIOCHAN
            jsr GET2INT
            jsr LDDVX
            lda MVTA
            sta IOCB0+ICBAL,X
            lda MVTA+1
            sta IOCB0+ICBAH,X
            lda FR0
            sta IOCB0+ICBLL,X
            lda FR0+1
            sta IOCB0+ICBLH,X
            pla
CIOV_COME   jsr CIOV_COM
            jmp CIOERR_Y

; vi:syntax=mads
