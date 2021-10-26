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

X_NOTE      lda #ICNOTE
            jsr GDVCIO
            lda IOCB0+ICAX3,X
            ldy IOCB0+ICAX4,X
            jsr ISVAR
            jsr LDDVX
            lda IOCB0+ICAX5,X
            jmp ISVAR1

; vi:syntax=mads
