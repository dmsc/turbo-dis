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

FIX_TABW    inc PTABW
X_PRINT .proc
            lda PTABW
            beq FIX_TABW
            sta SCANT
            lda #$00
            sta COX
.if .def tb_fixes
            sta MVLNG   ; Store last token
.endif
XPRINT0     ldy STINDEX
            lda (STMCUR),Y
.if .not .def tb_fixes
            cmp #CCOM
            beq XPRINT_TAB
.endif
            cmp #CCR
            beq XPRINT_EOL
            cmp #CEOS
            beq XPRINT_EOL
.if .def tb_fixes
            ; Not end-of-line, store token to check later if
            ; we need to print a newline
            sta MVLNG
            cmp #CCOM
            beq XPRINT_TAB
.endif
            cmp #CSC
            beq XPRINT_NUL
            cmp #CPND
            beq XPRINT_IO
            jsr EXEXPR
            dec STINDEX
            ldx ARSLVL
            lda VARSTK0,X
            bmi LDD23
            jsr X_STRP
LDD23       jsr X_POPSTR
            ldx L00B5
            jsr GLPX
            lda FR0
            sta IOCB0+ICBAL,X
            lda FR0+1
            sta IOCB0+ICBAH,X
            lda FR0+2
            sta IOCB0+ICBLL,X
            clc
            adc COX
            sta COX
            lda FR0+3
            sta IOCB0+ICBLH,X
            ora FR0+2
            beq XPRINT0
            lda #$0B
            jsr CIOV_COME
            jmp XPRINT0

XPRINT_TAB  ldy COX
            iny
            cpy SCANT
            bcc LDD60
            clc
            lda PTABW
            adc SCANT
            sta SCANT
            bcc XPRINT_TAB
LDD60       ldy COX
            cpy SCANT
            bcs XPRINT_NUL
            jsr P_SPC
            inc COX
            jmp LDD60

XPRINT_IO   jsr GETINTNXT
            sta L00B5
            dec STINDEX
            jmp XPRINT0

.if .not .def tb_fixes
.def :GETINTNXT
            inc STINDEX
            jmp GETINT
.endif

XPRINT_NUL  inc STINDEX
            jmp XPRINT0

XPRINT_EOL
.if .not .def tb_fixes
            ldy STINDEX
            dey
            ; BUG: if last token was a number or string ending on $15 or $12,
            ;      no enter is printed.
            lda (STMCUR),Y
.else
            lda MVLNG   ; Get last token
.endif
            cmp #CSC
            beq LDD92
            cmp #CCOM
            beq LDD92
            jsr PUTEOL
LDD92       lda #$00
            sta L00B5
            rts

        .endp

            ; Moved here to fix branch range in fixed version
.if .def tb_fixes
GETINTNXT   inc STINDEX
            jmp GETINT
.endif


; vi:syntax=mads
