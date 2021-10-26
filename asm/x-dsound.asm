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

        .local

ENDSOUND    ldx #$07
            lda #$00
LC1CF       sta AUDF1,X
            dex
            bpl LC1CF
            rts

.def :ERR_3A    ; Used from SETCOLOR
            jmp ERR_3

        ; Use MVLNG as temporary
.def :X_DSOUND
            sta MVLNG
            iny
            cpy NXTSTD
            bcs ENDSOUND
            jsr GETBYTE
            ldy #$00
            bit MVLNG
            bpl LC1EC
            asl
            ldy #$78
LC1EC       cmp #$04
            bcs ERR_3A
            asl
            pha
            sty AUDCTL
            lda #$03
            sta SKCTL
            jsr GET3INT
            pla
            tax
            lda L0099
            sta AUDF1,X
            bit MVLNG
            bpl LC20F
            inx
            inx
            lda L009A
            sta AUDF1,X
LC20F       lda L009B
            asl
            asl
            asl
            asl
            ora FR0
            sta AUDC1,X
            rts
        .endl

; vi:syntax=mads
