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

ERR_3H      jmp ERR_3

X_RENUM .proc

OLDNUM = MVFA
NEWNUM = MVTA

            jsr X_GS
            jsr GET3INT
            sta MVLNG
            sty MVLNG+1         ; MVFA:  original line number,
                                ; MVTA:  new line number,
                                ; MVLNG: increment
            ora MVLNG+1
            beq ERR_3H          ; Increment should be > 0
            tya
            ora OLDNUM+1
            ora NEWNUM+1
            bmi ERR_3H          ; All parameters should be < 32768
            lda OLDNUM
            sta TSLNUM
            lda OLDNUM+1
            sta TSLNUM+1
            jsr SEARCHLINE      ; Search starting line
            lda STMCUR
            sta FR1+2           ; Store in FR1+2
            lda STMCUR+1
            sta FR1+3
            lda #$80            ; Store 32768 into FR0 to search...
            sta FR0+1
            asl
            sta FR0
            jsr REN_NEWLN       ; ...new line number of last line to renumber
            bmi ERR_3H          ; > 32767, error
            lda STMTAB+1        ; Now, go through the whole program
            sta STMCUR+1
            lda STMTAB
P1_NLINE    sta STMCUR          ; First pass, change all line references
            ldy #$01
            lda (STMCUR),Y
            bmi PASS_2          ; Reached last line
            iny
            lda (STMCUR),Y
            sta LLNGTH
            iny
P1_NSTMT    lda (STMCUR),Y
            sta NXTSTD
            iny
            sty STINDEX
            lda (STMCUR),Y      ; Search statements that needs change
            cmp #TOK_GOTO
            beq @+
            cmp #TOK_GO_TO
            beq @+
            cmp #TOK_GOSUB
            beq @+
            cmp #TOK_TRAP
@           beq REN_CHG1
            cmp #TOK_ON
            beq REN_CHGON
            cmp #TOK_RESTORE
            beq REN_CHGOPT
            cmp #TOK_IF
            beq REN_CHGIF
            cmp #TOK_LIST
            beq REN_CHGLST
            cmp #TOK_DEL
            beq REN_CHGLST
REN_NXTST   ldy NXTSTD
            cpy LLNGTH
            bcc P1_NSTMT        ; Next statement in line
            clc
            lda STMCUR
            adc LLNGTH
            bcc P1_NLINE
            inc STMCUR+1
            bcs P1_NLINE

PASS_2      lda FR1+3           ; Complete, now a second pass to change actual line numbers
            sta STMCUR+1
            lda FR1+2
P2_NLINE    sta STMCUR
            ldy #$01
            lda (STMCUR),Y
            bmi REN_END
            lda NEWNUM+1
            sta (STMCUR),Y
            dey
            lda NEWNUM
            sta (STMCUR),Y
            clc
            adc MVLNG
            sta NEWNUM
            lda NEWNUM+1
            adc MVLNG+1
            sta NEWNUM+1
            ldy #$02
            lda (STMCUR),Y
            adc STMCUR
            bcc P2_NLINE
            inc STMCUR+1
            bcs P2_NLINE

REN_END     jsr GEN_LNHASH
            jmp POP_RETURN

REN_CHGIF   jsr SKIPTOK
            cpx #CTHEN
            bne REN_NXTST
            dec STINDEX
REN_CHGOPT  ldy STINDEX
            iny
            cpy NXTSTD
            bcs REN_NXTST
REN_CHG1    jsr REN_CHGNXT
            jmp REN_NXTST

REN_CHGON   jsr SKIPTOK
            cpx #CGTO
            beq REN_CHGOTO
            cpx #CGS
            bne REN_NXTST
            .byte $2C   ; Skip 2 bytes
REN_CHGLST  inc STINDEX
REN_CHGOTO  lda STINDEX
            cmp NXTSTD
            bcs REN_NXTST
            pha
            jsr REN_CHGNUM
            pla
            sta STINDEX
            jsr SKPCTOK
            jmp REN_CHGOTO

REN_CHGNXT  inc STINDEX
REN_CHGNUM  ldy STINDEX
            sty L00DC
            lda (STMCUR),Y
            beq REN_CXIT
            cmp #$0F
            bcs REN_CXIT
            jsr GETTOK
            jsr T_FPI
            lda FR0+1
            bmi REN_CXIT
            bcs REN_CXIT
            jsr REN_NEWLN
            php
            bcs @+
            sta FR0             ; Ok, get new number
            sty FR0+1
@           jsr T_IFP
            asl FR0
            plp
            ror FR0
            ldy STINDEX
            ldx #$05
@           lda FR0,X
            dey
            sta (STMCUR),Y
            dex
            bpl @-
REN_CXIT    rts

REN_NEWLN   ; Calculate new line number of old line number at FR0
            lda FR0
            cmp OLDNUM
            lda FR0+1
            sbc OLDNUM+1
            bcs @+
            lda FR0
            ldy FR0+1
            rts
@           lda FR1+2
            sta L00DA
            lda FR1+3
            sta L00DB
            lda NEWNUM          ; Store new line number in FR1
            sta FR1
            lda NEWNUM+1
CL_LOOP     sta FR1+1
            ldy #$01
            lda (L00DA),Y       ; Read current line number
            bmi CL_NRET         ; Not a program line
            cmp FR0+1
            bne @+
            dey
            lda (L00DA),Y
            cmp FR0
@           bcs CL_YRET         ; Line > line to search, found
            ldy #$02            ; Go to next line
            lda (L00DA),Y
            adc L00DA
            sta L00DA
            bcc @+
            inc L00DB
@           dey
            lda (L00DA),Y
            bmi CL_NRET         ; Not a program line
            clc                 ; Increment new line number
            lda FR1
            adc MVLNG
            sta FR1
            lda FR1+1
            adc MVLNG+1
            jmp CL_LOOP         ; Loop

CL_YRET     clc
            beq CL_RET
CL_NRET     sec
CL_RET      lda FR1             ; Return new line number
            ldy FR1+1
            rts
        .endp

            ; Skip tokens until terminator
SKIPTOK     inc STINDEX
SKPCTOK     jsr GETTOK  ; Skip from current token
            bcc SKPCTOK
            tax
            lda OPRTAB-16,X
            bne SKPCTOK
            rts

; vi:syntax=mads
