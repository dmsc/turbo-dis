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

; Open "alternate" device (IO channel #7)
ELADVC      ldy #$07
OPEN_Y_CHN  sty IODVC
            pha
            jsr LDDVX
            jsr IO_CLOSE
            ldy #ICOPEN
            sty IOCMD
            pla
            ldy #$00
            jsr DO_CIO_STR
            lda #$07
            rts

; vi:syntax=mads
