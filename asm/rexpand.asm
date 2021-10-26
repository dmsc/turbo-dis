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

REXPAND .proc
            sta ECSIZE
            clc
            lda TOPRSTK
            sta TEMPA
            adc ECSIZE
            tay
            lda TOPRSTK+1
            sta TEMPA+1
            adc #$00
            cmp MEMTOP+1
            bcc LF672
            bne ERR_2
            cpy MEMTOP
            bcc LF672
            bne ERR_2
LF672       sta TOPRSTK+1
            sta APPMHI+1
            sty TOPRSTK
            sty APPMHI
            rts
        .endp

ERR_2       lda #$02
            jmp SERROR

; vi:syntax=mads
