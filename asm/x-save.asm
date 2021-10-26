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

X_SAVE  .proc
            lda #$08
            jsr ELADVC
DO_SAVE     lda #ICPUTCHR
            sta IOCMD
            ldx #$80
LC34E       sec
            lda $00,X
            sbc LOMEM
            sta LBUFF-$80,X
            inx
            lda $00,X
            sbc LOMEM+1
            sta LBUFF-$80,X
            inx
            cpx #ENDSTAR
            bcc LC34E
            jsr LDDVX
            ldy #ENDSTAR-LOMEM
            jsr CIOV_LEN_Y
            jsr IOTEST
            ; LOAD / SAVE user area as block
LSBLK       jsr LDDVX
            lda VNTP
            sta INBUFF
            lda VNTP+1
            sta INBUFF+1
            ldy LBUFF+$0D
            dey
            tya
            ldy LBUFF+$0C
            jsr CIOV_LEN_AY
            jsr IOTEST
            jmp CLSYSD
        .endp

; vi:syntax=mads
