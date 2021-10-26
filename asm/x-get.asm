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

X_GET   .proc
            lda (STMCUR),Y
            cmp #CPND
            beq GET_IOC
GETK_LOOP   jsr GETKEYE
            jsr ISVAR1
            ldy STINDEX
            iny
            cpy NXTSTD
            bcc GETK_LOOP
            rts

GET_IOC     jsr GETIOCHAN
GET_LOOP    jsr LDDVX
GET1        jsr CIO_GETCHR
            tax
            tya
            jsr CIOERR_A
            txa
            jsr ISVAR1
            ldy STINDEX
            iny
            cpy NXTSTD
            bcc GET_LOOP
RTS94       rts

        .endp

; vi:syntax=mads
