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
            sbc $01,X
            sta MVLNG+1
            sec
            lda $00,X
            sta MVFA
            sbc ECSIZE
            sta MVTA
            lda $01,X
            sta MVFA+1
            sbc ECSIZE+1
            sta MVTA+1
L2644       sec
            lda $00,X
            sbc ECSIZE
            sta $00,X
            lda $01,X
            sbc ECSIZE+1
            sta $01,X
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
L2666       lda (MVFA),Y
            sta (MVTA),Y
            iny
            lda (MVFA),Y
            sta (MVTA),Y
            iny
            lda (MVFA),Y
            sta (MVTA),Y
            iny
            lda (MVFA),Y
            sta (MVTA),Y
            iny
            bne L2666
            inc MVFA+1
            inc MVTA+1
            dex
            bne L2666
L2683       ldx MVLNG
            beq L268F
L2687       lda (MVFA),Y
            sta (MVTA),Y
            iny
            dex
            bne L2687
L268F       dec PORTB
            rts
        .endp

; vi:syntax=mads
