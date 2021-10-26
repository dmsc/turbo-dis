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

PRINTLINE .proc
            ldy #$00            ; LLINE in BASIC source
            lda (STMCUR),Y
            tax
            iny
            lda (STMCUR),Y
            jsr PUT_AX
            ldx F_LIST
            beq LF228
            ldx INDENTLVL       ; Reuse ERRNUM to store indent level
            ldy #$04
            lda (STMCUR),Y
            jsr CHKELOOP
            beq LF226
            cmp #TOK_ELSE
            bne LF228
LF226       dex
            dex
LF228       stx FR0
LF22A       jsr P_SPC
            dec FR0
            bpl LF22A
        .endp
            ; List direct line
LDLINE  .proc
            ldy #$02
            lda (STMCUR),Y
            sta LLNGTH
            iny
@           lda (STMCUR),Y
            sta NXTSTD
            iny
            sty STINDEX
            jsr LSTMT
            ldy NXTSTD
            cpy LLNGTH
            bcc @-
            rts

LSTMT       jsr L_GTOK
            cmp #TOK_INVLET     ; list an invisible "LET"
            beq L_ADV
            cmp #TOK_LREM       ; list a "--"
            beq PRINT_LREM
            jsr IPRINTSTMT
            jsr L_GTOK
            cmp #TOK_ERROR
            beq LDATAREM
            cmp #TOK_DATA+1
            bcs L_ADV
LDATAREM    jsr L_NXTOK         ; List DATA or REM or ERROR
            jsr PUTCHAR
            jmp LDATAREM

PRINT_LREM  ldy #$1E
            lda F_LIST
            bne LF274
            ldy #$02
LF274       sty FR0
LF276       lda #'-'
            jsr PUTCHAR
            dec FR0
            bne LF276
            jmp PUTEOL

L_ADV       jsr L_NXTOK
            bne LF28B
            jsr L_NXTOK
            .byte $2C   ; Skip 2 bytes
LF28B       bpl L_NOTVAR
            eor #$80
            jsr P_VARNAME
            cmp #$A8
            bne L_ADV
            jsr L_NXTOK
            jmp L_ADV

L_NOTVAR    cmp #$0F
            beq L_STRC
            bcs L_TOKS
            pha
            jsr EGT_NUM
            dec STINDEX
            pla
            cmp #$0D
            bne L_FPVAR
            lda #'$'
            jsr PUTCHAR
            jsr T_FPI
            jsr HEX_WORD
            ora #$80
            sta LBUFF-1,Y
            bne LF2C2
L_FPVAR     jsr T_FASC
LF2C2       jsr PUT_INBUF
            jmp L_ADV

P_STR1      jsr LPRTOKEN
            jmp L_ADV

; List string constant
L_STRC      jsr L_NXTOK
            sta SCANT
            lda #'"'
            jsr PUTCHAR
            lda SCANT
            beq LF2EF
LF2DC       jsr L_NXTOK
            cmp #'"'
            bne LF2E8
            jsr PUTCHAR
            lda #'"'
LF2E8       jsr PUTCHAR
            dec SCANT
            bne LF2DC
LF2EF       lda #'"'
            jsr PUTCHAR
            jmp L_ADV

L_TOKS      sec
            sbc #$10
            sta SCANT
            ldx #$00
            lda #>OPNTAB
            ldy #<OPNTAB
            jsr STR_TABN
            jsr L_GTOK
            cmp #CEXOR
            beq P_SPCSTR1
            cmp #CFDIV
            beq P_SPCSTR1
            cmp #CMOD
            beq P_SPCSTR1
            cmp #CEXEC
            beq P_SPCSTR1
            cmp #CGOG
            beq P_SPCSTR1
            cmp #CNOT
            beq P_STRSPC1
            cmp #CACOM+1
            bcs P_STR1
            ldy #$00
            lda (SCRADR),Y
            and #$7F
            jsr IS_NAMECHR
            bcs P_STR1
P_SPCSTR1   jsr P_SPC
P_STRSPC1   jsr P_STR_SPC
            jmp L_ADV

L_NXTOK     inc STINDEX
L_GTOK      ldy STINDEX
            cpy NXTSTD
            bcs LF343
            lda (STMCUR),Y
            rts

LF343       pla
            pla
            rts

; Indent and print statement
IPRINTSTMT  pha
            jsr CHK_INDENT
            pla
PRINTSTMT   sta SCANT
            ldx #$01
            lda #>SNTAB
            ldy #<SNTAB
            jsr STR_TABN
            jmp P_STR_SPC

CHK_INDENT  cmp #TOK_FOR
            beq LINDENT
            cmp #TOK_REPEAT
            beq LINDENT
            cmp #TOK_WHILE
            beq LINDENT
            cmp #TOK_DO
            beq LINDENT
            cmp #TOK_PROC
            beq LINDENT
            cmp #TOK_IF
            beq LF383
            jsr CHKELOOP
            bne LF382
LF376       dec INDENTLVL       ; Reuse ERRNUM to store indent level
            dec INDENTLVL
            bpl LF382
LINDENT     inc INDENTLVL       ; Reuse ERRNUM to store indent level
            inc INDENTLVL
            bmi LF376
LF382       rts
LF383       lda STINDEX
            pha
            jsr SKIPTOK
            pla
            sta STINDEX
            cpx #CTHEN
            bne LINDENT
            rts
        .endp
PRINTSTMT = LDLINE.PRINTSTMT
IPRINTSTMT = LDLINE.IPRINTSTMT

F_LIST      .byte $01

X_FL    .proc
            lda (STMCUR),Y
            eor #CMINUS
            sta F_LIST
            rts
        .endp
            ; Check if TOK is end of loop
CHKELOOP .proc
            cmp #TOK_NEXT
            beq ERET
            cmp #TOK_UNTIL
            beq ERET
            cmp #TOK_WEND
            beq ERET
            cmp #TOK_LOOP
            beq ERET
            cmp #TOK_ENDPROC
            beq ERET
            cmp #TOK_ENDIF
ERET        rts
        .endp

; vi:syntax=mads
