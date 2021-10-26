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

X_READ  .proc
            lda DATALN
            sta TSLNUM
            lda DATALN+1
            sta TSLNUM+1
            jsr SEARCHLINE
            lda STMCUR
            sta INBUFF
            lda STMCUR+1
            sta INBUFF+1
            lda SAVCUR
            sta STMCUR
            lda SAVCUR+1
            sta STMCUR+1
LCA90       ldy #$00
            lda (INBUFF),Y
            sta DATALN
            iny
            lda (INBUFF),Y
            sta DATALN+1
            iny
            lda (INBUFF),Y
            sta ZTEMP1
            sty CIX
            ldy CIX
LCAA4       iny
            lda (INBUFF),Y
            sta ZTEMP1+1
            iny
            sty CIX
            lda (INBUFF),Y
            cmp #$01
            beq LCAD5
            ldy ZTEMP1+1
            cpy ZTEMP1
            bcs LCABB
            dey
            bcc LCAA4
LCABB       dey
            sty CIX
XRD3        ldy #$01
            lda (INBUFF),Y
            bmi ERR_06
            sec
            lda CIX
            adc INBUFF
            sta INBUFF
            lda #$00
            sta DATAD
            adc INBUFF+1
            sta INBUFF+1
            bcc LCA90
LCAD5       lda #$00
            sta ZTEMP1
LCAD9       lda ZTEMP1
            cmp DATAD
            bcs LCAF1
LCADF       inc CIX
            ldy CIX
            lda (INBUFF),Y
            cmp #CR
            beq XRD3
            cmp #','
            bne LCADF
            inc ZTEMP1
            bne LCAD9
LCAF1       lda #$40
            sta DIRFLG
            inc CIX
            jmp X_INPUT.XINA

        .endp

; vi:syntax=mads
