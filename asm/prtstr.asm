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

; Print a string terminated with high bit set, LPRTOKEN in Atari BASIC
LPRTOKEN .proc
            ldy #$FF
            sty SCANT
LF1E6       inc SCANT
            ldy SCANT
            lda (SCRADR),Y
            pha
            cmp #CR
            beq LF1F5
            and #$7F
            beq LF1F8
LF1F5       jsr PUTCHAR
LF1F8       pla
            bpl LF1E6
            rts
        .endp

; Print string surrounded by spaces, LPTWB in Atari BASIC
P_SPCSTR    jsr P_SPC
; Print string followed by a space, LPTTB in Atari BASIC
P_STR_SPC   jsr LPRTOKEN
; Print a space, LPBLNK in Atari BASIC
P_SPC       lda #' '
            jmp PUTCHAR

; vi:syntax=mads
