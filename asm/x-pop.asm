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

X_POP   .proc
            lda RUNSTK+1
            cmp TOPRSTK+1
            bcc @+
            lda RUNSTK
            cmp TOPRSTK
            bcs RTS1_SEC
@           sec
            lda TOPRSTK
            sbc #$04
            sta TOPRSTK
            sta APPMHI
            bcs @+
            dec TOPRSTK+1
            dec APPMHI+1
@           ldy #$03
            lda (TOPRSTK),Y
            sta SVDISP
            dey
            lda (TOPRSTK),Y
            sta TSLNUM+1
            dey
            lda (TOPRSTK),Y
            sta TSLNUM
            dey
            lda (TOPRSTK),Y
            bne RTS1_CLC
            tay
            sec
            lda TOPRSTK
            sbc #$0D
            sta TOPRSTK
            sta APPMHI
            bcs @+
            dec TOPRSTK+1
            dec APPMHI+1
@           tya
RTS1_CLC    clc
            rts
RTS1_SEC    sec
            rts
        .endp

; vi:syntax=mads
