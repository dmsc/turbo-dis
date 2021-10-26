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

X_CLS       jsr X_CIRCLE.CLEAR_XYPOS
            lda DSPFLG
            pha
            stx DSPFLG
            jsr CHKIOCHAN
            ldy #$7D
            jsr PRCX
            pla
            sta DSPFLG
            jmp CIOERR_Y

; vi:syntax=mads
