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

; Entering and parsing BASIC lines

            icl "asm/x-new.asm"

; Start parsing code
SYN_START   jsr UNFIX_RSTK
; Parse one line
SYN_LINE    lda LOADFLG
            bne X_NEW
            ldx #$FF
            txs
            cld
            jsr T_LDBUFA
            lda #EPCHAR
            sta PROMPT
            jsr GLGO
            lda BRKKEY
            bne @+
            dec BRKKEY
            bne SYN_LINE
@           ldy #$00
            sty CIX
            sty LLNGTH
            sty COX
            sty DIRFLG
            sty SVONTX
            sty COMCNT
            sty ADFLAG
            lda VNTD
            sta L00AD
            lda VNTD+1
            sta L00AE
            jsr UCASEBUF
            jsr GET_LNUM
            jsr SETCODE
            lda FR0+1
            bpl @+
            sta DIRFLG          ; No line number
@           jsr UCASEBUF
            sty STINDEX
            lda (INBUFF),Y
            cmp #CR
            bne SYN_STMT
            bit DIRFLG
            bmi SYN_LINE        ; Nothing to parse, continue
            jmp SDEL            ; Just a line number, delete line
; Parse one statement
SYN_STMT    lda COX
            sta NXTSTD
            jsr SETCODE
            jsr UCASEBUF
            ldy #>SNTAB
            lda #<SNTAB
            jsr STSEARCH
            ror L00EC           ; Store flag if we found a token
            bmi @+
            lda STENUM
            cmp #TOK_END
            bne STFOUND         ; Don't accept "END", as it could be "ENDIF", etc.
            stx L00DA
@           ldy #>SNTAB2
            lda #<SNTAB2
            jsr STSEARCH
            lda #TOK_INVLET
            bcs @+
            adc STENUM
            adc #$02
            bcc STFOUND
@           bit L00EC           ; Check if we found token (must be "END") before
            bmi STFOUND
            lda #<SNT_END
            sta SCRADR
            lda #>SNT_END
            sta SCRADR+1
            lda #TOK_END
            ldx L00DA
STFOUND     stx CIX
            jsr SETCODE
            jsr T_SKPSPC
            jsr SYNENT
            bcc SYNOK
            ldy LLNGTH
            lda (INBUFF),Y
            cmp #CR
            bne @+
            iny
            sta (INBUFF),Y
            dey
            lda #$20
@           ora #$80
            sta (INBUFF),Y
            lda #$40
            ora DIRFLG
            sta DIRFLG
            ldy STINDEX
            sty CIX
            ldx #$03
            stx NXTSTD
            inx
            stx COX
            lda #TOK_ERROR
SYN3        jsr SETCODE
        ; Copy DATA or REM statements text
LXDATA      ldy CIX
            lda (INBUFF),Y
            inc CIX
            cmp #CR
            bne SYN3
            jsr SETCODE
SYNOK       lda COX
            ldy NXTSTD
            sta OUTBUFF,Y       ; Store statement length
            ldy CIX
            dey
            lda (INBUFF),Y      ; Are we at EOL
            cmp #CR
            beq @+
            jmp SYN_STMT        ; No, parse next statement

@           ldy #$02
            lda COX
            sta OUTBUFF,Y       ; Store line length
            jsr SRCHLN_NC       ; Search line number
            lda #$00
            bcs @+
            ldy #$02
            lda (STMCUR),Y      ; Old line length
@           sec
            sbc COX             ; A = old - new length
            beq SYNIN           ; No space needed, go to copy
            bcs SYNCON          ; less space, contract
            eor #$FF            ; more space, expand
            tay
            iny
            ldx #STMCUR
            jsr EXPLOW
            lda INDEX2
            sta STMCUR
            lda INDEX2+1
            sta STMCUR+1
            bne SYNIN

SYNCON      tay
            clc
            adc STMCUR
            sta STMCUR
            bcc @+
            inc STMCUR+1
@           ldx #STMCUR
            jsr CONTLOW
SYNIN       ldy COX             ; Store new statement
SYN7        dey
            lda OUTBUFF,Y
            sta (STMCUR),Y
            tya
            bne SYN7
            bit DIRFLG          ; Check syntax error
            bvc SYN8
            lda ADFLAG          ; Yes, remove created variables
            asl
            asl
            asl
            tay
            ldx #ENDVVT
            jsr CONTLOW
            sec
            lda VNTD
            sbc L00AD
            tay
            lda VNTD+1
            sbc L00AE
            ldx #VNTD
            jsr CONTRACT
            bit DIRFLG
            bpl P_SYNERROR
            jsr LDLINE
            jmp SYN_LINE

P_SYNERROR  jsr PRINTLINE
SYN_LINE_   jmp SYN_LINE

SYN8        bpl SYN_LINE_       ; If not direct line, continue entering program
            jsr FIX_RSTK        ; Fix runtime-stack and execute new line
            jmp EXECNL

        ; Delete program line
SDEL        jsr SRCHLN_NC
            bcs SYN_LINE_
            ldy #$02
            lda (STMCUR),Y
            tay
            clc
            adc STMCUR
            sta STMCUR
            bcc @+
            inc STMCUR+1
@           ldx #STMCUR
            jsr CONTLOW
            jmp SYN_LINE

; vi:syntax=mads
