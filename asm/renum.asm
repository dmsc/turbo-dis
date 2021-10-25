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

X_RENUM     jsr X_GS
            jsr GET3INT
            sta MVLNG
            sty MVLNG+1         ; $99/$9A: starting line,
                                ; $9B/$9C: new number,
                                ; $A2/$A3: increment
            ora MVLNG+1
            beq ERR_3H          ; Increment should be > 0
            tya
            ora L009A
            ora L009C
            bmi ERR_3H          ; All parameters should be < 32768
            lda L0099
            sta TSLNUM
            lda L009A
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
L341E       sta STMCUR          ; First pass, change all line references
            ldy #$01
            lda (STMCUR),Y
            bmi L346A           ; Reached last line
            iny
            lda (STMCUR),Y
            sta LLNGTH
            iny
L342C       lda (STMCUR),Y
            sta NXTSTD
            iny
            sty STINDEX
            lda (STMCUR),Y      ; Search statements that needs change
            cmp #TOK_GOTO
            beq L3443
            cmp #TOK_GO_TO
            beq L3443
            cmp #TOK_GOSUB
            beq L3443
            cmp #TOK_TRAP
L3443       beq REN_CHG1
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
            bcc L342C           ; Next statement in line
            clc
            lda STMCUR
            adc LLNGTH
            bcc L341E
            inc STMCUR+1
            bcs L341E

L346A       lda FR1+3           ; Complete, now a second pass to change actual line numbers
            sta STMCUR+1
            lda FR1+2
L3470       sta STMCUR
            ldy #$01
            lda (STMCUR),Y
            bmi REN_END
            lda L009C
            sta (STMCUR),Y
            dey
            lda L009B
            sta (STMCUR),Y
            clc
            adc MVLNG
            sta L009B
            lda L009C
            adc MVLNG+1
            sta L009C
            ldy #$02
            lda (STMCUR),Y
            adc STMCUR
            bcc L3470
            inc STMCUR+1
            bcs L3470

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
            beq L34C2
            cpx #CGS
            bne REN_NXTST
            .byte $2C   ; Skip 2 bytes
REN_CHGLST  inc STINDEX
L34C2       lda STINDEX
            cmp NXTSTD
            bcs REN_NXTST
            pha
            jsr REN_CHGNUM
            pla
            sta STINDEX
            jsr SKPCTOK
            jmp L34C2

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
            bcs L34F9
            sta FR0             ; Ok, get new number
            sty FR0+1
L34F9       jsr T_IFP
            asl FR0
            plp
            ror FR0
            ldy STINDEX
            ldx #$05
L3505       lda FR0,X
            dey
            sta (STMCUR),Y
            dex
            bpl L3505
REN_CXIT    rts

REN_NEWLN   ; Calculate new line number of old line number at FR0
            lda FR0
            cmp L0099
            lda FR0+1
            sbc L009A
            bcs L351D
            lda FR0
            ldy FR0+1
            rts
L351D       lda FR1+2
            sta L00DA
            lda FR1+3
            sta L00DB
            lda L009B           ; Store new line number in FR1
            sta FR1
            lda L009C
L352B       sta FR1+1
            ldy #$01
            lda (L00DA),Y       ; Read current line number
            bmi L3560           ; Not a program line
            cmp FR0+1
            bne L353C
            dey
            lda (L00DA),Y
            cmp FR0
L353C       bcs L355D           ; Line > line to search, found
            ldy #$02            ; Go to next line
            lda (L00DA),Y
            adc L00DA
            sta L00DA
            bcc L354A
            inc L00DB
L354A       dey
            lda (L00DA),Y
            bmi L3560           ; Not a program line
            clc                 ; Increment new line number
            lda FR1
            adc MVLNG
            sta FR1
            lda FR1+1
            adc MVLNG+1
            jmp L352B           ; Loop

L355D       clc
            beq L3561
L3560       sec
L3561       lda FR1             ; Return new line number
            ldy FR1+1
            rts

            ; Skip tokens until terminator
SKIPTOK     inc STINDEX
SKPCTOK     jsr GETTOK  ; Skip from current token
            bcc SKPCTOK
            tax
            lda OPRTAB-16,X
            bne SKPCTOK
            rts

; vi:syntax=mads
