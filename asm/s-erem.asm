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

            ; Exit after parsing "REM" or "DATA", skip to parse next statement
LEREM   .proc
            ldx #$FF
            txs
            ldy #$04
            lda OUTBUFF,Y
            cmp #TOK_LREM
            bne GOLXDATA
            ldy CIX
            dey
            lda #CR
            sta (INBUFF),Y
            jmp SYNOK

GOLXDATA    jmp LXDATA
        .endp

; vi:syntax=mads
