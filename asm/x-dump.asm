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

X_DUMP  .proc
            iny
            cpy NXTSTD
            bcs LC048
            jsr FLIST
LC048       lda #$00
            sta ERRNUM  ; Reuse ERRNUM to store var counter
LC04C       jsr PUTEOL
            lda BRKKEY
            beq DUMP_BRK
            lda ERRNUM
            jsr GETVAR
            lda WVVTPT
            cmp ENDVVT
            lda WVVTPT+1
            sbc ENDVVT+1
            bcs DUMP_END
            lda ERRNUM
            jsr DUMP_VAR
            inc ERRNUM
            bne LC04C
            ; Fall-through to dump last variable
DUMP_VAR    jsr P_VARNAME
            jsr P_SPC
            lda VTYPE
            cmp #EVLABEL
            bcs DUMP_LBL
            cmp #EVSTR
            bcs DUMP_ARR
            cmp #EVARRAY
            bcs DUMP_ARR
            lda #'='
            jsr PUTCHAR
            jmp PUT_FP

DUMP_BRK    dec BRKKEY
DUMP_END    lda L00B5
            beq LC094
            jsr CLSYSD
            lda #$00
            sta L00B5
LC094       rts

DUMP_LBL    ldy #TOK_PROC
            lsr
            bcs LC0A4
            ldy #TOK_PND
            lsr
            bcs LC0A4
            lda #'?'
            jmp PUTCHAR
LC0A4       tya
            jsr PRINTSTMT
            ldy #$00
            lda (FR0),Y
            tax
            iny
            lda (FR0),Y
            jmp PUT_AX

DUMP_ARR    lda FR0+5
            pha
            lda FR0+4
            pha
            lda FR0+3
            ldx FR0+2
            jsr PUT_AX
            lda #','
            jsr PUTCHAR
            pla
            tax
            pla
            jmp PUT_AX
        .endp

; vi:syntax=mads
