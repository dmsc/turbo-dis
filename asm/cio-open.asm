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

; This is SOPEN in Atari Basic
CIO_OPEN .proc
            pha
            lda #ICOPEN
            jsr GLPCX
            pla
            sta IOCB0+ICAX2,X
            tya
            sta IOCB0+ICAX1,X
            jsr CIOV_NOLEN
            jmp T_LDBUFA        ; Restore INBUFF and return
        .endp

; vi:syntax=mads
