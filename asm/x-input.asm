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

INP_COMMA .proc
            ldy CIX
            lda (INBUFF),Y
            cmp #','
            clc
            beq LCB05
            cmp #CR
LCB05       rts
        .endp

ERR_06      lda #$06
            jmp SERROR

X_INPUT .proc
            lda #'?'
            sta PROMPT
            lda (STMCUR),Y
            cmp #$0F
            bne LCB27
            jsr EGT_STRC
            jsr PRINT_STR
            ldy STINDEX
            inc STINDEX
            lda (STMCUR),Y
            cmp #CCOM
            bne LCB27
            ror ENTDTD  ; Store 128 into ENTDTD to omit prompt
LCB27       jsr GETTOK
            dec STINDEX
            bcc LCB33
            jsr GETINTNXT
            sta ENTDTD
LCB33       jsr T_LDBUFA
            jsr GLINE
            jsr XITB
            ldy #$00
            sty DIRFLG  ; Set input mode
            sty CIX
XINA        jsr GETTOK
            inc STINDEX
            lda VTYPE
            bmi XISTR
            jsr T_AFP
            bcs XIERR
            jsr INP_COMMA
            bne XIERR
            jsr RTNVAR
            jmp XINDEX

XITB        lda BRKKEY
            beq LCB60
            rts
LCB60       dec BRKKEY
            jmp CHK_BRK

XIERR       lda #$00
            sta ENTDTD
            lda #$08
            jmp SERROR

XISTR       ldy #$00
            lda #$11
            sta OPSTK
            sty OPSTKX
            sty COMCNT
            sty ARSLVL
            sty L00B1
            jsr X_PUSHVAL
            dec CIX
            lda CIX
            sta ZTEMP1
            ldx #$FF
XIS1        inx
            inc CIX
            ldy CIX
            lda (INBUFF),Y
            cmp #CR
            beq XIS2
            cmp #','
            bne XIS1
            bit DIRFLG
            bvc XIS1
XIS2        ldy ZTEMP1
            lda STINDEX
            pha
            txa
            ldx #INBUFF
            jsr RISC
            pla
            sta STINDEX
            jsr RISASN
XINDEX      bit DIRFLG
            bvc XIN
            inc DATAD
            ldx STINDEX
            inx
            cpx NXTSTD
            bcs LCBC8
            jsr INP_COMMA
            bcc LCBD8
            jmp X_READ.XRD3
XIN         ldx STINDEX
            inx
            cpx NXTSTD
            bcc LCBD0
LCBC8       jsr T_LDBUFA
            lda #$00
            sta ENTDTD  ; Restore ENTDTD
            rts
LCBD0       jsr INP_COMMA
            bcc LCBD8
            jmp LCB33
LCBD8       inc CIX
            jmp XINA

PRINT_STR   ldx #$00
            lda FR0
            sta IOCB0+ICBAL,X
            lda FR0+1
            sta IOCB0+ICBAH,X
            lda FR0+2
            sta IOCB0+ICBLL,X
            lda FR0+3
            sta IOCB0+ICBLH,X
            lda #$0B
            jmp CIOV_COME

        .endp

; vi:syntax=mads
