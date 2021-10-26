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

X_XIO       jsr GETINT
            .byte $2C   ; Skip 2 bytes

X_OPEN  .proc
            lda #ICOPEN
            sta IOCMD
            jsr GETIOCHAN
            jsr GETINT
            pha
            jsr GETINT
            tay
            pla

.def :DO_CIO_STR

            pha
            tya
            pha
            ldy STINDEX
            iny
            cpy NXTSTD
            bcs CIO_DIRSPEC
            jsr EXEXPR
CIO_STR2    jsr SETSEOL
            jsr LDDVX
            pla
            sta IOCB0+ICAX2,X
            pla
            sta IOCB0+ICAX1,X
            jsr CIOV_LEN_FF
            jsr RSTSEOL
            jmp IOTEST

CIO_DIRSPEC lda #<IO_DIRSPEC
            ldx #>IO_DIRSPEC
            ldy #$05
            jsr PUSHSTR
            jmp CIO_STR2
        .endp

; vi:syntax=mads
