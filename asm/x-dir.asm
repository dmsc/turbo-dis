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

X_DIR   .proc
            lda #$06
            jsr ELADVC
LC5A5       ldx #$70
            jsr CIO_GETCHR
            bmi LC5B3
            ldx #$00
            jsr PUTCHR1
            bpl LC5A5
LC5B3       tya
            pha
            ldx #$70
            jsr IO_CLOSE
            pla
            cmp #$88
            beq LC5C2
            jmp SERROR
LC5C2       rts
        .endp

; vi:syntax=mads
