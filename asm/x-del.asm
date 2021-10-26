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

X_DEL   .proc
            jsr X_GS
            jsr UNFIX_RSTK
            jsr GETPINT
            sta TSLNUM
            sty TSLNUM+1
            jsr GETPINT
            jsr SRCHLN_NC
LC013       ldy #$01
            lda (STMCUR),Y
            cmp FR0+1
            bne LC020
            dey
            lda (STMCUR),Y
            cmp FR0
LC020       bcc LC024
            bne LC03A
LC024       ldy #$02
            clc
            lda (STMCUR),Y
            tay
            adc STMCUR
            sta STMCUR
            bcc LC032
            inc STMCUR+1
LC032       ldx #STMCUR
            jsr CONTLOW
            jmp LC013
LC03A       jsr FIX_RSTK
            jmp POP_RETURN
        .endp

; vi:syntax=mads
