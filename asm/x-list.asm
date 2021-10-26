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

X_LIST  .proc
            jsr X_GS
            ldy #$00
            sty TSLNUM
            sty TSLNUM+1
            sty INDENTLVL       ; Reuse ERRNUM to store indent level
            dey
            sty L00AD
            lda #$7F
            sta L00AE
            sta DSPFLG
            jsr PUTEOL
LF135       ldy STINDEX
            iny
            cpy NXTSTD
            bcs LF16A
            lda STINDEX
            pha
            jsr EXEXPR
            pla
            sta STINDEX
            lda VTYPE
            bpl LF14F
            jsr FLIST
            jmp LF135

LF14F       jsr GETPINT
            sty TSLNUM+1
            sta TSLNUM
            ldx STINDEX
            cpx NXTSTD
            beq LF166
            ldy #$80
            inx
            cpx NXTSTD
            beq LF166
            jsr GETPINT
LF166       sta L00AD
            sty L00AE
LF16A       jsr SEARCHLINE
LF16D       ldy #$01
            lda (STMCUR),Y
            bmi LF1A7
            cmp L00AE
            bcc LF182
            bne LF1A7
            dey
            lda (STMCUR),Y
            cmp L00AD
            bcc LF182
            bne LF1A7
LF182       lda CONSOL
            cmp #$07
            beq LF18F
            lda RTCLOK+2
            and #$0F
            bne LF182
LF18F       jsr PRINTLINE
            lda BRKKEY
            beq LF1A5
            ldy #$02
            lda (STMCUR),Y
            clc
            adc STMCUR
            sta STMCUR
            bcc LF16D
            inc STMCUR+1
            bcs LF16D
LF1A5       dec BRKKEY
LF1A7       lda L00B5
            beq LF1B2
            jsr CLSYSD
            lda #$00
            sta L00B5
LF1B2       sta DSPFLG
        .endp

; vi:syntax=mads
