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

            ; Test if input is string constant
LSTCONST .proc
            jsr UCASEBUF
            lda (INBUFF),Y
            cmp #'"'
            beq LEAE3
            sec
            rts
LEAE3       lda #$0F
            jsr SETCODE
            lda COX
            sta EXSVOP
LEAEC       jsr SETCODE
            inc CIX
            ldy CIX
            lda (INBUFF),Y
            cmp #CR
            beq LEB06
            cmp #'"'
            bne LEAEC
            inc CIX
            iny
            lda (INBUFF),Y
            cmp #'"'
            beq LEAEC
LEB06       clc
            lda COX
            sbc EXSVOP
            ldy EXSVOP
            sta OUTBUFF,Y
            clc
            rts
        .endp

; vi:syntax=mads
