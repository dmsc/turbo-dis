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

X_PPUT      lda #ICPUTCHR
            .byte $2C   ; Skip 2 bytes

X_PGET  .proc
            lda #ICGETCHR
            sta IOCMD
            jsr CHKIOCHAN
LC622       jsr GETFP
            jsr LDDVX
            lda #$D4
            sta INBUFF
            lda #$00
            sta INBUFF+1
            ldy #$06
            jsr CIOV_LEN_Y
            jsr T_LDBUFA
            jsr IOTEST
            lda IOCMD
            cmp #ICGETCHR
            bne LC644
            jsr RTNVAR
LC644       ldy STINDEX
            iny
            cpy NXTSTD
            bcc LC622
            rts
        .endp

; vi:syntax=mads
