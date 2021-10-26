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

        ; Get Positive Integer from Expression
GETPINT     jsr GETINT
            bpl GSTRAD.RET
            lda #$07
            jmp SERROR
        ; Get 3 integers
GET3INT     jsr GETINT
            sta L0099
            sty L009A
        ; Get 2 integers
GET2INT     jsr GETINT
            sta L009B
            sty L009C
        ; Ger Integer Expression
GETINT      jsr EXEXPR
        ; "GTINTO" in Atari BASIC
X_POPINT    jsr X_POPVAL
            jsr T_FPI
            bcs ERR_3
            lda FR0
            ldy FR0+1
            rts

        ; "GET1INT" in Atari BASIC: Get One-Byte Integer from Expression
GETBYTE     jsr GETINT
            beq GSTRAD.RET
ERR_3       lda #$03
            .byte $2C   ; Skip 2 bytes
ERR_9       lda #$09
            .byte $2C   ; Skip 2 bytes
ERR_11      lda #$0B
            .byte $2C   ; Skip 2 bytes
ERR_10      lda #$0A
            jmp SERROR

; vi:syntax=mads
