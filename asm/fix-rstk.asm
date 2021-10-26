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

; Change return stack from addresses to line numbers, so that
; lines can be added/deleted
UNFIX_RSTK .proc
            txa
            pha
            lda TOPRSTK
            pha
            lda TOPRSTK+1
            pha
            lda L00B2
            pha
            lda TSLNUM
            pha
            lda TSLNUM+1
            pha
LC0DC       jsr X_POP
            bcs REST_VARS
            ldy L00A0+1
            bne LC0ED
            lda #<FIX_RSTK.LFFFF ; Replace missing lines with "FFFF"
            sta L00A0
            lda #>FIX_RSTK.LFFFF
            sta L00A0+1
LC0ED       tay
.if .not .def tb_fixes
            ; BUG: this should be a "BEQ", as FOR loops store "0" in the runtime stack
            bmi LC0FE
.else
            beq LC0FE
.endif
            ldy #$00
            lda (L00A0),Y
            iny
            sta (TOPRSTK),Y
            lda (L00A0),Y
            iny
            sta (TOPRSTK),Y
            bcc LC0DC
LC0FE       ldy #$00
            lda (L00A0),Y
            ; This should be $0E and $0F
.if .def tb_fixes
            ldy #$0E
.else
            ldy #$13
.endif
            sta (TOPRSTK),Y
            ldy #$01
            lda (L00A0),Y
.if .def tb_fixes
            ldy #$0F
.else
            ldy #$14
.endif
            sta (TOPRSTK),Y
            bcc LC0DC
REST_VARS   pla
            sta TSLNUM+1
            pla
            sta TSLNUM
            pla
            sta L00B2
            pla
            sta TOPRSTK+1
            sta APPMHI+1
            pla
            sta TOPRSTK
            sta APPMHI
            pla
            tax
            rts
        .endp

; Fix runtime stack return addresses after lines are added/deleted
FIX_RSTK .proc
            pha
            lda TOPRSTK
            pha
            lda TOPRSTK+1
            pha
            lda L00B2
            pha
            lda TSLNUM
            pha
            lda TSLNUM+1
            pha
            lda STMCUR
            pha
            lda STMCUR+1
            pha
            lda SAVCUR
            pha
            lda SAVCUR+1
            pha
            jsr CLR_LABELS
            jsr GEN_LNHASH
LC148       jsr X_POP
            bcs LC171
            pha
            ldy TSLNUM+1
            iny
            beq LC158
            jsr SEARCHLINE
            bcc LC15E
LC158       lda #$00
            sta STMCUR
            sta STMCUR+1
LC15E       ldy #$01
            pla
.if .not .def tb_fixes
            ; BUG: this should be a "BNE", as FOR loops store "0" in the runtime stack
            bpl LC165
            ; And this should be $0E
            ldy #$13
.else
            bne LC165
            ldy #$0E
.endif
LC165       lda STMCUR
            sta (TOPRSTK),Y
            iny
            lda STMCUR+1
            sta (TOPRSTK),Y
            jmp LC148
LC171       pla
            sta SAVCUR+1
            pla
            sta SAVCUR
            pla
            sta STMCUR+1
            pla
            sta STMCUR
            jmp UNFIX_RSTK.REST_VARS

LFFFF       .byte $FF,$FF

CLR_LABELS  lda VVTP
            sta L00A0
            lda VVTP+1
            sta L00A0+1
LC18A       lda L00A0
            cmp ENDVVT
            lda L00A0+1
            sbc ENDVVT+1
            bcs LC1AD
            ldy #$00
            lda (L00A0),Y
            and #$C0
            cmp #$C0
            bne LC1A0
            sta (L00A0),Y
LC1A0       clc
            lda L00A0
            adc #$08
            sta L00A0
            bcc LC18A
            inc L00A0+1
            bcs LC18A
LC1AD       rts
        .endp

; vi:syntax=mads
