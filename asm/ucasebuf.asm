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

UCASEBUF .proc
            ldy CIX
LEB1F       lda (INBUFF),Y
            and #$7F
            cmp #' '
            bne LEB2A
            iny
            bne LEB1F
LEB2A       sty CIX
LEB2C       lda (INBUFF),Y
            cmp #CR
            beq LEB57
            and #$7F
            sta (INBUFF),Y
            cmp #'a'
            bcc LEB42
            cmp #'z'+1
            bcs LEB42
            and #$5F
            sta (INBUFF),Y
LEB42       iny
            cmp #'0'
            bcc LEB57
            cmp #'9'+1
            bcc LEB2C
            cmp #'A'
            bcc LEB57
            cmp #'Z'+1
            bcc LEB2C
            cmp #'_'
            beq LEB2C
LEB57       ldy CIX
            rts
        .endp

; vi:syntax=mads
