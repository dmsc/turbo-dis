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

?RTS_2      rts

TERMTST     cmp #$0F
            bne SRCONT
            inc CPC
            bne @+
            inc CPC+1
@           ldx #$00
            lda (CPC,X)
            clc
            dec COX

SETCODE .proc
            ldy COX
            sta OUTBUFF,Y
            inc COX
            bne ?RTS_2
        .endp

ERR_14  .proc
            lda #$0E
            jmp SERROR
        .endp

; vi:syntax=mads
