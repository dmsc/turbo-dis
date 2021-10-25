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

; Move memory up, freeing heap
CONTLOW     lda #$00
CONTRACT .proc
            sty ECSIZE
            sta ECSIZE+1
            sec
            lda TOPRSTK
            sbc $00,X
            sta MVLNG
            lda TOPRSTK+1
            sbc NGFLAG,X
            sta MVLNG+1
            sec
            lda $00,X
            sta L0099
            sbc ECSIZE
            sta L009B
            lda NGFLAG,X
            sta L009A
            sbc ECSIZE+1
            sta L009C
L2644       sec
            lda $00,X
            sbc ECSIZE
            sta $00,X
            lda NGFLAG,X
            sbc ECSIZE+1
            sta NGFLAG,X
            inx
            inx
            cpx #$92
            bcc L2644
            sta APPMHI+1
            lda TOPRSTK
            sta APPMHI

.def :DO_MOVEUP
            inc PORTB
            ldy #$00
            ldx MVLNG+1
            beq L2683
L2666       lda (L0099),Y
            sta (L009B),Y
            iny
            lda (L0099),Y
            sta (L009B),Y
            iny
            lda (L0099),Y
            sta (L009B),Y
            iny
            lda (L0099),Y
            sta (L009B),Y
            iny
            bne L2666
            inc L009A
            inc L009C
            dex
            bne L2666
L2683       ldx MVLNG
            beq L268F
L2687       lda (L0099),Y
            sta (L009B),Y
            iny
            dex
            bne L2687
L268F       dec PORTB
            rts
        .endp

; vi:syntax=mads
