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

X_RENAME    lda #ICRENAME
            .byte $2C   ; Skip 2 bytes

X_LOCK      lda #ICLOCKFL
            .byte $2C   ; Skip 2 bytes

X_UNLOCK    lda #ICUNLOCK
            .byte $2C   ; Skip 2 bytes

X_DELETE    lda #ICDELETE
            sta IOCMD
            lda #$07
            sta IODVC
            lda #$00
            tay
            jmp DO_CIO_STR

; vi:syntax=mads
