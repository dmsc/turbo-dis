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

X_LPRINT    lda #<DEV_P_
            sta INBUFF
            lda #>DEV_P_
            sta INBUFF+1
            dec L00DB
            ldx #$07
            stx L00B5
            lda #$00
            ldy #$08
            jsr CIO_OPEN
            jsr IOTEST
            jsr X_PRINT
            jmp CLSYSD

; vi:syntax=mads
