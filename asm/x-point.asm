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

X_POINT     jsr GETIOCHAN
            jsr GETINT
            jsr LDDVX
            lda FR0
            sta IOCB0+ICAX3,X
            lda FR0+1
            sta IOCB0+ICAX4,X
            jsr GETINT
            jsr LDDVX
            lda FR0
            sta IOCB0+ICAX5,X
            lda #ICPOINT
            sta IOCMD
            jmp GDIO1

; vi:syntax=mads
