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

; Macro to report size of each segment and number of bytes available
    .macro  @SEGMENT_SIZE
        .echo   "-> Segment ", :1, "-", *-1 ,", ", * - :1, " bytes, remaining: ", :2 - *
    .endm

; The TurboBasic XL low ram address - adjust to load in bigger DOS
.if .def tb_lowmem
TBXL_LOW_ADDRESS = tb_lowmem * $100
.else
TBXL_LOW_ADDRESS = $2080
.endif
; The loader for RAM under ROM parts and initialization address
TBXL_ROMLOADER = $6000

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Include the equates
        icl "asm/equates.asm"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Include the LOADER
        icl "asm/turbo-loader.asm"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Start of TurboBasic XL Code in low RAM
;
        org TBXL_LOW_ADDRESS

        .if .not .def tb_lowmem

            icl "asm/reset-v.asm"
            icl "asm/opstack.asm"

; Align the variable stack
;            org $2100
        @SEGMENT_SIZE TBXL_LOW_ADDRESS TB_SEGMENT_2
            org (* + $FF) & $FF00

TB_SEGMENT_2
            icl "asm/argstack.asm"
;            org $2200
            icl "asm/stmttab.asm"

            icl "asm/fptmp.asm"
            icl "asm/dirspecs.asm"

        @SEGMENT_SIZE TB_SEGMENT_2 TB_SEGMENT_3

; Note: Skip this 13 bytes so that DISROM has an address with <(DISROM-1) == >(DISROM-1)
;       This is used as return to USR call
            .if (>*) < (<*)
                .ds ((>*)-((* & $00FF) - 1)) + 257
            .else
                .ds ((>*)-((* & $00FF) - 1))
            .endif

TB_SEGMENT_3
            icl "asm/disrom.asm"

        .else

        ; In the LOW-MEM version, we simply include all
        ; code in one segment, minimizing the skips.
TB_SEGMENT_3
            icl "asm/argstack.asm"
            icl "asm/stmttab.asm"
            icl "asm/dirspecs.asm"
            icl "asm/pdum.asm"
            icl "asm/disrom.asm"
            icl "asm/reset-v.asm"
            icl "asm/irq-nmi.asm"

        .endif


        @SEGMENT_SIZE TB_SEGMENT_3 TB_SEGMENT_4
; Note: this table needs to be in address with low-part = $1D * 2 = $3A ($XX3A),
;       because the first executable token is '<=' at $1D
            org ((* - $3A + $FF) & $FF00) + $3A
TB_SEGMENT_4
            icl "asm/opetab.asm"
            icl "asm/ciov.asm"
            icl "asm/nmi-end.asm"

        .if .not .def tb_lowmem
            icl "asm/irq-nmi.asm"
            icl "asm/pdum.asm"
        .endif

            icl "asm/getkey.asm"

            ; Include statements in low-memory:
            icl "asm/x-dos.asm"
            icl "asm/x-bye.asm"
            icl "asm/x-dpeek.asm"
            icl "asm/x-dpoke.asm"
            icl "asm/x-poke.asm"
            icl "asm/x-usr.asm"

            ; Memory moves
            icl "asm/expand.asm"
            icl "asm/contract.asm"

            ; Turbo Math Pack
            icl "asm/mathpack.asm"

            icl "asm/renum.asm"
            icl "asm/bloadrun.asm"


        .if .def tb_lowmem
            icl "asm/fptmp.asm"
            icl "asm/opstack.asm"
        .endif

        @SEGMENT_SIZE TB_SEGMENT_4 TOP_LOWMEM
; This is the end of low memory use
TOP_LOWMEM

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Loader for the RAM under ROM parts and initialization:
        icl "asm/loader.asm"

; Relocation support:
.if .def tb_lowmem
        icl "asm/relocate.asm"
.endif

LOAD_BUFFER = *

            ini INIT


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Start of code under ROM, at OS addresses
;
            org $C000
TB_SEGMENT_5

X_DEL       jsr X_GS
            jsr UNFIX_RSTK
            jsr GETUINT
            sta TSLNUM
            sty TSLNUM+1
            jsr GETUINT
            jsr SRCHLN_NC
LC013       ldy #$01
            lda (STMCUR),Y
            cmp FR0+1
            bne LC020
            dey
            lda (STMCUR),Y
            cmp FR0
LC020       bcc LC024
            bne LC03A
LC024       ldy #$02
            clc
            lda (STMCUR),Y
            tay
            adc STMCUR
            sta STMCUR
            bcc LC032
            inc STMCUR+1
LC032       ldx #STMCUR
            jsr CONTLOW
            jmp LC013
LC03A       jsr FIX_RSTK
            jmp POP_RETURN

X_DUMP      iny
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

; Change return stack from addresses to line numbers, so that
; lines can be added/deleted
UNFIX_RSTK  txa
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
            lda #<LC180 ; Replace missing lines with "FFFF"
            sta L00A0
            lda #>LC180
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

; Fix runtime stack return addresses after lines are added/deleted
FIX_RSTK    pha
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
            jmp REST_VARS

LC180       .byte $FF,$FF

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

X_SETCOLOR  jsr GET3INT
            and #$0F
            asl L009B
            asl L009B
            asl L009B
            asl L009B
            ora L009B
            ldx L009A
            bne ERR_3A
            ldx L0099
            cpx #$05
            bcs ERR_3A
            sta COLOR0,X
            rts

ENDSOUND    ldx #$07
            lda #$00
LC1CF       sta AUDF1,X
            dex
            bpl LC1CF
            rts

ERR_3A      jmp ERR_3

        ; Use MVLNG as temporary
X_DSOUND    sta MVLNG
            iny
            cpy NXTSTD
            bcs ENDSOUND
            jsr GETBYTE
            ldy #$00
            bit MVLNG
            bpl LC1EC
            asl
            ldy #$78
LC1EC       cmp #$04
            bcs ERR_3A
            asl
            pha
            sty AUDCTL
            lda #$03
            sta SKCTL
            jsr GET3INT
            pla
            tax
            lda L0099
            sta AUDF1,X
            bit MVLNG
            bpl LC20F
            inx
            inx
            lda L009A
            sta AUDF1,X
LC20F       lda L009B
            asl
            asl
            asl
            asl
            ora FR0
            sta AUDC1,X
            rts

X_POSITION  jsr GETINT
            sta COLCRS
            sty COLCRS+1
            jsr GETBYTE
            sta ROWCRS
            rts

X_COLOR     jsr GETINT
            sta COLOR
            rts

X_FCOLOR    jsr GETINT
            sta FILDAT
            rts

X_FILLTO    lda #$12
            .byte $2C   ; Skip 2 bytes
X_DRAWTO    lda #$11
            pha
            jsr X_POSITION
            lda COLOR
            sta ATACHR
            ldx #$60
            lda #$0C
            sta IOCB0+ICAX1,X
            lda #$00
            sta IOCB0+ICAX2,X
            pla
            jmp CIOV_COME

X_GRAPHICS  ldx #$06
            stx IODVC   ; Use IO Channel #6
            jsr CLSYSD  ; Close device
            jsr GETINT
            ldx #<DEV_S_
            ldy #>DEV_S_
            stx INBUFF
            sty INBUFF+1
            ldx #$06
            and #$F0
            eor #$1C    ; Get AUX1 from BASIC mode
            tay
            lda FR0     ; And AUX2
            jsr CIO_OPEN
            jmp IOTEST

X_PLOT      jsr X_POSITION
            ldy COLOR
            ldx #$60
            jmp PRCX

GLINE       ldx ENTDTD
            bne GLGO
            lda PROMPT
            jsr PUTCHAR
GLGO        ldx ENTDTD
            lda #ICGETREC
            jsr GLPCX
            jsr CIOV_LEN_FF
            jmp IOTEST

PUTEOL      lda #CR
PUTCHAR     ldx L00B5
PUTCHR1     tay
            jsr GLPX
PRCX        lda IOCB0+ICAX1,X
            sta ICAX1Z
            lda IOCB0+ICAX2,X
            sta ICAX2Z
            jsr PDUM_ROM
CIOERR_Y    tya
            jmp CIOERR_A

GLPCX       sta IOCMD
GLPX        stx IODVC
            jmp LDDVX

X_ENTER     lda #$04
            jsr ELADVC
            sta ENTDTD
            jmp SYN_LINE

; Open "LIST" device
FLIST       lda #$08
            jsr ELADVC
            sta L00B5
            rts

; Open "alternate" device (IO channel #7)
ELADVC      ldy #$07
OPEN_Y_CHN  sty IODVC
            pha
            jsr LDDVX
            jsr IO_CLOSE
            ldy #ICOPEN
            sty IOCMD
            pla
            ldy #$00
            jsr DO_CIO_STR
            lda #$07
            rts

RUN_LOAD    lda #$FF
            .byte $2C   ; Skip 2 bytes
X_LOAD      lda #$00
            pha
            lda #$04    ; INPUT mode
            jsr ELADVC
            pla
DO_LOAD     pha
            lda #ICGETCHR
            sta IOCMD
            sta LOADFLG
            jsr LDDVX
            ldy #$0E
            jsr CIOV_LEN_Y
            jsr IOTEST
            lda LBUFF
            ora LBUFF+1
            bne LDFER
            ldx #STARP
LD1         clc
            lda LOMEM
            adc LBUFF-$80,X
            tay
            lda LOMEM+1
            adc LBUFF-$80+1,X
            cmp MEMTOP+1
            bcc LC321
            bne LC31E
            cpy MEMTOP
            bcc LC321
LC31E       jmp ERR_19
LC321       sta $01,X
            sty $00,X
            dex
            dex
            cpx #VNTP
            bcs LD1
            jsr LSBLK   ; LOAD user area
            jsr X_CLR
            lda #$00
            sta LOADFLG
            pla
            beq J_SNX1  ; LD4 in BASIC sources
            rts
J_SNX1      jmp SNX1

LDFER       lda #$00
            sta LOADFLG
            jmp ERR_21

X_SAVE      lda #$08
            jsr ELADVC
DO_SAVE     lda #ICPUTCHR
            sta IOCMD
            ldx #$80
LC34E       sec
            lda $00,X
            sbc OUTBUFF
            sta LBUFF-$80,X
            inx
            lda $00,X
            sbc OUTBUFF+1
            sta LBUFF-$80,X
            inx
            cpx #ENDSTAR
            bcc LC34E
            jsr LDDVX
            ldy #ENDSTAR-OUTBUFF
            jsr CIOV_LEN_Y
            jsr IOTEST
            ; LOAD / SAVE user area as block
LSBLK       jsr LDDVX
            lda VNTP
            sta INBUFF
            lda VNTP+1
            sta INBUFF+1
            ldy LBUFF+$0D
            dey
            tya
            ldy LBUFF+$0C
            jsr CIOV_LEN_AY
            jsr IOTEST
            jmp CLSYSD

X_CSAVE     lda #$08    ; OUTPUT mode
            jsr DEV_C_OPEN
            jmp DO_SAVE

X_CLOAD     lda #$04
            jsr DEV_C_OPEN
            lda #$00
            jmp DO_LOAD

DEV_C_OPEN  pha
            ldx #<DEV_C_
            stx INBUFF
            ldx #>DEV_C_
            stx INBUFF+1
            ldx #$07
            pla
            tay
            lda #$80
            jsr CIO_OPEN
            jsr IOTEST
            lda #$07
            rts

; This is SOPEN in Atari Basic
CIO_OPEN    pha
            lda #ICOPEN
            jsr GLPCX
            pla
            sta IOCB0+ICAX2,X
            tya
            sta IOCB0+ICAX1,X
            jsr CIOV_NOLEN
            jmp T_LDBUFA        ; Restore INBUFF and return

X_XIO       jsr GETINT
            .byte $2C   ; Skip 2 bytes

X_OPEN      lda #ICOPEN
            sta IOCMD
            jsr GETIOCHAN
            jsr GETINT
            pha
            jsr GETINT
            tay
            pla
DO_CIO_STR  pha
            tya
            pha
            ldy STINDEX
            iny
            cpy NXTSTD
            bcs CIO_DIRSPEC
            jsr EXEXPR
LC3E9       jsr SETSEOL
            jsr LDDVX
            pla
            sta IOCB0+ICAX2,X
            pla
            sta IOCB0+ICAX1,X
            jsr CIOV_LEN_FF
            jsr RSTSEOL
            jmp IOTEST

CIO_DIRSPEC lda #<IO_DIRSPEC
            ldx #>IO_DIRSPEC
            ldy #$05
            jsr PUSHSTR
            jmp LC3E9

X_STATUS    jsr GETIOCHAN
            lda #ICSTATIS
            jsr CIOV_COM
            tya
            jmp ISVAR1

X_NOTE      lda #ICNOTE
            jsr GDVCIO
            lda IOCB0+ICAX3,X
            ldy IOCB0+ICAX4,X
            jsr ISVAR
            jsr LDDVX
            lda IOCB0+ICAX5,X
            jmp ISVAR1

X_POINT     jsr GETIOCHAN
            jsr GETINT
            jsr LDDVX
            lda FR0
            sta IOCB0+ICAX3,X
            lda FR0+1
            sta IOCB0+ICAX4,X
            jsr GETINT
            jsr LDDVX
            lda FR0
            sta IOCB0+ICAX5,X
            lda #ICPOINT
            sta IOCMD
            jmp GDIO1

X_PUT       jsr CHKIOCHAN
LC457       jsr GETINT
            ldx IODVC
            jsr PUTCHR1
            ldy STINDEX
            iny
            cpy NXTSTD
            bcc LC457
            rts

X_GET       lda (STMCUR),Y
            cmp #CPND
            beq GET_IOC
GETK_LOOP   jsr GETKEYE
            jsr ISVAR1
            ldy STINDEX
            iny
            cpy NXTSTD
            bcc GETK_LOOP
            rts

GET_IOC     jsr GETIOCHAN
GET_LOOP    jsr LDDVX
GET1        jsr CIO_GETCHR
            tax
            tya
            jsr CIOERR_A
            txa
            jsr ISVAR1
            ldy STINDEX
            iny
            cpy NXTSTD
            bcc GET_LOOP
RTS94       rts

X_LOCATE    jsr X_POSITION
            ldx #$60
            bne GET1

CHKIOCHAN   lda (STMCUR),Y
            cmp #CPND
            beq GETIOCHAN
            lda #$00
            beq IOCHAN0

GETIOCHAN   jsr GETINTNXT
IOCHAN0     sta IODVC

LDDVX       lda IODVC
            asl
            asl
            asl
            asl
            tax
            bpl RTS94
            lda #$14
            jmp SERROR

; Check CIO return for errors
IOTEST      jsr LDDVX
            lda IOCB0+ICSTA,X
CIOERR_A    bpl RTS94
            ldy #$00
            sty DSPFLG
            cmp #$80
            bne SIO1
            sty BRKKEY
            ldx LOADFLG
            beq RTS94
            jmp COLDSTART

SIO1        ldy IODVC
            cmp #$88
            beq SIO4
SIO2        sta ERRNUM
            cpy #$07
            bne SIO3
            jsr CLSYSD
SIO3        jsr SETDZ
            jmp ERROR

SIO4        cpy #$07
            bne SIO2
            ldx #EPCHAR
            cpx PROMPT
            bne SIO2
            jsr CLSYSD
            jmp SNX2

; Close System Device
CLSYSD      jsr LDDVX
            beq RTS94   ; Don't close device 0
IO_CLOSE    lda #ICCLOSE
            jmp CIOV_COM

; Multiple ways to call CIOV
CIOV_LEN_FF ldy #$FF
CIOV_LEN_Y  lda #$00
CIOV_LEN_AY sta IOCB0+ICBLH,X
            tya
            sta IOCB0+ICBLL,X
CIOV_NOLEN  lda INBUFF+1
            ldy INBUFF
            sta IOCB0+ICBAH,X
            tya
            sta IOCB0+ICBAL,X
CIOV_IOCMD  lda IOCMD
CIOV_COM    sta IOCB0+ICCOM,X
            jmp B_CIOV

; I/O Variable Set
ISVAR1      ldy #$00
ISVAR       pha
            tya
            pha
            jsr EXEXPR
            pla
            sta FR0+1
            pla
            sta FR0
            jsr T_IFP
            jmp RTNVAR

; Close all IO channels
CLSALL      lda #$00
            ldx #$07
LC538       sta AUDF1,X
            dex
            bpl LC538
            ldy #$07
            sty IODVC
LC542       jsr CLSYSD
            dec IODVC
            bne LC542
            rts

X_CLOSE     iny
            cpy NXTSTD
            bcs CLSALL
            lda #ICCLOSE
; General device I/O call
GDVCIO      sta IOCMD
            jsr GETIOCHAN
GDIO1       jsr CIOV_IOCMD
            jmp IOTEST

; Print READY prompt
PREADY      ldx #$06
LC55E       stx CIX
            lda READYMSG,X
            jsr PUTCHAR
            ldx CIX
            dex
            bpl LC55E
            rts

READYMSG    .byte CR, 'YDAER', CR

SETSEOL     jsr X_POPSTR
            lda FR0
            sta INBUFF
            lda FR0+1
            sta INBUFF+1
            ldy FR0+2
            ldx FR0+3
            beq SETSEOL1
            ldy #$FF
SETSEOL1    lda (INBUFF),Y
            sta L0097
            sty L0098
            lda #CR
            sta (INBUFF),Y
            sta MEOLFLG
            rts

RSTSEOL     ldy L0098
            lda L0097
            sta (INBUFF),Y
            lda #$00
            sta MEOLFLG
            jmp T_LDBUFA

X_DIR       lda #$06
            jsr ELADVC
LC5A5       ldx #$70
            jsr CIO_GETCHR
            bmi LC5B3
            ldx #$00
            jsr PUTCHR1
            bpl LC5A5
LC5B3       tya
            pha
            ldx #$70
            jsr IO_CLOSE
            pla
            cmp #$88
            beq LC5C2
            jmp SERROR
LC5C2       rts

X_RENAME    lda #ICRENAME
            .byte $2C   ; Skip 2 bytes

X_LOCK      lda #ICLOCKFL
            .byte $2C   ; Skip 2 bytes

X_UNLOCK    lda #ICUNLOCK
            .byte $2C   ; Skip 2 bytes

X_DELETE    lda #ICDELETE
            sta IOCMD
            lda #$07
            sta IODVC
            lda #$00
            tay
            jmp DO_CIO_STR

X_BPUT      lda #ICPUTCHR
            .byte $2C   ; Skip 2 bytes
X_BGET      lda #ICGETCHR
            pha
            jsr GETIOCHAN
            jsr GET2INT
            jsr LDDVX
            lda L009B
            sta IOCB0+ICBAL,X
            lda L009C
            sta IOCB0+ICBAH,X
            lda FR0
            sta IOCB0+ICBLL,X
            lda FR0+1
            sta IOCB0+ICBLH,X
            pla
CIOV_COME   jsr CIOV_COM
            jmp CIOERR_Y

CIO_GETCHR  lda #ICGETCHR
            sta IOCMD
            ldy #$00
            jmp CIOV_LEN_Y

; Reads a key from "K:" and calls error if needed.
GETKEYE     jsr GETKEY
            cpy #$80
            bcs LC615
            rts
LC615       jmp CIOERR_Y

X_PPUT      lda #ICPUTCHR
            .byte $2C   ; Skip 2 bytes

X_PGET      lda #ICGETCHR
            sta IOCMD
            jsr CHKIOCHAN
LC622       jsr GETFP
            jsr LDDVX
            lda #$D4
            sta INBUFF
            lda #$00
            sta INBUFF+1
            ldy #$06
            jsr CIOV_LEN_Y
            jsr T_LDBUFA
            jsr IOTEST
            lda IOCMD
            cmp #ICGETCHR
            bne LC644
            jsr RTNVAR
LC644       ldy STINDEX
            iny
            cpy NXTSTD
            bcc LC622
            rts

X_FPASIGN   ldy OPSTKX
            bne LC682
            dec ARSLVL
            ldx ARSLVL
            dec ARSLVL
            lda VARSTK1,X
            jsr VAR_PTR
            ldy #$02
            lda ARGSTK0+1,X
            sta (WVVTPT),Y
            iny
            lda ARGSTK1+1,X
            sta (WVVTPT),Y
            iny
            lda ARGSTK2+1,X
            sta (WVVTPT),Y
            iny
            lda ARGSTK3+1,X
            sta (WVVTPT),Y
            iny
            lda ARGSTK4+1,X
            sta (WVVTPT),Y
            iny
            lda ARGSTK5+1,X
            sta (WVVTPT),Y
            rts
LC682       lda #$80
            sta L00B1
            rts

X_ARRCOMMA  inc COMCNT
X_RPAREN    ldy OPSTKX
            pla
            pla
            jmp EXOPOP

X_DIMLPAREN lda #$40
            sta L00B1
X_ARRLPAREN bit L00B1
            bpl ALP1
            lda ARSLVL
            sta L00AF
            dec ARSLVL
ALP1        lda COMCNT
            tay
            beq ALP2
            dec COMCNT
            jsr X_POPINT
            bmi ERR_9_
ALP2        sty L0098
            sta L0097
            jsr X_POPINT
            bmi ERR_9_
            sta ZTEMP1
            sty ZTEMP1+1
            jsr X_POPVAL
            bit L00B1
            bvc ALP3
            lda #$00
            sta L00B1
            rts

ERR_9_      jmp ERR_9

ALP3        lsr VTYPE
            bcc ERR_9_
            lda ZTEMP1
            cmp FR0+2
            lda ZTEMP1+1
            sbc FR0+3
            bcs ERR_9_
            lda L0097
            cmp FR0+4
            lda L0098
            sbc FR0+5
            bcs ERR_9_
            lda FR0+5
            bne AMUL1
            ldy FR0+5
            dey
            bne AMUL1
            lda ZTEMP1
            sta ZTEMP4
            lda ZTEMP1+1
            sta ZTEMP4+1
            jmp AMUL6
AMUL1       ldy #$00            ; Multiply index by DIM2
            sty ZTEMP4
            sty ZTEMP4+1
            ldy #$10
AMUL1L      lsr FR0+5
            ror FR0+4
            bcc AMUL1A
            clc
            lda ZTEMP4
            adc ZTEMP1
            sta ZTEMP4
            lda ZTEMP4+1
            adc ZTEMP1+1
            sta ZTEMP4+1
AMUL1A      asl ZTEMP1
            rol ZTEMP1+1
            dey
            bne AMUL1L
AMUL6       clc                 ; Multiply index by 6
            lda L0097
            adc ZTEMP4
            sta ZTEMP1
            lda L0098
            adc ZTEMP4+1
            asl ZTEMP1
            rol
            sta ZTEMP1+1
            tay
            lda ZTEMP1
            asl
            rol ZTEMP1+1
            adc ZTEMP1
            tax
            tya
            adc ZTEMP1+1
            tay
            txa
            adc FR0
            tax
            tya
            adc FR0+1
            tay
            txa
            adc STARP
            sta ZTEMP1
            tya
            adc STARP+1
            sta ZTEMP1+1
            bit L00B1
            bpl ALP8
            ldx L00AF
            stx ARSLVL
            dec ARSLVL
            ldy #$00
            sty L00B1
            lda ARGSTK0,X
            sta (ZTEMP1),Y
            iny
            lda ARGSTK1,X
            sta (ZTEMP1),Y
            iny
            lda ARGSTK2,X
            sta (ZTEMP1),Y
            iny
            lda ARGSTK3,X
            sta (ZTEMP1),Y
            iny
            lda ARGSTK4,X
            sta (ZTEMP1),Y
            iny
            lda ARGSTK5,X
            sta (ZTEMP1),Y
            rts
ALP8        inc ARSLVL
            ldx ARSLVL
            ldy #$05
            lda (ZTEMP1),Y
            sta ARGSTK5,X
            dey
            lda (ZTEMP1),Y
            sta ARGSTK4,X
            dey
            lda (ZTEMP1),Y
            sta ARGSTK3,X
            dey
            lda (ZTEMP1),Y
            sta ARGSTK2,X
            dey
            lda (ZTEMP1),Y
            sta ARGSTK1,X
            dey
            lda (ZTEMP1),Y
            sta ARGSTK0,X
            lsr VARSTK0,X
            rts

X_STRLPAREN lda COMCNT
            beq XSLP2
            jsr POPINT_NZ
            sty L0098
            sta L0097
XSLP2       jsr POPINT_NZ
            sec
            sbc #1
            sta ZTEMP1
            tya
            sbc #0
            sta ZTEMP1+1
            jsr X_POPVAL
            lda L00B1
            bpl XSLP3
            ora COMCNT
            sta L00B1
            ldy FR0+5
            lda FR0+4
            jmp XSLP4
XSLP3       lda FR0+2
            ldy FR0+3
XSLP4       ldx COMCNT
            beq XSLP6
            dec COMCNT
            cpy L0098
            bcc XSLER
            bne XSLP5
            cmp L0097
            bcc XSLER
XSLP5       ldy L0098
            lda L0097
XSLP6       sec
            sbc ZTEMP1
            sta FR0+2
            tax
            tya
            sbc ZTEMP1+1
            sta FR0+3
            bcc XSLER
            tay
            bne XSLP7
            txa
            beq XSLER
XSLP7       jsr PTRSTR
            clc
            lda FR0
            adc ZTEMP1
            sta FR0
            lda FR0+1
            adc ZTEMP1+1
            sta FR0+1
            bit L00B1
            bpl XSLP8
RTS_0B      rts

XSLP8       jmp X_PUSHVAL

POPINT_NZ   jsr X_POPINT
            bne RTS_0B
            tax
            bne RTS_0B
XSLER       lda #$05
            jmp SERROR

X_STRASIGN  jsr X_POPSTR
RISASN      lda FR0
            sta L0099
            lda FR0+1
            sta L009A
            lda FR0+2
            sta MVLNG
            ldy FR0+3
            sty MVLNG+1
            ldy OPSTKX
            beq XSA1
            lda #$80
            sta L00B1
            jsr EXOPOP
            lda FR0+3
            ldy FR0+2
            rol L00B1
            bcs XSA2A
XSA1        jsr X_POPSTR
            lda FR0+5
            ldy FR0+4
XSA2A       cmp MVLNG+1
            bcc XSA3
            bne XSA4
            cpy MVLNG
            bcs XSA4
XSA3        sta MVLNG+1
            sty MVLNG
XSA4        clc
            lda FR0
            sta L009B
            adc MVLNG
            tay
            lda FR0+1
            sta L009C
            adc MVLNG+1
            tax
            sec
            tya
            sbc STARP
            sta ZTEMP3
            txa
            sbc STARP+1
            sta ZTEMP3+1
            jsr DO_MOVEUP
            lda VNUM
            jsr GETVAR
            sec
            lda ZTEMP3
            sbc FR0
            tay
            lda ZTEMP3+1
            sbc FR0+1
            tax
            lda #$02
            and L00B1
            beq XSA5
            lda #$00
            sta L00B1
            cpx FR0+3
            bcc XSA6
            bne XSA5
            cpy FR0+2
            bcs XSA5
XSA6        rts

XSA5        sty FR0+2
            stx FR0+3
            jmp RTNVAR

X_DIM       ldy STINDEX
            cpy NXTSTD
            bcc LC8A7
            rts
LC8A7       jsr EXEXPR
            lsr VTYPE
            bcs DCERR
            sec
            rol VTYPE
            bmi LC918
            lda ZTEMP1
            adc #$01
            sta ZTEMP1
            sta FR0+2
            lda ZTEMP1+1
            adc #$00
            bmi DCERR
            sta FR0+3
            sta ZTEMP1+1
            lda L0097
            adc #$01
            sta FR0+4
            lda L0098
            adc #$00
            sta FR0+5
            bmi DCERR
            ldy #$00
            sty ZTEMP4
            sty ZTEMP4+1
            ldy #$10
LC8DB       lda ZTEMP1
            lsr
            bcc LC8EF
            clc
            lda ZTEMP4
            adc FR0+4
            sta ZTEMP4
            lda ZTEMP4+1
            adc FR0+5
            sta ZTEMP4+1
            bmi DCERR
LC8EF       ror ZTEMP4+1
            ror ZTEMP4
            ror ZTEMP1+1
            ror ZTEMP1
            dey
            bne LC8DB
            asl ZTEMP1
            rol ZTEMP1+1
            bmi DCERR
            ldx ZTEMP1+1
            lda ZTEMP1
            asl
            rol ZTEMP1+1
            bmi DCERR
            adc ZTEMP1
            sta ZTEMP1
            tay
            txa
            adc ZTEMP1+1
            sta ZTEMP1+1
            bpl LC92C
DCERR       jmp ERR_9
LC918       lda #$00
            sta FR0+2
            sta FR0+3
            ldy ZTEMP1
            sty FR0+4
            lda ZTEMP1+1
            sta FR0+5
            bne LC92C
            cpy #$00
            beq DCERR
LC92C       ldx #ENDSTAR
            jsr EXPAND
            sec
            lda L0097
            sbc STARP
            sta FR0
            lda L0098
            sbc STARP+1
            sta FR0+1
            jsr RTNVAR
            lda #$00
            tay
            ldx ZTEMP1+1
            beq LC952
LC948       sta (L0097),Y
            iny
            bne LC948
            inc L0098
            dex
            bne LC948
LC952       ldx ZTEMP1
            beq LC95C
LC956       sta (L0097),Y
            iny
            dex
            bne LC956
LC95C       jmp X_DIM

; Search line number and fill STMCUR, rebuilding hash first
SRCHLN_NC   jsr GEN_LNHASH
; Search line number and fill STMCUR, using line hash
SEARCHLINE  lda STMCUR
            sta SAVCUR
            lda STMCUR+1
            sta SAVCUR+1
            lda TSLNUM+1
            tax
            asl
            tay
            lda (LOMEM),Y
            sta STMCUR+1
            iny
            lda (LOMEM),Y
LC976       sta STMCUR
            ldy #$01
            txa
            cmp (STMCUR),Y
            bne LC992
            dey
            lda (STMCUR),Y
            cmp TSLNUM
            bcs LC999
LC986       ldy #$02
            lda (STMCUR),Y
            adc STMCUR
            bcc LC976
            inc STMCUR+1
            bcs LC976
LC992       bcc LC997
            clc
            bcc LC986
LC997       sec
            rts
LC999       bne LC997
            clc
            rts

; Store into variable table the line address of the PROC or #LABEL.
SETV_PROC   lda #EVLABEL + EVL_EXEC
            .byte $2C   ; Skip 2 bytes
SETV_LBL    lda #EVLABEL + EVL_GOS
            tax
            iny
            lda (L0099),Y
            bne LC9AB
            iny
            lda (L0099),Y
LC9AB       eor #$80
            jsr VAR_PTR
            txa
            cmp (WVVTPT),Y
            beq HSH_CONT
            sta (WVVTPT),Y
            lda L0099
            ldy #$02
            sta (WVVTPT),Y
            iny
            lda L009A
            sta (WVVTPT),Y
            jmp HSH_CONT

; Buils line number hash table and fills PROC/#LABEL addresses.
GEN_LNHASH  lda L0099
            pha
            lda L009A
            pha
            ; Start filling with zeroes
            lda #$00
            tay
HSH_CLR     sta (LOMEM),Y
            iny
            iny
            bne HSH_CLR
            ; Iterate through all program lines
            lda STMTAB+1
            sta L009A
            lda STMTAB
HSH_NXT     sta L0099
            ldy #$04
            lda (L0099),Y
            cmp #TOK_PROC
            beq SETV_PROC
            cmp #TOK_PND
            beq SETV_LBL
HSH_CONT    ldy #$01
            lda (L0099),Y
            asl
            bcs HSH_EPROC
            tay
            lda (LOMEM),Y
            bne HSH_DONE  ; Skip already hashed
            ; Store address of line into hash
            lda L009A
            sta (LOMEM),Y
            iny
            lda L0099
            sta (LOMEM),Y
HSH_DONE    clc
            ldy #$02
            lda (L0099),Y
            adc L0099
            bcc HSH_NXT
            inc L009A
            bcs HSH_NXT
            ; Now, we fill remaining hashes with available lines
HSH_EPROC   lda STMTAB
            sta L0099
            lda STMTAB+1
            sta L009A
            ldy #$00
HSH_FILL    lda (LOMEM),Y
            bne LCA24
            lda L009A
            sta (LOMEM),Y
            iny
            lda L0099
            sta (LOMEM),Y
            jmp LCA2B
LCA24       sta L009A
            iny
            lda (LOMEM),Y
            sta L0099
LCA2B       iny
            bne HSH_FILL
            pla
            sta L009A
            pla
            sta L0099
            rts

ERR_30      lda #$1E
            jmp SERROR

; Gets a LABEL or line number
GT_LBLNUM   lda (STMCUR),Y
            iny
            cpy NXTSTD
            bcs LNZERO
            cmp #CPND
            bne GETINT_
            inc STINDEX
            jsr GETTOK
            lda VTYPE
            cmp #EVLABEL + EVL_GOS
            bne ERR_30
            ldy #$00
            lda (FR0),Y
            tax
            iny
            lda (FR0),Y
            tay
            txa
            rts

LNZERO      lda #$00
            tay
            rts

GETINT_     jmp GETINT

X_RESTORE   jsr GT_LBLNUM
            cpy #$00
            bmi ERR_3D
            sta DATALN
            sty DATALN+1
            lda #$00
            sta DATAD
            rts

ERR_3D      jmp ERR_3

X_READ      lda DATALN
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
            jmp XINA

INP_COMMA   ldy CIX
            lda (INBUFF),Y
            cmp #','
            clc
            beq LCB05
            cmp #CR
LCB05       rts

ERR_06      lda #$06
            jmp SERROR

X_INPUT     lda #'?'
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
            jmp XRD3
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

        @SEGMENT_SIZE TB_SEGMENT_5 $CC00
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Second part, after international character set
;
            org $D800
TB_SEGMENT_6

X_MOVE      jsr GET3INT
            sta MVLNG
            sty MVLNG+1
            jmp DO_MOVEUP

X_NMOVE     jsr GET3INT
            sta MVLNG
            sty MVLNG+1
            jmp DO_MOVEDWN

X_FADD      jsr X_POPVAL2
            jsr T_FADD
            jmp X_PUSH_ERR11

X_FSUB      jsr X_POPVAL2
            jsr T_FSUB
            jmp X_PUSH_ERR11

X_FMUL      jsr X_POPVAL2
            jsr T_FMUL
            jmp X_PUSH_ERR11

X_FDIV      jsr X_POPVAL2
            jsr T_FDIV
            jmp X_PUSH_ERR11

X_FNEG      ldx ARSLVL
            lda ARGSTK0,X
            beq FNEG_ISZ
            eor #$80
            sta ARGSTK0,X
FNEG_ISZ    rts

X_LTE       jsr X_CMP
            bcc X_N1
            beq X_N1
            bcs X_N0

X_NEQU      jsr X_CMP
            beq X_N0
            bne X_N1

X_LT        jsr X_CMP
            bcc X_N1
            bcs X_N0

X_GT        jsr X_CMP
            bcc X_N0
            beq X_N0
            bcs X_N1

X_GTE       jsr X_CMP
            bcc X_N0
            bcs X_N1

X_EQU       jsr X_CMP
            beq X_N1
            bne X_N0

X_AND       dec ARSLVL
            ldx ARSLVL
            dec ARSLVL
            lda ARGSTK0,X
            and ARGSTK0+1,X
            asl
            beq X_N0
            bne X_N1

X_OR        dec ARSLVL
            ldx ARSLVL
            dec ARSLVL
            lda ARGSTK0,X
            ora ARGSTK0+1,X
            asl
            beq X_N0
            bne X_N1

X_NOT       ldx ARSLVL
            dec ARSLVL
            lda ARGSTK0,X
            beq X_N1

X_N0        lda #$00
            tay
            beq X_TF
X_N3        ldy #$03
            .byte $2C   ; Skip 2 bytes
X_N2        ldy #$02
            lda #$40
            bne X_TF
X_N1        lda #$40
X_TI        ldy #$01
X_TF        inc ARSLVL
            ldx ARSLVL
            sta ARGSTK0,X
            tya
            sta ARGSTK1,X
            lda #$00
            sta VARSTK0,X
            sta ARGSTK2,X
            sta ARGSTK3,X
            sta ARGSTK4,X
            sta ARGSTK5,X
            rts

X_SGN       ldx ARSLVL
            dec ARSLVL
            lda ARGSTK0,X
            asl
            beq X_N0
            lda #$80
            ror
            bne X_TI

X_CMP       ldy OPSTKX
            lda OPSTK+1,Y
            cmp #$2F
            bcc FRCMPP
            jmp STRCMP

FRCMPP      ldy ARSLVL
            dec ARSLVL
            ldx ARSLVL
            dec ARSLVL
            lda ARGSTK0,X
            cmp ARGSTK0,Y
            bne FRCMPEXP
            asl
            bcc FRCMPPOS
            inx
            dey
FRCMPPOS    lda ARGSTK1,X
            cmp ARGSTK1,Y
            bne FRCMPEND
            lda ARGSTK2,X
            cmp ARGSTK2,Y
            bne FRCMPEND
            lda ARGSTK3,X
            cmp ARGSTK3,Y
            bne FRCMPEND
            lda ARGSTK4,X
            cmp ARGSTK4,Y
            bne FRCMPEND
            lda ARGSTK5,X
            cmp ARGSTK5,Y
FRCMPEND    rts
FRCMPEXP    ora ARGSTK0,Y
            bpl FRCMPEND
            ror
            eor #$80
            rol
            rts

STRCMP      jsr X_POPSTR
            jsr T_FMOVE
            jsr X_POPSTR
            ldy #$00
STRCMP1     lda FR0+2
            bne STRCMP2
            lda FR0+3
            beq STRCMP3
            dec FR0+3
STRCMP2     dec FR0+2
            tax
STRCMP3     php
            lda FR1+2
            bne STRCMP4
            lda FR1+3
            beq STRCMP9
            dec FR1+3
STRCMP4     dec FR1+2
            plp
            beq STRCMP7
            lda (FR0),Y
            cmp (FR1),Y
            bne STRCMP6
            inc FR0
            bne STRCMP5
            inc FR0+1
STRCMP5     inc FR1
            bne STRCMP1
            inc FR1+1
            bne STRCMP1
STRCMP6     bcs STRCMP8
STRCMP7     iny
            clc
STRCMP8     rts
STRCMP9     plp
            sec
            rts

X_LEN       jsr X_POPSTR
            lda FR0+2
            ldy FR0+3
X_RET_AY    sta FR0
            sty FR0+1
X_RET_INT   jsr T_IFP
X_RET_FP    lda #$00
            sta VTYPE
            sta VNUM
            jmp X_PUSHVAL

X_PEEK      jsr X_POPINT
            ldy #$00
            lda (FR0),Y
            jmp X_RET_AY

X_FRE       dec ARSLVL
            sec
            lda MEMTOP
            sbc TOPRSTK
            tax
            lda MEMTOP+1
            sbc TOPRSTK+1
            tay
            txa
            jmp X_RET_AY

X_VAL       jsr SETSEOL
            lda #$00
            sta CIX
            jsr T_AFP
            jsr RSTSEOL
            bcc X_RET_FP
            jmp ERR_18

X_ASC       jsr X_POPSTR
            ldy #$00
            lda (FR0),Y
            jmp X_RET_AY

X_DEC       jsr SETSEOL
            ldy #$00
            sty CIX
            sty FR0
            sty FR0+1
LD9CD       jsr GET_HEXDIG
            bcc LD9CD
            jsr RSTSEOL
            jmp X_RET_INT

X_ADR       jsr X_POPSTR
            jmp X_RET_INT

X_PADDLE    lda #$00
            beq X_GRF

X_STICK     lda #$08
            bne X_GRF

X_PTRIG     lda #$0C
            bne X_GRF

X_STRIG     lda #$14
X_GRF       sta L00EC
            jsr X_POPINT
            bne ERR_3B
            cmp #$08
            bcs ERR_3B
            adc L00EC
            tax
            lda PADDL0,X
X_RET_A     ldy #$00
            jmp X_RET_AY

ERR_3B      jmp ERR_3

HEX_WORD    jsr T_LDBUFA
            ldy #$00
            lda FR0+1
            beq LDA11
            jsr HEX_BYTE
LDA11       lda FR0
HEX_BYTE    pha
            lsr
            lsr
            lsr
            lsr
            jsr HEX_DIGIT
            pla
            and #$0F
HEX_DIGIT   ora #'0'
            cmp #'9'+1
            bcc LDA26
            adc #'A'-'9'-2      ; -1 because carry is SET
LDA26       sta (INBUFF),Y
            iny
            rts

X_HEXP      jsr X_POPINT
            jsr HEX_WORD
            lda #<LBUFF
            bne RET_STR_A

X_STRP      jsr X_POPVAL
            jsr T_FASC
            ldy #$FF
LDA3C       iny
            lda (INBUFF),Y
            bpl LDA3C
            and #$7F
            sta (INBUFF),Y
            iny
            lda INBUFF
            bne RET_STR_A

X_INKEYP    lda CH
            ldy #$00
            cmp #$C0
            bcs RET_STR_LY
            ldx #MUTED_KEYS_N-1
LDA55       cmp MUTED_KEYS,X
            beq RET_STR_LY
            dex
            bpl LDA55
            jsr GETKEYE
            jmp RET_CHRP

X_CHRP      jsr X_POPINT
            lda FR0
RET_CHRP    sta LBUFF+$40
            ldy #$01
RET_STR_LY  lda #<(LBUFF+$40)
RET_STR_A   ldx #>(LBUFF+$40)
PUSHSTR     stx FR0+1
            sta FR0
            sty FR0+2
            lda #$00
            sta FR0+3
            sta VNUM
            lda #EVSTR + EVSDTA + EVDIM
            sta VTYPE
            jmp X_PUSHVAL

X_RNDFN     dec ARSLVL
X_RND       lda #$3F
            sta FR0
            ldx #$05
LDA8C       lda RANDOM
            and #$F0
            cmp #$A0
            bcs LDA8C
            sta FR1
LDA97       lda RANDOM
            and #$0F
            cmp #$0A
            bcs LDA97
            ora FR1
            sta FR0,X
            dex
            bne LDA8C
            jsr NORMALIZE
            jmp X_RET_FP

X_RAND      jsr X_RND
            jsr X_FMUL
            jmp X_INT

X_ABS       ldx ARSLVL
            lda ARGSTK0,X
            and #$7F
            sta ARGSTK0,X
            rts

X_FRAC      jsr X_POPVAL
            lda FR0
            and #$7F
            sec
            sbc #$40
            bcc LDAE1
            tax
            lda #$00
            cpx #$05
            bcc LDAD6
            ldx #$04
LDAD6       sta FR0+1,X
            dex
            bpl LDAD6
            jsr NORMALIZE
            jmp X_PUSHVAL
LDAE1       inc ARSLVL
            rts

X_DIV       jsr X_FDIV
X_TRUNC     jsr X_POPVAL
            lda FR0
            and #$7F
            sec
            sbc #$40
            bcc LDB3C
            tax
            lda #$00
LDAF6       cpx #$04
            bcs RETVAL
            sta FR0+2,X
            inx
            bcc LDAF6

X_INT       jsr X_POPVAL
            lda FR0
            and #$7F
            sec
            sbc #$40
            bcc LDB3A
            tax
            cpx #$04
            bcs LDAE1
            lda #$00
            tay
LDB13       ora FR0+2,X
            sty FR0+2,X
            inx
            cpx #$04
            bne LDB13
            bit FR0
            bpl RETVAL
            tay
            beq RETVAL
LDB23       lda #$C0
            sta FR1
            ldy #$01
            sty FR1+1
            dey
            sty FR1+2
            sty FR1+3
            sty FR1+4
            sty FR1+5
            jsr T_FADD
RETVAL      jmp X_PUSHVAL
LDB3A       asl FR0
LDB3C       jsr T_ZFR0
            bcc RETVAL
            bcs LDB23

X_SIN       jsr X_POPVAL
            jsr T_FSIN
            jmp X_PUSH_ERR3

X_COS       jsr X_POPVAL
            jsr T_FCOS
            jmp X_PUSH_ERR3

X_ATN       jsr X_POPVAL
            jsr T_FATN
            jmp X_PUSH_ERR3

X_LOG       jsr X_POPVAL
            jsr T_FLOG
            jmp X_PUSH_ERR3

X_CLOG      jsr X_POPVAL
            jsr T_FCLOG
            jmp X_PUSH_ERR3

X_EXP       jsr X_POPVAL
            jsr T_FEXP
            jmp X_PUSH_ERR3

X_SQR       jsr X_POPVAL
            jsr T_FSQRT
            jmp X_PUSH_ERR3

JMP_N0      jmp X_N0
JMP_N1      jmp X_N1

POW_0       lda FR1
            bpl JMP_N0
ERR_3E      jmp ERR_3

X_POW       jsr X_POPVAL2
            lda FR1
            beq JMP_N1
            lda FR0
            beq POW_0
            bpl LDBC2
            and #$7F
            sta FR0
            lda FR1
            and #$7F
            sec
            sbc #$40
            bcc ERR_3E
            ldx #$04
            cmp #$04
            beq LDBBD
            bcs LDBC2
            tax
            tay
LDBB3       lda FR1+2,Y
            bne ERR_3E
            iny
            cpy #$04
            bne LDBB3
LDBBD       lda FR1+1,X
            lsr
            bcs LDBC3
LDBC2       clc
LDBC3       lda #$00
            ror
            pha
            lda FR1
            cmp #$40
            bne POW_FP
            lda FR1+2
            ora FR1+3
            ora FR1+4
            ora FR1+5
            bne POW_FP
            lda FR1+1
            and #$F0
            lsr
            sta FLPTR
            lsr
            lsr
            adc FLPTR
            sta FLPTR
            lda FR1+1
            and #$0F
            adc FLPTR
            sta FLPTR
            jsr FMOVPLYARG
            lsr FLPTR
            bcs LDBF6
            jsr T_FLD1
LDBF6       jsr FMOVSCR
            lda FLPTR
            beq LDC4D
            jsr LDPLYARG
LDC00       jsr T_FSQ
            bcs ERR_11_
            lsr FLPTR
            bcc LDC00
            jsr FMOVPLYARG
            jsr LD1FPSCR
            jsr T_FMUL
            bcc LDBF6
ERR_11_     jmp ERR_11

ERR_3F      jmp ERR_3

POW_FP      lda FR1+5
            pha
            lda FR1+4
            pha
            lda FR1+3
            pha
            lda FR1+2
            pha
            lda FR1+1
            pha
            lda FR1
            pha
            jsr T_FCLOG
            bcs ERR_3F
            pla
            sta FR1
            pla
            sta FR1+1
            pla
            sta FR1+2
            pla
            sta FR1+3
            pla
            sta FR1+4
            pla
            sta FR1+5
            jsr T_FMUL
            bcs ERR_11_
            jsr T_EXP10
            bcs ERR_11_
LDC4D       pla
            bpl LDC54
            ora FR0
            sta FR0
LDC54       jmp X_PUSHVAL

X_DEG       lda #$06
            .byte $2C   ; Skip 2 bytes
X_RAD       lda #$00
            sta DEGFLAG
            rts

POP2INT     jsr X_POPINT
            sta FR1
            sty FR1+1
            jmp X_POPINT

X_BITAND    jsr POP2INT
            tya
            and FR1+1
            tay
            lda FR1
            and FR0
            jmp X_RET_AY

X_BITOR     jsr POP2INT
            tya
            ora FR1+1
            tay
            lda FR1
            ora FR0
            jmp X_RET_AY

X_EXOR      jsr POP2INT
            tya
            eor FR1+1
            tay
            lda FR1
            eor FR0
            jmp X_RET_AY

; Table with scan-codes that don't produce a key
MUTED_KEYS  .byte $9A,$98,$9D,$9B,$B3,$B5,$B0,$B2
            .byte $A6,$3C,$7C,$BC,$27,$67,$A7
MUTED_KEYS_N = * - MUTED_KEYS

X_PAUSE     jsr GETINT
LDCA5       lda RTCLOK+2
LDCA7       ldy BRKKEY
            beq LDCBC
            cmp RTCLOK+2
            beq LDCA7
            lda FR0
            bne LDCB7
            dec FR0+1
            bmi LDCBC
LDCB7       dec FR0
            jmp LDCA5
LDCBC       rts

STK_DUP2    ldx ARSLVL
            dex
            inc ARSLVL
            inc ARSLVL
            clc
LDCC5       lda VARSTK0,X
            sta VARSTK0+2,X
            lda VARSTK0+1,X
            sta VARSTK0+3,X
            txa
            adc #$20
            tax
            bcc LDCC5
            rts

X_MOD       jsr STK_DUP2
            jsr X_DIV
            jsr X_FMUL
            jmp X_FSUB

X_ERR       lda ERRSAVE
            jmp X_RET_A

X_ERL       lda STOPLN
            ldy STOPLN+1
            jmp X_RET_AY

LDCF0       inc PTABW
X_PRINT     lda PTABW
            beq LDCF0
            sta L00AF
            lda #$00
            sta L0094
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
            adc L0094
            sta L0094
            lda FR0+3
            sta IOCB0+ICBLH,X
            ora FR0+2
            beq XPRINT0
            lda #$0B
            jsr CIOV_COME
            jmp XPRINT0

XPRINT_TAB  ldy L0094
            iny
            cpy L00AF
            bcc LDD60
            clc
            lda PTABW
            adc L00AF
            sta L00AF
            bcc XPRINT_TAB
LDD60       ldy L0094
            cpy L00AF
            bcs XPRINT_NUL
            jsr P_SPC
            inc L0094
            jmp LDD60

XPRINT_IO   jsr GETINTNXT
            sta L00B5
            dec STINDEX
            jmp XPRINT0

.if .not .def tb_fixes
GETINTNXT   inc STINDEX
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

            ; Moved here to fix branch range in fixed version
.if .def tb_fixes
GETINTNXT   inc STINDEX
            jmp GETINT
.endif

X_LPRINT    lda #<DEV_P_
            sta INBUFF
            lda #>DEV_P_
            sta INBUFF+1
            dec L00DB
            ldx #$07
            stx L00B5
            lda #$00
            ldy #$08
            jsr CIO_OPEN
            jsr IOTEST
            jsr X_PRINT
            jmp CLSYSD

X_UINSTR    lda #$5F
            .byte $2C   ; Skip 2 bytes
X_INSTR     lda #$FF
            sta L00DF
            ldy COMCNT
            dey
            tya
            beq LDDC5
            jsr X_POPINT
LDDC5       sta L00DA
            sty L00DB
            jsr X_POPSTR
            jsr T_FMOVE
            jsr X_POPSTR
            clc
            lda FR0
            adc L00DA
            sta FR0
            lda FR0+1
            adc L00DB
            sta FR0+1
            bcs LDE03
            sec
            lda FR0+2
            sbc L00DA
            sta FR0+2
            lda FR0+3
            sbc L00DB
            sta FR0+3
            bcc LDE03
            ora FR0+2
            beq LDE03
            sec
            lda FR0+2
            sbc FR1+2
            sta L00DC
            lda FR0+3
            sbc FR1+3
            sta L00DD
            bcs LDE06
LDE03       jmp X_N0
LDE06       inc L00DA
            bne LDE0C
            inc L00DB
LDE0C       ldy #$00
            lda (FR1),Y
            eor (FR0),Y
            and L00DF
            bne LDE46
            lda FR0
            sta FR0+4
            lda FR0+1
            sta FR0+5
            lda FR1
            sta FR1+4
            lda FR1+1
            sta FR1+5
            lda FR1+3
            sta L00DE
            ldx FR1+2
            inx
LDE2D       dex
            bne LDE34
            dec L00DE
            bmi LDE59
LDE34       lda (FR0+4),Y
            eor (FR1+4),Y
            and L00DF
            bne LDE46
            iny
            bne LDE2D
            inc FR0+5
            inc FR1+5
            jmp LDE2D
LDE46       inc FR0
            bne LDE4C
            inc FR0+1
LDE4C       lda L00DC
            bne LDE54
            dec L00DD
            bmi LDE03
LDE54       dec L00DC
            jmp LDE06
LDE59       lda L00DA
            ldy L00DB
            jmp X_RET_AY

            ; Calculate A*A, store in $E5+X and $E6+X (FR1+5+X, FR1+6+X)
ASQUARE     sta FR0+2
            sta FR0+3
            ldy #$08
LDE66       asl L00E6,X
            rol FR1+5,X
            rol FR0+2
            bcc LDE79
            clc
            lda L00E6,X
            adc FR0+3
            sta L00E6,X
            bcc LDE79
            inc FR1+5,X
LDE79       dey
            bne LDE66
            rts

ERR_3G      jmp ERR_3

X_CIRCLE    jsr GET3INT
            bne ERR_3G
            pha
            ldy STINDEX
            iny
            cpy NXTSTD
            bcs LDE92
            jsr GETINT
            bne ERR_3G
LDE92       pla
            bne LDE97
            lda #$01    ; Don't allow radius_X = 0
LDE97       sta FR0+1
            ; Here we have the following variables:
            ;   $99/$9A         : Center_X
            ;   $9B/$9C         : Center_Y
            ;   $D4 (FR0)       : Radius_Y
            ;   $D5 (FR0+1)     : Radius_X
            ;   $D6 (FR0+2)     : temporary variable 1
            ;   $D7 (FR0+3)     : temporary variable 2
            ;   $DC/$DB/$DA     : Add_Y = Radius_Y^2 * X, starts = Radius_Y^2 * Radius_X)
            ;   $E0 (FR1)       : X, starts = Radius_X
            ;   $E1 (FR1+1)     : Y, starts = 0
            ;   $E4/$E3/$E2     : Error, starts at 0
            ;   $E6/$E5         : Radius_X^2
            ;   $E8/$E7         : Radius_Y^2
            ;   $EB/$EA/$E9     : Add_X = Radius_X^2 * Y, starts = 0
            ;
            ; Clear all variables to 0
            ldx #$16
            lda #$00
LDE9D       sta FR0+2,X
            dex
            bpl LDE9D
            ; Gets (radius_X)^2 -> $E6/$E5 and radius_X -> $E0 (X)
            lda FR0+1
            sta FR1
            inx
            jsr ASQUARE
            ; Gets (radius_Y)^2 -> $E8/$E7
            lda FR0
            ldx #$02
            jsr ASQUARE
            ; Multiplies (radius_Y^2) * (radius_X) -> $DC/$DB/$DA
            lda FR0+1
            sta FR0+2
            ldy #$08
LDEB7       asl L00DC
            rol L00DB
            rol L00DA
            asl FR0+2
            bcc LDED2
            clc
            lda L00DC
            adc L00E8
            sta L00DC
            lda L00DB
            adc L00E7
            sta L00DB
            bcc LDED2
            inc L00DA
LDED2       dey
            bne LDEB7
            ; Plots 4 points in the circle
LDED5       jsr ADD_XPOS
            jsr ADD_Y_PLOT      ; center + (+x,+y)
            jsr ADD_XPOS
            jsr SUB_Y_PLOT      ; center + (+x,-y)
            jsr SUB_XPOS
            jsr ADD_Y_PLOT      ; center + (-x,+y)
            jsr SUB_XPOS
            jsr SUB_Y_PLOT      ; center + (-x,-y)
            ; Test error
            bit FR1+2
            bmi LDF12
            ; Error Positive, increment Y
            inc FR1+1           ; Y = Y + 1
            clc                 ; Add_X = Add_X + Radius_X ^ 2
            lda L00EB
            adc L00E6
            sta L00EB
            lda L00EA
            adc FR1+5
            sta L00EA
            bcc LDF04
            inc L00E9
LDF04       sec                 ; Error = Error - Add_X
            ldx #$02
LDF07       lda FR1+2,X
            sbc L00E9,X
            sta FR1+2,X
            dex
            bpl LDF07
            bmi LDED5           ; Loop again

            ; Error Negative, decrement X
LDF12       lda FR1
            beq CLEAR_XYPOS
            dec FR1             ; X = X - 1
            sec                 ; Add_Y = Add_Y - Radius_Y ^2
            lda L00DC
            sbc L00E8
            sta L00DC
            lda L00DB
            sbc L00E7
            sta L00DB
            bcs LDF29
            dec L00DA
LDF29       clc                 ; Error = Error + Add_Y
            ldx #$02
LDF2C       lda FR1+2,X
            adc L00DA,X
            sta FR1+2,X
            dex
            bpl LDF2C
            bmi LDED5           ; Loop Again

ADD_XPOS    clc
            lda L0099
            adc FR1
            sta COLCRS
            lda L009A
            adc #$00
            sta COLCRS+1
            rts

CLEAR_XYPOS ldx #$00
            stx ROWCRS
            stx COLCRS
            stx COLCRS+1
            rts

SUB_XPOS    sec
            lda L0099
            sbc FR1
            sta COLCRS
            lda L009A
            sbc #$00
            sta COLCRS+1
            rts
ADD_Y_PLOT  clc
            lda L009B
            adc FR1+1
            sta ROWCRS
            lda L009C
            adc #$00
            beq CIRC_PLOT
LDF69       rts
SUB_Y_PLOT  sec
            lda L009B
            sbc FR1+1
            sta ROWCRS
            lda L009C
            sbc #$00
            bne LDF69
CIRC_PLOT   ldy COLOR
            ldx #$60
            jsr PDUM_ROM
            cpy #$80    ; Check for BREAK key
            bne LDF69
            jmp CIOERR_Y

OVSEARCH    ; Search operand or variable name
            sty SCRADR+1
            ldx #$00
            stx L00AF
LDF8B       sta SCRADR
            ldx CIX
            ldy #$00
            lda (SCRADR),Y
            beq SRCNF   ; Not found
LDF95       lda LBUFF,X
            and #$7F
            inx
            eor (SCRADR),Y
            bne LDFA2
            iny
            bne LDF95
LDFA2       asl
            beq SRCFND  ; Found
            bcs LDFAD
LDFA7       iny
            lda (SCRADR),Y
            bpl LDFA7
SRCNXT      sec
LDFAD       inc L00AF
            beq ERR_04
            tya
            adc SCRADR
            bcc LDF8B
            inc SCRADR+1
            bcs LDF8B
SRCFND      clc ; Found
            rts
SRCNF       sec ; Not found
            rts
ERR_04      lda #$04
            jmp SERROR

STSEARCH    ; Search statement table
            ldx #$00
            stx L00AF
            sty SCRADR+1
LDFC9       sta SCRADR
            ldx CIX
            ldy #$01
            lda (SCRADR),Y
            beq SRCNF
LDFD3       lda LBUFF,X
            and #$7F
            inx
            cmp #$2E
            beq SRCFND  ; Found
            eor (SCRADR),Y
            bne LDFE4
            iny
            bne LDFD3
LDFE4       asl
            beq SRCFND  ; Found
            bcs LDFEE
LDFE9       iny
            lda (SCRADR),Y
            bpl LDFE9
LDFEE       inc L00AF
            sec
            tya
            adc SCRADR
            bcc LDFC9
            inc SCRADR+1
            bcs LDFC9

        @SEGMENT_SIZE TB_SEGMENT_6 $E000
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Third part, after character map
;
            org $E400
TB_SEGMENT_7

X_LET
EXEXPR      ldy #$00
            lda #$11
            sta OPSTK
            sty OPSTKX
            sty COMCNT
            sty ARSLVL
            sty L00B1
EXNXT       jsr GETTOK
            bcs EXOPER
            jsr X_PUSHVAL
            jmp EXNXT
EXOPER      sta EXSVOP
            tax
            lda OPRTAB-16,X
            sta EXSVPR
EXPTST      ldy OPSTKX
            ldx OPSTK,Y
            lda OPLTAB-16,X
            cmp EXSVPR
            bcc EOPUSH
            tax
            beq EXEND
EXOPOP      lda OPSTK,Y
            dec OPSTKX
            jsr EXOP
            jmp EXPTST
EOPUSH      lda EXSVOP
            iny
            sta OPSTK,Y
            sty OPSTKX
            jmp EXNXT
EXEND       rts

EXOP        asl
            sta EXJUMP+1
EXJUMP      jmp (OPETAB-11)

GETTOK      ldy STINDEX
            inc STINDEX
            lda (STMCUR),Y
            bmi EGTVAR
            beq EGTVARH
            cmp #$0F
            bcc EGT_NUM
            beq EGT_STRC
            rts
EGT_NUM     iny ; :EGNC In Atari Basic
            lda (STMCUR),Y
            sta FR0
            iny
            lda (STMCUR),Y
            sta FR0+1
            iny
            lda (STMCUR),Y
            sta FR0+2
            iny
            lda (STMCUR),Y
            sta FR0+3
            iny
            lda (STMCUR),Y
            sta FR0+4
            iny
            lda (STMCUR),Y
            sta FR0+5
            iny
            sty STINDEX
            lda #$00
            sta VTYPE
            rts

EGT_STRC    iny         ; EGSC in Atari Basic
            lda (STMCUR),Y
            ldx #STMCUR
RISC        sta FR0+2
            sta FR0+4
            iny
            tya
            clc
            adc $00,X
            sta FR0
            lda #$00
            sta FR0+3
            sta FR0+5
            adc $01,X
            sta FR0+1
            tya
            adc FR0+2
            tay
            lda #EVSTR + EVSDTA + EVDIM
            sta VTYPE
            sty STINDEX
            clc
            rts

EGTVARH     iny
            inc STINDEX
            lda (STMCUR),Y
EGTVAR      eor #$80
GETVAR      sta VNUM
            jsr VAR_PTR
            lda (WVVTPT),Y
            sta VTYPE
            ldy #$02
            lda (WVVTPT),Y
            sta FR0
            iny
            lda (WVVTPT),Y
            sta FR0+1
            iny
            lda (WVVTPT),Y
            sta FR0+2
            iny
            lda (WVVTPT),Y
            sta FR0+3
            iny
            lda (WVVTPT),Y
            sta FR0+4
            iny
            lda (WVVTPT),Y
            sta FR0+5
            rts

X_POPSTR    jsr X_POPVAL
PTRSTR      lda #EVSDTA
            bit VTYPE
            bne RTS_E4
            ora VTYPE
            sta VTYPE
            lsr
            bcc ERR_9
            clc
            lda FR0
            adc STARP
            sta FR0
            tay
            lda FR0+1
            adc STARP+1
            sta FR0+1
RTS_E4      rts

GETUINT     jsr GETINT
            bpl RTS_E4
            lda #$07
            jmp SERROR
GET3INT     jsr GETINT
            sta L0099
            sty L009A
GET2INT     jsr GETINT
            sta L009B
            sty L009C
GETINT      jsr EXEXPR
X_POPINT    jsr X_POPVAL
            jsr T_FPI
            bcs ERR_3
            lda FR0
            ldy FR0+1
            rts
GETBYTE     jsr GETINT
            beq RTS_E4
ERR_3       lda #$03
            .byte $2C   ; Skip 2 bytes
ERR_9       lda #$09
            .byte $2C   ; Skip 2 bytes
ERR_11      lda #$0B
            .byte $2C   ; Skip 2 bytes
ERR_10      lda #$0A
            jmp SERROR

X_PUSH_ERR11
            bcs ERR_11

X_PUSH_ERR3
            bcs ERR_3

X_PUSHVAL   inc ARSLVL
            ldy ARSLVL
            cpy #$20
            bcs ERR_10
            lda FR0+5
            sta ARGSTK5,Y
            lda FR0+4
            sta ARGSTK4,Y
            lda FR0+3
            sta ARGSTK3,Y
            lda FR0+2
            sta ARGSTK2,Y
            lda FR0+1
            sta ARGSTK1,Y
            lda FR0
            sta ARGSTK0,Y
            lda VNUM
            sta VARSTK1,Y
            lda VTYPE
            sta VARSTK0,Y
            rts

GETFP       jsr EXEXPR
X_POPVAL    ldy ARSLVL
POPVALY     dec ARSLVL
            lda ARGSTK5,Y
            sta FR0+5
            lda ARGSTK4,Y
            sta FR0+4
            lda ARGSTK3,Y
            sta FR0+3
            lda ARGSTK2,Y
            sta FR0+2
            lda ARGSTK1,Y
            sta FR0+1
            lda ARGSTK0,Y
            sta FR0
            lda VARSTK1,Y
            sta VNUM
            lda VARSTK0,Y
            sta VTYPE
            rts

X_POPVAL2   dec ARSLVL
            ldy ARSLVL
            lda ARGSTK5+1,Y
            sta FR1+5
            lda ARGSTK4+1,Y
            sta FR1+4
            lda ARGSTK3+1,Y
            sta FR1+3
            lda ARGSTK2+1,Y
            sta FR1+2
            lda ARGSTK1+1,Y
            sta FR1+1
            lda ARGSTK0+1,Y
            sta FR1
            jmp POPVALY

; Copy FR0 to variable
RTNVAR      lda VNUM
            jsr VAR_PTR
            lda VTYPE
            sta (WVVTPT),Y
            iny
            lda VNUM
            sta (WVVTPT),Y
            iny
            lda FR0
            sta (WVVTPT),Y
            iny
            lda FR0+1
            sta (WVVTPT),Y
            iny
            lda FR0+2
            sta (WVVTPT),Y
            iny
            lda FR0+3
            sta (WVVTPT),Y
            iny
            lda FR0+4
            sta (WVVTPT),Y
            iny
            lda FR0+5
            sta (WVVTPT),Y
            rts

; GVVTADR in Atari Basic - get pointer to variable table in WVVTPT
VAR_PTR     asl
            rol
            rol
            rol
            tay
            ror
            and #$F8
            clc
            adc VVTP
            sta WVVTPT
            tya
            and #$07
            adc VVTP+1
            sta WVVTPT+1
            ldy #$00
            rts

; Initializes memory pointers, erasing current program
INIT_MEM    lda #$00
            sta MEOLFLG
            sta LOADFLG
.if .def tb_fixes
            lda #<TOP_LOWMEM
            ldy #>TOP_LOWMEM
.else
            lda MEMLO
            ldy MEMLO+1
.endif
            sta LOMEM
            sty LOMEM+1
            iny
            sta VNTP
            sty VNTP+1
            sta VNTD
            sty VNTD+1
            clc
            adc #$01
            bcc LE623
            iny
LE623       sta VVTP
            sty VVTP+1
            sta STMTAB
            sty STMTAB+1
            sta STMCUR
            sty STMCUR+1
            clc
            adc #$03
            bcc LE635
            iny
LE635       sta STARP
            sty STARP+1
            sta RUNSTK
            sty RUNSTK+1
            sta TOPRSTK
            sty TOPRSTK+1
            sta APPMHI
            sty APPMHI+1
            lda #$00
            tay
            sta (VNTD),Y
            sta (STMCUR),Y
            iny
            lda #$80
            sta (STMCUR),Y
            iny
            lda #$03
            sta (STMCUR),Y
            lda #$0A
            sta PTABW
            jmp TRACE_OFF

COLDSTART   ldx #$FF
            txs
            cld
            lda LOADFLG
            beq WARMSTART

X_NEW       jsr INIT_MEM
WARMSTART   jsr RUNINIT
SNX1        jsr CLSALL
SNX2        jsr SETDZ
            lda MEOLFLG
            beq SNX3
            jsr RSTSEOL
SNX3        jsr PREADY

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
            bne LE698
            dec BRKKEY
            bne SYN_LINE
LE698       ldy #$00
            sty CIX
            sty LLNGTH
            sty L0094
            sty DIRFLG
            sty L00B3
            sty COMCNT
            sty L00B1
            lda VNTD
            sta L00AD
            lda VNTD+1
            sta L00AE
            jsr UCASEBUF
            jsr GET_LNUM
            jsr SETCODE
            lda FR0+1
            bpl LE6BF
            sta DIRFLG  ; No line number
LE6BF       jsr UCASEBUF
            sty STINDEX
            lda (INBUFF),Y
            cmp #CR
            bne SYN_STMT
            bit DIRFLG
            bmi SYN_LINE
            jmp LE7E0
; Parse one statement
SYN_STMT    lda L0094
            sta NXTSTD
            jsr SETCODE
            jsr UCASEBUF
            ldy #>SNTAB
            lda #<SNTAB
            jsr STSEARCH
            ror L00EC
            bmi LE6EE
            lda L00AF
            cmp #$15
            bne STFOUND
            stx L00DA
LE6EE       ldy #>SNTAB2
            lda #<SNTAB2
            jsr STSEARCH
            lda #$36
            bcs LE6FF
            adc L00AF
            adc #$02
            bcc STFOUND
LE6FF       bit L00EC
            bmi STFOUND
            lda #<SNT_END
            sta SCRADR
            lda #>SNT_END
            sta SCRADR+1
            lda #$15
            ldx L00DA
STFOUND     stx CIX
            jsr SETCODE
            jsr T_SKPSPC
            jsr SYNENT
            bcc SYNOK
            ldy LLNGTH
            lda (INBUFF),Y
            cmp #CR
            bne LE72A
            iny
            sta (INBUFF),Y
            dey
            lda #$20
LE72A       ora #$80
            sta (INBUFF),Y
            lda #$40
            ora DIRFLG
            sta DIRFLG
            ldy STINDEX
            sty CIX
            ldx #$03
            stx NXTSTD
            inx
            stx L0094
            lda #TOK_ERROR
LE741       jsr SETCODE
LE744       ldy CIX
            lda (INBUFF),Y
            inc CIX
            cmp #CR
            bne LE741
            jsr SETCODE
SYNOK       lda L0094
            ldy NXTSTD
            sta VARSTK0,Y
            ldy CIX
            dey
            lda (INBUFF),Y
            cmp #CR
            beq LE764
            jmp SYN_STMT
LE764       ldy #$02
            lda L0094
            sta VARSTK0,Y
            jsr SRCHLN_NC
            lda #$00
            bcs LE776
            ldy #$02
            lda (STMCUR),Y
LE776       sec
            sbc L0094
            beq LE79F
            bcs LE790
            eor #$FF
            tay
            iny
            ldx #STMCUR
            jsr EXPLOW
            lda L0097
            sta STMCUR
            lda L0098
            sta STMCUR+1
            bne LE79F
LE790       tay
            clc
            adc STMCUR
            sta STMCUR
            bcc LE79A
            inc STMCUR+1
LE79A       ldx #STMCUR
            jsr CONTLOW
LE79F       ldy L0094
LE7A1       dey
            lda VARSTK0,Y
            sta (STMCUR),Y
            tya
            bne LE7A1
            bit DIRFLG
            bvc LE7D8
            lda L00B1
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

LE7D8       bpl SYN_LINE_
            jsr FIX_RSTK
            jmp EXECNL

LE7E0       jsr SRCHLN_NC
            bcs SYN_LINE_
            ldy #$02
            lda (STMCUR),Y
            tay
            clc
            adc STMCUR
            sta STMCUR
            bcc LE7F3
            inc STMCUR+1
LE7F3       ldx #STMCUR
            jsr CONTLOW
            jmp SYN_LINE

GET_LNUM    jsr T_AFP
            bcc LE808
LE800       lda #$00
            sta CIX
            ldy #$80
            bmi LE813
LE808       jsr T_FPI
            bcs LE800
            ldy FR0+1
            bmi LE800
            lda FR0
LE813       sty TSLNUM+1
            sta TSLNUM
            jsr SETCODE
            lda TSLNUM+1
            sta FR0+1
            jmp SETCODE

SYNENT      ldy #$00
            sty OPSTKX
            lda (SCRADR),Y
            asl
            tay
            lda SYN_ATAB,Y
            sta CPC
            sta SPC
            lda SYN_ATAB+1,Y
            sta CPC+1
            sta SPC+1
            lda L0094
            sta SOX
            lda CIX
            sta SIX
NEXT        inc CPC
            bne LE849
            inc CPC+1
LE849       ldx #$00
            lda (CPC,X)
            bmi LE85B
            cmp #$05
            bcc LE8A2
            jsr TERMTST
            bcc NEXT
            jmp FAIL
LE85B       asl
            tay
            lda SYN_ATAB+1,Y
            pha
            lda SYN_ATAB,Y
            pha
            cpy #$12
            bcs PUSH
            pla
            tay
            pla
            jsr JSR_AY
            bcc NEXT
            jmp FAIL

JSR_AY      pha
            tya
            pha
            rts

PUSH        ldx OPSTKX
            inx
            inx
            inx
            inx
            beq ERR_14B
            stx OPSTKX
            lda CIX
            sta SIX,X
            lda L0094
            sta SOX,X
            lda CPC
            sta SPC,X
            lda CPC+1
            sta SPC+1,X
            pla
            sta CPC
            pla
            sta CPC+1
            jmp NEXT
ERR_14B     jmp ERR_14
LE8A2       ldx OPSTKX
            bne LE8A7
            rts
LE8A7       lda SPC,X
            sta CPC
            lda SPC+1,X
            sta CPC+1
            dex
            dex
            dex
            dex
            stx OPSTKX
            bcs FAIL
            jmp NEXT

FAIL        inc CPC
            bne LE8C2
            inc CPC+1
LE8C2       ldx #$00
            lda (CPC,X)
            bmi FAIL
            cmp #$03
            beq LE8A2
            bcs FAIL
            lda CIX
            cmp LLNGTH
            bcc LE8D6
            sta LLNGTH
LE8D6       ldx OPSTKX
            lda SIX,X
            sta CIX
            lda SOX,X
            sta L0094
            jmp NEXT

RTS_2       rts

TERMTST     cmp #$0F
            bne SRCONT
            inc CPC
            bne LE8F0
            inc CPC+1
LE8F0       ldx #$00
            lda (CPC,X)
            clc
            dec L0094

SETCODE     ldy L0094
            sta VARSTK0,Y
            inc L0094
            bne RTS_2

ERR_14      lda #$0E
            jmp SERROR


            ; Exit after parsing "THEN", skip to parse next statement
LEIF        ldx #$FF
            txs
            lda L0094
            ldy NXTSTD
            sta VARSTK0,Y
            jmp SYN_STMT

            ; Exit after parsing "REM" or "DATA", skip to parse next statement
LEREM       ldx #$FF
            txs
            ldy #$04
            lda VARSTK0,Y
            cmp #$54
            bne LE928
            ldy CIX
            dey
            lda #CR
            sta (INBUFF),Y
            jmp SYNOK

LE928       jmp LE744

SRCONT      jsr UCASEBUF
            cpy L00B3
            beq LE946
            sty L00B3
            ldy #>OPNTAB
            lda #<OPNTAB
            jsr OVSEARCH
            bcs LE969
            stx L00B2
            clc
            lda L00AF
            adc #$10
            sta SVONTC
LE946       ldy #$00
            lda (CPC),Y
            cmp SVONTC
            beq LE960
            cmp #CATN
            bne LE95C
            lda SVONTC
            cmp #CDPEEK+1
            bcs LE95C
            cmp #CATN
            bcs LE95E
LE95C       sec
            rts
LE95E       lda SVONTC
LE960       jsr SETCODE
            ldx L00B2
            stx CIX
            clc
            rts
LE969       lda #$00
            sta SVONTC
            sec
            rts

            ; Check label variable name
LLVARN      lda #$C0
            bne GETVARN

            ; Check numeric variable name
LNVARN      lda #$00            ; TNVAR in BASIC source
            beq GETVARN

            ; Check string variable name
LSTVARN     lda #EVSTR          ; TSVAR in BASIC source
GETVARN     sta VTYPE           ; TVAR  in BASIC source
            jsr UCASEBUF
            sty TVSCIX
            jsr CHK_NAMECHR
            bcs TVFAIL
            jsr SRCONT
            lda SVONTC
            beq TV1
            ldy L00B2
            lda (INBUFF),Y
            cmp #'0'
            bcc TVFAIL
TV1         inc CIX
            jsr CHK_NAMECHR
            bcc TV1
            cmp #'0'
            bcc LE9A3
            cmp #'9'+1
            bcc TV1
LE9A3       cmp #'$'
            beq TVSTR
            bit VTYPE
            bpl TVOK
            bvs TVOK2
TVFAIL      sec
            rts
TVSTR       bit VTYPE
            bpl TVFAIL
            bvs TVFAIL
            iny
            bne TVOK2
TVOK        lda (INBUFF),Y
            cmp #'('
            bne TVOK2
            iny
            lda #EVARRAY
            ora VTYPE
            sta VTYPE
TVOK2       lda TVSCIX
            sta CIX
            sty TVSCIX
            ldy VNTP+1
            lda VNTP
            jsr OVSEARCH
TVRS        bcs TVS0
            cpx TVSCIX
            beq TVSUC
LE9D8       jsr SRCNXT
            jmp TVRS
TVS0        sec                 ; New variable, store
            lda TVSCIX
            sbc CIX
            sta CIX
            tay
            ldx #VNTD
            jsr EXPLOW
            lda L00AF
            sta VNUM
            ldy CIX
            dey
            ldx TVSCIX
            dex
            lda LBUFF,X
            ora #$80
TVS1        sta (L0097),Y
            dex
            lda LBUFF,X
            dey
            bpl TVS1
            ldy #$08    ; Expand VVT by 8 bytes
            ldx #STMTAB
            jsr EXPLOW
            inc L00B1
            jsr T_ZFR0
            ldy #$07
TVS2        lda VTYPE,Y
            sta (L0097),Y
            dey
            bpl TVS2
TVSUC       tya                 ; Test Variable Syntax U C
            pha
            lda CPC             ; Save CPC, it is the same as WVVTPT
            pha
            ldx CPC+1
            lda L00AF
            jsr VAR_PTR
            lda (WVVTPT),Y
            eor VTYPE
            tay
            stx CPC+1           ; Restore CPC
            pla
            sta CPC
            cpy #$80
            pla
            tay
            bcs LE9D8
            bit VTYPE
            bvc TVNP
            bmi TVNP
            dec TVSCIX
TVNP        lda TVSCIX          ; Test Variable No Paren
            sta CIX
            lda L00AF
            bpl LEA4C           ; Variable > 127
            lda #$00
            jsr SETCODE
            lda L00AF
LEA4C       eor #$80
            jsr SETCODE
LEA51       clc
            rts

CHK_NAMECHR ldy CIX
            lda (INBUFF),Y
IS_NAMECHR  cmp #'_'
            beq LEA51
            cmp #'A'
            bcc CHKFAIL
            cmp #'Z'+1
            rts

LEA62       ldy TVSCIX
            sty CIX
CHKFAIL     sec
            rts

GET_HEXDIG  ldy CIX
            lda (INBUFF),Y
            sec
            sbc #'0'
            bcc CHKFAIL
            cmp #10
            bcc HEXDIGOK
            cmp #'A'-'0'
            bcc CHKFAIL
            sbc #7
            cmp #$10
            bcs CHKFAIL

HEXDIGOK    ldy #$04
LEA81       asl FR0
            rol FR0+1
            dey
            bne LEA81
            ora FR0
            sta FR0
            inc CIX
            clc
            rts

            ; Read a numeric constant
LTNCON
            jsr UCASEBUF
            sty TVSCIX
            lda (INBUFF),Y
            cmp #'$'
            beq LEAA2
            jsr T_AFP
            bcc LEAC0
            bcs LEA62
LEAA2       inc CIX
            jsr UCASEBUF
            jsr T_ZFR0
            jsr GET_HEXDIG
            bcs LEA62
LEAAF       jsr GET_HEXDIG
            bcs LEABA
            lda FR0+1
            and #$F0
            beq LEAAF
LEABA       jsr T_IFP
            lda #$0D
            .byte $2C   ; Skip 2 bytes
LEAC0       lda #$0E
            jsr SETCODE
            ldy L0094
            ldx #$00
LEAC9       lda FR0,X
            sta VARSTK0,Y
            iny
            inx
            cpx #$06
            bcc LEAC9
            sty L0094
            clc
            rts

            ; Test if input is string constant
LSTCONST    jsr UCASEBUF
            lda (INBUFF),Y
            cmp #'"'
            beq LEAE3
            sec
            rts
LEAE3       lda #$0F
            jsr SETCODE
            lda L0094
            sta EXSVOP
LEAEC       jsr SETCODE
            inc CIX
            ldy CIX
            lda (INBUFF),Y
            cmp #CR
            beq LEB06
            cmp #'"'
            bne LEAEC
            inc CIX
            iny
            lda (INBUFF),Y
            cmp #'"'
            beq LEAEC
LEB06       clc
            lda L0094
            sbc EXSVOP
            ldy EXSVOP
            sta VARSTK0,Y
            clc
            rts

            ; Check if label is at start of a line
LCHKLBL     lda VARSTK0+1
            asl
            bcs LEB1C
            lda L0094
            cmp #$06
LEB1C       rts

UCASEBUF    ldy CIX
LEB1F       lda (INBUFF),Y
            and #$7F
            cmp #' '
            bne LEB2A
            iny
            bne LEB1F
LEB2A       sty CIX
LEB2C       lda (INBUFF),Y
            cmp #CR
            beq LEB57
            and #$7F
            sta (INBUFF),Y
            cmp #'a'
            bcc LEB42
            cmp #'z'+1
            bcs LEB42
            and #$5F
            sta (INBUFF),Y
LEB42       iny
            cmp #'0'
            bcc LEB57
            cmp #'9'+1
            bcc LEB2C
            cmp #'A'
            bcc LEB57
            cmp #'Z'+1
            bcc LEB2C
            cmp #'_'
            beq LEB2C
LEB57       ldy CIX
            rts

; Define STATEMENT table, use a macro to keep the number of each statement
            .def ?@stmt_current = -1
.macro @STMTDEF
 .def ?@stmt_current = ?@stmt_current + 1
 .def TOK_:1  = ?@stmt_current
 .if :0 = 2
            .cb _S:1, :2
 .else
            .cb _S:3, :2
 .endif
.endm

_SEOS   = _EOS
_SERROR = 0

SNTAB
            @STMTDEF REM,      'REM'
            @STMTDEF DATA,     'DATA',     REM
            @STMTDEF INPUT,    'INPUT'
            @STMTDEF COLOR,    'COLOR',    NUM1
            @STMTDEF LIST,     'LIST'
            @STMTDEF ENTER,    'ENTER',    STRING
            @STMTDEF LET,      'LET'
            @STMTDEF IF,       'IF'
            @STMTDEF FOR,      'FOR'
            @STMTDEF NEXT,     'NEXT',     NVARN
            @STMTDEF GOTO,     'GOTO',     NUM1
            @STMTDEF GO_TO,    'GO TO',    NUM1
            @STMTDEF GOSUB,    'GOSUB',    NUM1
            @STMTDEF TRAP,     'TRAP'
            @STMTDEF BYE,      'BYE',      EOS
            @STMTDEF CONT,     'CONT',     EOS
            @STMTDEF COM,      'COM',      DIM
            @STMTDEF CLOSE,    'CLOSE'
            @STMTDEF CLR,      'CLR',      EOS
            @STMTDEF DEG,      'DEG',      EOS
            @STMTDEF DIM,      'DIM'
SNT_END     @STMTDEF END,      'END',      EOS
            @STMTDEF NEW,      'NEW',      EOS
            @STMTDEF OPEN,     'OPEN'
            @STMTDEF LOAD,     'LOAD',     STRING
            @STMTDEF SAVE,     'SAVE',     STRING
            @STMTDEF STATUS,   'STATUS'
            @STMTDEF NOTE,     'NOTE'
            @STMTDEF POINT,    'POINT'
            @STMTDEF XIO,      'XIO'
            @STMTDEF ON,       'ON'
            @STMTDEF POKE,     'POKE',     NUM2
            @STMTDEF PRINT,    'PRINT'
            @STMTDEF RAD,      'RAD',      EOS
            @STMTDEF READ,     'READ'
            @STMTDEF RESTORE,  'RESTORE'
            @STMTDEF RETURN,   'RETURN',   EOS
            @STMTDEF RUN,      'RUN'
            @STMTDEF STOP,     'STOP',     EOS
            @STMTDEF POP,      'POP',      EOS
            @STMTDEF SPRINT,   '?',        PRINT
            @STMTDEF GET,      'GET',      INPUT
            @STMTDEF PUT,      'PUT'
            @STMTDEF GRAPHICS, 'GRAPHICS', NUM1
            @STMTDEF PLOT,     'PLOT',     NUM2
            @STMTDEF POSITION, 'POSITION', NUM2
            @STMTDEF DOS,      'DOS',      EOS
            @STMTDEF DRAWTO,   'DRAWTO',   NUM2
            @STMTDEF SETCOLOR, 'SETCOLOR', NUM3
            @STMTDEF LOCATE,   'LOCATE'
            @STMTDEF SOUND,    'SOUND'
            @STMTDEF LPRINT,   'LPRINT'
            @STMTDEF CSAVE,    'CSAVE',    EOS
            @STMTDEF CLOAD,    'CLOAD',    EOS
            @STMTDEF INVLET,   "0,128",    LET  ; "invisible" LET
            @STMTDEF ERROR,    'ERROR-  ', ERROR
SNTAB2      @STMTDEF DPOKE,    'DPOKE',    NUM2
            @STMTDEF MOVE,     'MOVE',     NUM3
            @STMTDEF NMOVE,    '-MOVE',    NUM3
            @STMTDEF FFLAG,    '*F',       FLAG
            @STMTDEF REPEAT,   'REPEAT',   EOS
            @STMTDEF UNTIL,    'UNTIL',    NUM1
            @STMTDEF WHILE,    'WHILE',    NUM1
            @STMTDEF WEND      'WEND',     EOS
            @STMTDEF ELSE      'ELSE',     EOS
            @STMTDEF ENDIF     'ENDIF',    EOS
            @STMTDEF BPUT,     'BPUT',     POINT
            @STMTDEF BGET,     'BGET',     POINT
            @STMTDEF FILLTO,   'FILLTO',   NUM2
            @STMTDEF DO,       'DO',       EOS
            @STMTDEF LOOP,     'LOOP',     EOS
            @STMTDEF EXIT,     'EXIT',     RESTORE
            @STMTDEF DIR,      'DIR'
            @STMTDEF LOCK,     'LOCK',     STRING
            @STMTDEF UNLOCK,   'UNLOCK',   STRING
            @STMTDEF REANME,   'RENAME',   STRING
            @STMTDEF DELETE,   'DELETE',   STRING
            @STMTDEF PAUSE,    'PAUSE',    NUM1
            @STMTDEF TIMEPE,   'TIME$=',   STRING
            @STMTDEF PROC,     'PROC',     LABEL
            @STMTDEF EXEC,     'EXEC'
            @STMTDEF ENDPROC,  'ENDPROC',  EOS
            @STMTDEF FCOLOR,   'FCOLOR',   NUM1
            @STMTDEF LFLAG,    '*L',       FLAG
            @STMTDEF LREM,     '--',       REM
            @STMTDEF RENUM,    'RENUM',    NUM3
            @STMTDEF DEL,      'DEL',      NUM2
            @STMTDEF DUMP,     'DUMP',     DIR
            @STMTDEF TRACE     'TRACE',    FLAG
            @STMTDEF TEXT,     'TEXT',     TEXT
            @STMTDEF BLOAD,    'BLOAD',    STRING
            @STMTDEF BRUN,     'BRUN',     STRING
            @STMTDEF GOPND,    'GO#',      EXEC
            @STMTDEF PND,      '#',        LABEL
            @STMTDEF BFLAG,    '*B',       FLAG
            @STMTDEF PAINT,    'PAINT',    NUM2
            @STMTDEF CLS,      'CLS',      CLOSE
            @STMTDEF DSOUND,   'DSOUND',   SOUND
            @STMTDEF CIRCLE,   'CIRCLE'
            @STMTDEF PPUT,     '%PUT',     PUT
            @STMTDEF PGET,     '%GET',     INPUT
            .byte $9A
            .byte $00

; Macro to define operator tokens (OPNTAB)

            .def ?@fn_current = $0F
.macro @FNDEF
 .def ?@fn_current = ?@fn_current + 1
 .def :1  = ?@fn_current
            .cb :2
.endm

OPNTAB
            @FNDEF CDQ     $82
            @FNDEF CSOE    $80
            @FNDEF CCOM    ','
            @FNDEF CDOL    '$'
            @FNDEF CEOS    ':'
            @FNDEF CSC     ';'
            @FNDEF CCR     CR
            @FNDEF CGTO    'GOTO'
            @FNDEF CGS     'GOSUB'
            @FNDEF CTO     'TO'
            @FNDEF CSTEP   'STEP'
            @FNDEF CTHEN   'THEN'
            @FNDEF CPND    '#'
            @FNDEF CLE     '<='
            @FNDEF CNE     '<>'
            @FNDEF CGE     '>='
            @FNDEF CLT     '<'
            @FNDEF CGT     '>'
            @FNDEF CEQ     '='
            @FNDEF CEXP    '^'
            @FNDEF CMUL    '*'
            @FNDEF CPLUS   '+'
            @FNDEF CMINUS  '-'
            @FNDEF CDIV    '/'
            @FNDEF CNOT    'NOT'
            @FNDEF COR     'OR'
            @FNDEF CAND    'AND'
            @FNDEF CLPRN   '('
            @FNDEF CRPRN   ')'
            @FNDEF CAASN   '='
            @FNDEF CSASN   '='
            @FNDEF CSLE    '<='
            @FNDEF CSNE    '<>'
            @FNDEF CSGE    '>='
            @FNDEF CSLT    '<'
            @FNDEF CSGT    '>'
            @FNDEF CSEQ    '='
            @FNDEF CUPLUS  '+'
            @FNDEF CUMINUS '-'
            @FNDEF CSLPRN  '('
            @FNDEF CALPRN  $80
            @FNDEF CDLPRN  $80
            @FNDEF CFLPRN  '('
            @FNDEF CDSLPRN '('
            @FNDEF CACOM   ','
            @FNDEF CSTR    'STR$'
            @FNDEF CCHR    'CHR$'
            @FNDEF CUSR    'USR'
            @FNDEF CASC    'ASC'
            @FNDEF CVAL    'VAL'
            @FNDEF CLEN    'LEN'
            @FNDEF CADR    'ADR'
            @FNDEF CATN    'ATN'
            @FNDEF CCOS    'COS'
            @FNDEF CPEEK   'PEEK'
            @FNDEF CSIN    'SIN'
            @FNDEF CRND    'RND'
            @FNDEF CFRE    'FRE'
            @FNDEF CFEXP   'EXP'
            @FNDEF CLOG    'LOG'
            @FNDEF CCLOG   'CLOG'
            @FNDEF CSQR    'SQR'
            @FNDEF CSGN    'SGN'
            @FNDEF CABS    'ABS'
            @FNDEF CINT    'INT'
            @FNDEF CPADDLE 'PADDLE'
            @FNDEF CSTICK  'STICK'
            @FNDEF CPTRIG  'PTRIG'
            @FNDEF CSTRIG  'STRIG'
            @FNDEF CDPEEK  'DPEEK'
            @FNDEF CIAND   '&'
            @FNDEF CIOR    '!'
            @FNDEF CINSTR  'INSTR'
            @FNDEF CINKEYP 'INKEY$'
            @FNDEF CEXOR   'EXOR'
            @FNDEF CHEXP   'HEX$'
            @FNDEF CDEC    'DEC'
            @FNDEF CFDIV   'DIV'
            @FNDEF CFRAC   'FRAC'
            @FNDEF CTIMEP  'TIME$'
            @FNDEF CTIME   'TIME'
            @FNDEF CMOD    'MOD'
            @FNDEF CEXEC   'EXEC'
            @FNDEF CRNDU   'RND'
            @FNDEF CRAND   'RAND'
            @FNDEF CTRUNC  'TRUNC'
            @FNDEF CN0     '%0'
            @FNDEF CN1     '%1'
            @FNDEF CN2     '%2'
            @FNDEF CN3     '%3'
            @FNDEF CGOG    'GO#'
            @FNDEF CUINSTR 'UINSTR'
            @FNDEF CERR    'ERR'
            @FNDEF CERL    'ERL'
            .byte 0

            ; Syntax table:
            .def SOR  = $02
            ; $02 = OR     : BNF or (|)
            .def SRTN = $03
            ; $03 = RTN    : return, ends syntax sub
            ; $0f = CHNG   : if matched, change token to following
            .def SCHNG = $0F
            ; $10-$7F      : corresponding FN
            ; $80 + x      : calls sub "x" from table, if x < 6, call ML sub,
            ;                                              else, calls syntax table

            ; Full expression
            ; EXPR: '(' + EXPR + ')' NOP | UNARY EXPR | NV NOP
LEXPR       .byte CLPRN,_EXPR,CRPRN,_NOP,SOR,_UNARY,_EXPR,SOR,_NV,_NOP,SRTN
            ; Unary OP
            ; UNARY: '+' (as CUPLUS) | '-' (as CUMINUS) | 'NOT'
LUNARY      .byte CPLUS,SCHNG,CUPLUS,SOR,CMINUS,SCHNG,CUMINUS,SOR,CNOT,SRTN
            ; Numeric Value
            ; NV : NFUN | NVAR | NCON | STCOMP
LNV         .byte _NFUN,SOR,_NVAR,SOR,_TNCON,SOR,_STCOMP,SRTN
            ; Numeric operation and expression
            ; NOP: OPR EXPR | <none>
LNOP        .byte _OPR,_EXPR,SOR,SRTN
            ; Numeric variable
            ; NVAR : NVARN NMAT
LNVAR       .byte _NVARN,_NMAT,SRTN
            ; Matrix access
            ; NMAT  : '(' (as CALPRN) EXPR OPTNPAR ')' | <none>
LNMAT       .byte CLPRN,SCHNG,CALPRN,_EXPR,_OPTNPAR,CRPRN,SOR,SRTN
            ; Optional numeric parameter (after a comma)
            ; OPTNPAR : ',' (as CACOM) EXPR | <none>
LOPTNPAR   .byte CCOM,SCHNG,CACOM,_EXPR,SOR,SRTN
            ; Any "extended" numeric function
            ; NFUN : 'instr' FINSTR | 'uinstr' FINSTR | 'time' |
            ;        '#0' | '#1' | '#2' | '#3' | 'err' | 'erl' |
            ;        NFUSR | 'FRAC' FNPAR1 | 'RAND' FNPAR1 | 'TRUNC' FNPAR1 |
            ;        'ATN' FNPAR1 | FNMST STPAR1 | 'RND' (as RNDU)
LNFUN       .byte CINSTR,_FINSTR,SOR,CUINSTR,_FINSTR,SOR,CTIME,SOR
            .byte CN0,SOR,CN1,SOR,CN2,SOR,CN3,SOR,CERR,SOR,CERL,SOR
            .byte _NFUSR,SOR,CFRAC,_FPAR1,SOR,CRAND,_FPAR1,SOR,CTRUNC,_FPAR1,SOR
            .byte CATN,_FPAR1,SOR,_FNMST,_STPAR1,SOR,CRND,SCHNG,CRNDU,SRTN
            ; USR function call
            ; NFUSR : 'USR' NFLPRN FPARN ')'
LNFUSR      .byte CUSR,_FNLPRN,_FPARN,CRPRN,SRTN
            ; Parameter for a numeric function (1 argument)
            ; FPAR1 : NFLPRN EXPR ')'
LFPAR1      .byte _FNLPRN,_EXPR,CRPRN,SRTN
            ; String parameter for a function (1 argument)
            ; SPAR1 : NFLPRN SEXPR ')'
LSTPAR1     .byte _FNLPRN,_SEXPR,CRPRN,SRTN
            ; String comparison expression
            ; STCOMP : SEXPR SCOMP SEXPR
LSTCOMP     .byte _SEXPR,_SCOMP,_SEXPR,SRTN
            ; String expression
            ; SEXPR : 'inkey$' | 'time$' | STFUN | STVAR | ZZ
LSEXPR      .byte CINKEYP,SOR,CTIMEP,SOR,_STFUN,SOR,_STVAR,SOR,_STCONST,SRTN
            ; String function call
            ; STFUN : STFNM FPAR1
LSTFUN      .byte _STFNM,_FPAR1,SRTN
            ; String variable
            ; STVAR : STVARN STSUB
LSTVAR      .byte _STVARN,_STSUB,SRTN
            ; String access
            ; STSUB : '(' (as CSLPRN) EXPR OPTNPAR ')' | <none>
LSTSUB      .byte CLPRN,SCHNG,CSLPRN,_EXPR,_OPTNPAR,CRPRN, SOR, SRTN
            ; String comparisons:
            ; SCOMP : '<=' (as CSLE) | '<>' (as CSNE) ... etc.
LSCOMP      .byte CLE,SCHNG,CSLE, SOR, CNE,SCHNG,CSNE, SOR, CGE,SCHNG,CSGE, SOR
            .byte CLT,SCHNG,CSLT, SOR, CGT,SCHNG,CSGT, SOR, CEQ,SCHNG,CSEQ, SRTN
            ; PUT statement
            ; SPUT: IOOPT SNUMN EOS
LSPUT       .byte _IOOPT,_SNUMN,_EOS,SRTN
            ; Statement with one numeric expression
            ; SNUM1 : EXPR EOS
LSNUM1      .byte _EXPR,_EOS,SRTN
            ; LET: Variable assignment
            ; SLET : NVAR '=' (as CAASN) EXPR EOS | STVAR '=' (as CSASN) SEXPR EOS
LSLET       .byte _NVAR,CEQ,SCHNG,CAASN,_EXPR,_EOS, SOR,_STVAR,CEQ,SCHNG,CSASN,_SEXPR,_EOS,SRTN
            ; FOR expression
            ; SFOR : NVARN '=' (as CAASN) EXPR 'TO' EXPR STEP EOS
LSFOR       .byte _NVARN,CEQ,SCHNG,CAASN,_EXPR,CTO,_EXPR,_STEP,_EOS,SRTN
            ; STEP parameter
            ; STEP : 'STEP' EXPR | <none>
LSTEP       .byte CSTEP,_EXPR,SOR,SRTN
            ; LOCATE expression
            ; SLOCATE : NUM2 ',' SNVARN
LSLOCATE    .byte _NUM2,CCOM,_SNVARN,SRTN
            ; TEXT expression
            ; STEXT : NUM2 ',' PEXPR EOS
LSTEXT      .byte _NUM2,CCOM,_PEXPR,_EOS,SRTN
            ; STATUS expression
            ; SSTATUS : IOEXP PSEP [fall through] NVARN EOS
LSSTATUS    .byte _IOEXP,_PSEP
            ; A numeric variable name at end of statement
            ; SNVARN : NVARN EOS
LSNVARN     .byte _NVARN,_EOS,SRTN
            ; RESTORE / EXIT expression (optional label or line number)
            ; : EOS | [fall through] SNUM1 | '#' ??
LSRESTORE   .byte _EOS,SOR
            ; TRAP expression: Line number or label name
            ; : SNUM1 | '#' SEXEC
LSTRAP      .byte _SNUM1,SOR,CPND,_SEXEC,SRTN
            ; INPUT / GET / %GET expression
            ; BUG: this should only be used for INPUT, as currently you can do
            ;      ' GET "Hello";A$ ' that overwrites variable memory!
            ; SINPUT : IOSOPT [fall through]
LSINPUT     .byte _IOSOPT
            ; READ expression, one ore more variable names
            ; SREAD : NSVARN NSVARX EOS
LSREAD      .byte _NSVARN,_NSVARX,_EOS,SRTN
            ; End Of Statement
            ; EOS : ':' | EOL
LEOS        .byte CEOS,SOR,CCR,SRTN
            ; PRINT statement
            ; SPRINT : IOEXP EOS | IOOPT [fall through] .......
LSPRINT     .byte _IOEXP,_EOS,SOR,_IOOPT
            ; LPRINT statement
            ; SLPRINT : PRINT1 EOS
LSLPRINT    .byte _PRINT1,_EOS,SRTN
            ; Input/Output channel expression
            ; IOEXP : '#' EXPR
LIOEXP      .byte CPND,_EXPR,SRTN
            ; Numeric or string variable name  (BF)
            ; NSVARN : NVARN | STVARN
LNSVARN     .byte _NVARN,SOR,_STVARN,SRTN
            ; One or more numeric/string variable names
            ; NSVARP : NSVARN ',' NSVARX | <none>
LNSVARP     .byte _NSVARN,_NSVARX,SOR,SRTN
            ; Optional more numeric/string variable names
            ; NSVARX : ',' NSVARP | <none>
LNSVARX     .byte CCOM,_NSVARP,SOR,SRTN
            ; XIO statement
            ; SXIO : EXPR ',' [fall through] IOEXP ',' NUM2 ',' SEXPR EOS
LSXIO       .byte _EXPR,CCOM
            ; OPEN statement
            ; SOPEN : IOEXP ',' NUM2 ',' [fall through] SEXPR EOS
LSOPEN      .byte _IOEXP,CCOM,_NUM2,CCOM
            ; Statement with one string argument
            ;  : SEXPR EOS
LSSTRING    .byte _SEXPR,_EOS,SRTN
            ; CLOSE / CLS expression
            ; SCLOSE : IOEXP EOS | EOS
LSCLOSE     .byte _IOEXP,_EOS,SOR,_EOS,SRTN
            ; RUN expression
            ; SRUN : SSTRING | EOS
LSRUN       .byte _SSTRING,SOR,_EOS,SRTN
            ; Optional IO specifier
            ; IOOPT : IOEXP PSEP | <none>
LIOOPT      .byte _IOEXP,_PSEP,SOR,SRTN
            ; Optional IO or string constant to show
            ; IOSOPT : IOEXP PSEP | STCONST PSEP |
LIOSOPT     .byte _IOEXP,_PSEP,SOR,_STCONST,_PSEP,SOR,SRTN
            ; LIST expression
            ; SLIST : ?? SNUM1 | ?? SNUM2 | ?? EXPR ',' EOS | [fall through] SSTRING | EOS
LSLIST      .byte _STROPT,_SNUM1,SOR,_STROPT,_SNUM2,SOR,_STROPT,_EXPR,CCOM,_EOS,SOR
            ; DIR / DUMP expression
            ; SDIR : SSTRING | EOS
LSDIR       .byte _SSTRING,SOR,_EOS,SRTN
            ; Optional string expression at start of statement
            ; STROPT : SEXPR ',' | <none>
LSTROPT     .byte _SEXPR,CCOM,SOR,SRTN
            ; NOTE expression
            ; SNOTE : IOEXP ',' NVARN ',' SNVARN
LSNOTE      .byte _IOEXP,CCOM,_NVARN,CCOM,_SNVARN,SRTN
            ; Two numeric expressions
            ; NUM2 : EXPR ',' EXPR
LNUM2       .byte _EXPR,CCOM,_EXPR,SRTN
            ; SOUND / DSOUND expression
            ; SSOUND : EOS | EXPR ',' [fall through] EXPR ',' NUM2 EOS
LSSOUND     .byte _EOS,SOR,_EXPR,CCOM
            ; Statement with three numeric expressions
            ; SNUM3 : EXPR ',' [fall through] NUM2 EOS
LSNUM3      .byte _EXPR,CCOM
            ; Statement with two numeric expressions
            ; SNUM2 : NUM2 EOS
LSNUM2      .byte _NUM2,_EOS,SRTN
            ; DIM / COM expressions
            ; SDIM : VARDIM OPTDIM EOS
LSDIM       .byte _VARDIM,_OPTDIM,_EOS,SRTN
            ; ON expression
            ; SON : EXPR GTLIST EOS
LSON        .byte _EXPR,_GTLIST,_EOS,SRTN
            ; List of labels (for ON EXEC / ON GO#)
            ; LBLIST : LVARN LBLISTX
LLBLIST     .byte _LVARN,_LBLISTX,SRTN

LLBLISTX    .byte CCOM,_LBLIST,SOR,SRTN
            ; On GOTO / GOSUB expression list
            ; GTLIST : 'GOTO' SNUMN | 'GOSUB' SNUMN | 'EXEC' LBLIST | 'GO#' LBLIST
LGTLIST      .byte CGTO,_SNUMN,SOR,CGS,_SNUMN,SOR,CEXEC,_LBLIST,SOR,CGOG,_LBLIST,SRTN
            ; One or more numeric expressions
            ; SNUMN : EXPR SNUMX
LSNUMN      .byte _EXPR,_SNUMX,SRTN
            ; Optional more numeric expressions
            ;  : ',' SNUMN  | <none>
LSNUMX      .byte CCOM,_SNUMN,SOR,SRTN
            ; Variable DIM spec
            ; BUG: the formulation allows a comma at the end of the DIM expression.
            ; VARDIM : NVARN '(' (as CDLPRN) EXPR OPTNPAR ')' |
            ;          STVARN '(' (as CDSLPRN) EXPR ')'
LVARDIM     .byte _NVARN,CLPRN,SCHNG,CDLPRN,_EXPR,_OPTNPAR,CRPRN, SOR
            .byte _STVARN,CLPRN,SCHNG,CDSLPRN,_EXPR,CRPRN,SRTN
            ; List of zero or more DIM variables
            ; VARDIMX : VARDIM OPTDIM | <none>
LVARDIMX    .byte _VARDIM,_OPTDIM,SOR,SRTN
            ; Optional more DIM variable list
            ; OPTDIM : ',' VARDIMX | <none>
LOPTDIM     .byte CCOM,_VARDIMX,SOR,SRTN
            ; IF expression
            ; SIF : EXPR 'THEN' STHEN EOS | EXPR EOS
LSIF        .byte _EXPR,CTHEN,_STHEN,_EOS,SOR,_EXPR,_EOS,SRTN
            ; Expression after THEN
            ; Note: only a number is possible, not a variable, this is probably
            ;       to avoid mis-parsing "THEN A = 2" as "THEN A <ERROR> = 2"
            ; STHEN : TNCON | _EIF
LSTHEN      .byte _TNCON,SOR,_EIF
            ; Main print expression, can start with an expression or with a separator
            ; PRINT1 : PEXL | PSL PRINT2 | <none>
LPRINT1     .byte _PEXL,SOR,_PSL,_PRINT2,SOR,SRTN
            ; Print expression after a separator
            ; PRINT2 : PEXL | <none>
LPRINT2     .byte _PEXL,SOR,SRTN
            ; List of one or more print expressions
            ; PEXL : PEXPR PEXLA
LPEXL       .byte _PEXPR,_PEXLA,SRTN
            ; Numeric or String expression to print
            ; PEXPR : EXPR | SEXPR
LPEXPR      .byte _EXPR,SOR,_SEXPR,SRTN
            ; Print expression list additional
            ; PEXLA : PSL PRINT2 | <none>
LPEXLA      .byte _PSL,_PRINT2,SOR,SRTN
            ; List of one or more print separators (like ',,;')
            ; PSL : PSEP PSLA
LPSL        .byte _PSEP,_PSLA,SRTN
            ; Additional separators for the list of separators
            ; PSLA : PSL | <none>
LPSLA       .byte _PSL,SOR,SRTN
            ; Print separator
            ; PSEP : ',' | ';'
LPSEP       .byte CCOM,SOR,CSC,SRTN
            ; Function names that take a string parameter:
            ; FNMST : 'ASC' | 'VAL' | 'LEN' | 'ADR' | 'DEC'
LFNMST      .byte CASC,SOR,CVAL,SOR,CLEN,SOR,CADR,SOR,CDEC,SRTN
            ; String functions names:
            ; STFNM : 'STR$' | 'CHR$' | 'HEX$'
LSTFNM      .byte CSTR,SOR,CCHR,SOR,CHEXP,SRTN
            ; One or more numeric parameters
LFPARN      .byte _EXPR,_FPARX,SRTN
            ; Zero or more extra parameters
            ;  : ',' (as CACOM) FPARN | <none>
LFPARX      .byte CCOM,SCHNG,CACOM,_FPARN,SOR,SRTN
            ; Function left parenthesis
            ; FNLPRN : '(' (as FLPRN)
LFNLPRN     .byte CLPRN,SCHNG,CFLPRN,SRTN
            ; POINT / BPUT / BGET expression
            ; SPOINT : IOEXP ',' SNUM2
LSPOINT     .byte _IOEXP,CCOM,_SNUM2,SRTN
LSREM       .byte _EREM
            ; Instr and Uinstr parameters
            ; FINSTR : NFLPRN SEXPR ',' (as CACOM) SEXPR OPTNPAR ')'
LFINSTR     .byte _FNLPRN,_SEXPR,CCOM,SCHNG,CACOM,_SEXPR,_OPTNPAR,CRPRN,SRTN
            ; Statement defining a label ('PROC' or '#')
            ; SLABEL : CHKLBL [fall through] LVARN EOS
LSLABEL     .byte _CHKLBL
            ; Label name at end of statement
            ; SEXEC : LVARN EOS
LSEXEC      .byte _LVARN,_EOS,SRTN
            ; Flag expression
            ; SFLAG : '-' EOS | '+' EOS | EOS
LSFLAG      .byte CMINUS,_EOS,SOR,CPLUS,_EOS,SOR,_EOS,SRTN
            ; CIRCLE statement, 3 or 4 numeric  expressions
            ; SCIRCLE : EXPR ',' SNUM3 | SNUM3
LSCIRCLE    .byte _EXPR,CCOM,_SNUM3,SOR,_SNUM3,SRTN


            .def ?@syn_current = $7F
.macro @SYN_DEF
 .def ?@syn_current = ?@syn_current + 1
 .def _:1  = ?@syn_current
            .word L:1 - 1
.endm
SYN_ATAB
            @SYN_DEF EREM
            @SYN_DEF TNCON
            @SYN_DEF NVARN
            @SYN_DEF STCONST
            @SYN_DEF EIF
            @SYN_DEF STVARN
            @SYN_DEF LVARN
            @SYN_DEF CHKLBL
            @SYN_DEF OPR
            @SYN_DEF UNARY
            @SYN_DEF NV
            @SYN_DEF NOP
            @SYN_DEF EXPR
            @SYN_DEF NVAR
            @SYN_DEF NMAT
            @SYN_DEF OPTNPAR
            @SYN_DEF EOS
            @SYN_DEF SNUM1
            @SYN_DEF SNUM2
            @SYN_DEF SNUM3
            @SYN_DEF SSOUND
            @SYN_DEF SREM
            @SYN_DEF SSTRING
            @SYN_DEF SNVARN
            @SYN_DEF SINPUT
            @SYN_DEF SREAD
            @SYN_DEF SLET
            @SYN_DEF SIF
            @SYN_DEF SFOR
            @SYN_DEF SLIST
            @SYN_DEF SDIM
            @SYN_DEF SCLOSE
            @SYN_DEF SOPEN
            @SYN_DEF SXIO
            @SYN_DEF SSTATUS
            @SYN_DEF SNOTE
            @SYN_DEF SON
            @SYN_DEF SPRINT
            @SYN_DEF SLPRINT
            @SYN_DEF SLABEL
            @SYN_DEF SRESTORE
            @SYN_DEF SRUN
            @SYN_DEF SFLAG
            @SYN_DEF SPUT
            @SYN_DEF SLOCATE
            @SYN_DEF PRINT2
            @SYN_DEF PEXL
            @SYN_DEF PEXPR
            @SYN_DEF NFUN
            @SYN_DEF NFUSR
            @SYN_DEF FPAR1
            @SYN_DEF STPAR1
            @SYN_DEF STCOMP
            @SYN_DEF SEXPR
            @SYN_DEF STFUN
            @SYN_DEF STVAR
            @SYN_DEF SEXEC
            @SYN_DEF STSUB
            @SYN_DEF FINSTR
            @SYN_DEF SCOMP
            @SYN_DEF STEP
            @SYN_DEF STRAP
            @SYN_DEF IOEXP
            @SYN_DEF NSVARN
            @SYN_DEF IOOPT
            @SYN_DEF STROPT
            @SYN_DEF LBLIST
            @SYN_DEF LBLISTX
            @SYN_DEF NUM2
            @SYN_DEF GTLIST
            @SYN_DEF SNUMN
            @SYN_DEF SNUMX
            @SYN_DEF VARDIM
            @SYN_DEF VARDIMX
            @SYN_DEF STHEN
            @SYN_DEF PRINT1
            @SYN_DEF PEXLA
            @SYN_DEF PSL
            @SYN_DEF PSLA
            @SYN_DEF SPOINT
            @SYN_DEF FNLPRN
            @SYN_DEF FNMST
            @SYN_DEF STFNM
            @SYN_DEF FPARN
            @SYN_DEF FPARX
            @SYN_DEF NSVARP
            @SYN_DEF NSVARX
            @SYN_DEF OPTDIM
            @SYN_DEF PSEP
            @SYN_DEF IOSOPT
            @SYN_DEF SDIR
            @SYN_DEF STEXT
            @SYN_DEF SCIRCLE

            ; Check for numeric binary operation
LOPR        jsr SRCONT
            lda SVONTC
            cmp #CPND  ; Any operator before '#' is not binary
            bcc NOTBINOP
            cmp #CNOT  ; Also, 'NOT' is nor binary ...
            beq NOTBINOP
            cmp #CLPRN ; ... but all remaining before '(' are binary
            bcc BINOP
            cmp #CIAND ; Now, check extended operators: '&',
            beq BINOP
            cmp #CIOR  ; '!'
            beq BINOP
            cmp #CEXOR ; 'EXOR'
            beq BINOP
            cmp #CFDIV ; 'DIV'
            beq BINOP
            cmp #CMOD  ; and 'MOD'
            beq BINOP
NOTBINOP    sec
            rts
BINOP       jmp LE960

X_LIST      jsr X_GS
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

LF14F       jsr GETUINT
            sty TSLNUM+1
            sta TSLNUM
            ldx STINDEX
            cpx NXTSTD
            beq LF166
            ldy #$80
            inx
            cpx NXTSTD
            beq LF166
            jsr GETUINT
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

POP_RETURN  jsr X_POP
            jmp RETURN

; Search string #($AF) in table at AY, skipping the first X bytes on each string.
; Returns string address at SCRADR
STR_TABN    stx SRCSKP          ; LSCAN in BASIC sources
            sta SCRADR+1
            sty SCRADR
LSC0        ldy SRCSKP
            lda L00AF
            beq LSINC
            dec L00AF
LSC1        lda (SCRADR),Y
            bmi LSC2
            iny
            bne LSC1
LSC2        iny
            jsr LSINC
            jmp LSC0
LSINC       clc
            tya
            adc SCRADR
            sta SCRADR
            bcc LF1E1
            inc SCRADR+1
LF1E1       rts

; Print a string terminated with high bit set
P_STRB      ldy #$FF
            sty L00AF
LF1E6       inc L00AF
            ldy L00AF
            lda (SCRADR),Y
            pha
            cmp #CR
            beq LF1F5
            and #$7F
            beq LF1F8
LF1F5       jsr PUTCHAR
LF1F8       pla
            bpl LF1E6
            rts

P_SPCSTR    jsr P_SPC
P_STR_SPC   jsr P_STRB
P_SPC       lda #' '
            jmp PUTCHAR

PRINTLINE   ldy #$00            ; LLINE in BASIC source
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
LDLINE      ldy #$02            ; List direct line
            lda (STMCUR),Y
            sta LLNGTH
            iny
LF238       lda (STMCUR),Y
            sta NXTSTD
            iny
            sty STINDEX
            jsr LSTMT
            ldy NXTSTD
            cpy LLNGTH
            bcc LF238
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

P_STR1      jsr P_STRB
            jmp L_ADV

; List string constant
L_STRC      jsr L_NXTOK
            sta L00AF
            lda #'"'
            jsr PUTCHAR
            lda L00AF
            beq LF2EF
LF2DC       jsr L_NXTOK
            cmp #'"'
            bne LF2E8
            jsr PUTCHAR
            lda #'"'
LF2E8       jsr PUTCHAR
            dec L00AF
            bne LF2DC
LF2EF       lda #'"'
            jsr PUTCHAR
            jmp L_ADV

L_TOKS      sec
            sbc #$10
            sta L00AF
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
PRINTSTMT   sta L00AF
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

F_LIST      .byte $01

X_FL        lda (STMCUR),Y
            eor #CMINUS
            sta F_LIST
            rts

            ; Check if TOK is end of loop
CHKELOOP    cmp #TOK_NEXT
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

P_VARNAME   sta L00AF
            ldx #$00
            lda VNTP+1
            ldy VNTP
            jsr STR_TABN
            jmp P_STRB

X_FOR       sty L00B3
            lda (STMCUR),Y
            bne LF3C8
            iny
            lda (STMCUR),Y
LF3C8       eor #$80
            sta L00C7
            jsr EXEXPR
            ldx TOPRSTK
            stx TEMPA
            ldx TOPRSTK+1
            stx TEMPA+1
LF3D7       jsr X_POP
            bcs LF3E8
            bne LF3E8
            ldy #$0C
            lda (TOPRSTK),Y
            cmp L00C7
            bne LF3D7
            beq LF3F0
LF3E8       lda TEMPA
            sta TOPRSTK
            lda TEMPA+1
            sta TOPRSTK+1
LF3F0       lda #$0D
            jsr REXPAND
            jsr GETFP
            ldy #$00    ; FLIM in basic sources
            jsr MV6RS   ; Store limit to run-time stack
            jsr T_FLD1
            ldx STINDEX
            inx
            cpx NXTSTD
            bcs NSTEP
            jsr GETFP
NSTEP       ldy #$06    ; FSTEP in BASIC sources
            jsr MV6RS   ; Store step to run-time stack
            lda F_FOR
            bne FOR_TSTSKIP
LF414       lda L00C7
            ldy #$0C
            sta (TEMPA),Y
            lda #$00
            beq X_GS1

; Save current position to return-stack
X_DO
X_REPEAT
X_GS        lsr
            ldy STINDEX
            sty L00B3
X_GS1       pha
            lda #$04    ; Expand by 4 bytes
            jsr REXPAND
            pla
            ldy #$00
            sta (TEMPA),Y
            lda STMCUR
            iny
            sta (TEMPA),Y
            lda STMCUR+1
            iny
            sta (TEMPA),Y
            ldx L00B3
            dex
            txa
            iny
            sta (TEMPA),Y
LF43F       rts

; Test if the entire FOR loop must be skipped
FOR_TSTSKIP lda TOPRSTK
            pha
            lda TOPRSTK+1
            pha
            lda TEMPA
            sta TOPRSTK
            lda TEMPA+1
            sta TOPRSTK+1
            lda FR0
            pha
            lda L00C7
            jsr GETVAR
            pla
            jsr FOR_CMPLIM
            bcc LF464
            pla
            sta TOPRSTK+1
            pla
            sta TOPRSTK
            bcs LF414
LF464       pla
            pla
            lda #TOK_FOR
            ldx #TOK_NEXT
            jsr SKIP_STMT
            lda (STMCUR),Y
            bne LF474
            iny
            lda (STMCUR),Y
LF474       eor #$80
            eor L00C7
            beq LF43F
            jmp SKP_ERR

ERR_13      lda #$0D
            jmp SERROR
            ; Restore line number
RESCUR      lda SAVCUR
            sta STMCUR
            lda SAVCUR+1
            sta STMCUR+1
            rts

X_NEXT      lda (STMCUR),Y
            bne LF492
            iny
            lda (STMCUR),Y
LF492       eor #$80
            sta L00C7
XNEXTVAR    jsr X_POP
            bcs ERR_13
            bne ERR_13
            ldy #$0C
            lda (TOPRSTK),Y
            cmp L00C7           ; Test if NEXT var#
            bne XNEXTVAR
            ldy #$06            ; FSTEP in basic sources, get STEP into FR1
            lda (TOPRSTK),Y
            pha
            sta FR1
            iny
            lda (TOPRSTK),Y
            sta FR1+1
            iny
            lda (TOPRSTK),Y
            sta FR1+2
            iny
            lda (TOPRSTK),Y
            sta FR1+3
            iny
            lda (TOPRSTK),Y
            sta FR1+4
            iny
            lda (TOPRSTK),Y
            sta FR1+5
            lda L00C7
            jsr GETVAR
            jsr T_FADD
            bcs ERR_11B
            jsr RTNVAR
            pla
            jsr FOR_CMPLIM
            bcc RTS_18
            lda #$11
            jsr RCONT
            lda #TOK_FOR
            jmp RETURN

ERR_11B     jmp ERR_11

; Compare FOR count with limit
FOR_CMPLIM  sta L00EC
            ldy #$00            ; FLIM in BASIC sources
            lda (TOPRSTK),Y
            cmp FR0
            bne CMP_EXP
            iny
            lda (TOPRSTK),Y
            cmp FR0+1
            bne CMP_NE
            iny
            lda (TOPRSTK),Y
            cmp FR0+2
            bne CMP_NE
            iny
            lda (TOPRSTK),Y
            cmp FR0+3
            bne CMP_NE
            iny
            lda (TOPRSTK),Y
            cmp FR0+4
            bne CMP_NE
            iny
            lda (TOPRSTK),Y
            cmp FR0+5
            beq RTS_18
CMP_NE      ror
            eor L00EC
            eor FR0
            asl
RTS_18      rts
CMP_EXP     ora FR0
            eor L00EC
            bpl RTS_18
            ror
            eor #$80
            asl
            rts

; Contract run-stack by "A" bytes.
RCONT       clc
            adc TOPRSTK
            sta TOPRSTK
            sta APPMHI
            bcc RTS_RCONT
            inc TOPRSTK+1
            inc APPMHI+1
RTS_RCONT   rts

X_RUN       iny
            cpy NXTSTD
            bcs RUN_NOFILE
            jsr RUN_LOAD
RUN_NOFILE  lda STMTAB
            sta STMCUR
            lda STMTAB+1
            sta STMCUR+1
            lda #$00
            sta F_FOR
            sta F_BRK
            ldy #$03
            sty NXTSTD
            dey
            lda (STMCUR),Y
            sta LLNGTH
            dey
            lda (STMCUR),Y
            bmi RUNEND
            jsr RUNINIT

X_CLR       jsr ZVAR
            jsr RSTPTR
            lda #$00
            sta DATALN
            sta DATALN+1
            sta DATAD
            rts

X_END       jsr SAVSTOPLN
RUNEND      jmp SNX1

X_IF        jsr EXEXPR
            ldx ARSLVL
            lda ARGSTK1,X
            beq IF_FALSE
            ldx STINDEX
.if .not .def tb_fixes
            ; BUG: This INX is not necessary, as STINDEX already points to NXTSTD.
            inx
.endif
            cpx NXTSTD
            bcs X_ENDIF
            jmp X_GOTO
IF_FALSE    ldy STINDEX
            dey
            lda (STMCUR),Y
            cmp #CTHEN
            beq IF_SKP_EOL
X_ELSE      lda #TOK_IF
            ldx #TOK_ENDIF
            ldy #TOK_ELSE
            jmp SKIP_ELSE
IF_SKP_EOL  lda LLNGTH
            sta NXTSTD
X_ENDIF     rts

X_FB        lda (STMCUR),Y
            eor #CMINUS
            sta F_BRK
            rts

F_BRK       .byte $00

CHK_BRK     lda #$80
            sta BRKKEY
            ldy F_BRK
            beq X_STOP
            jmp SERROR

X_STOP      jsr SAVSTOPLN
            jsr PUTEOL
            lda #<STOPPED
            sta SCRADR
            lda #>STOPPED
            sta SCRADR+1
            jsr P_STRB
            jmp ERR_PLNUM

            ; Save stopped line number
SAVSTOPLN   ldy #$01
            lda (STMCUR),Y
            bmi SETDZ
            sta STOPLN+1
            dey
            lda (STMCUR),Y
            sta STOPLN
SETDZ       ; Set device #0 as LIST/ENTER devices
            lda #$00
            sta ENTDTD
            sta L00B5
            rts
STOPPED     .cb 'STOPPED '

X_CONT      ldy #$01
            lda (STMCUR),Y
            bpl SETDZ
            lda STOPLN
            sta TSLNUM
            lda STOPLN+1
            sta TSLNUM+1
            jsr SEARCHLINE
            ldy #$02
            lda (STMCUR),Y
            sta LLNGTH
            pla
            pla
            jmp NEXT_LINE

X_TRAP      jsr GT_LBLNUM
            sta TRAPLN
            sty TRAPLN+1
            rts

X_ON        sty L00B3
            jsr GETFP
            jsr T_FPI
            bcs RTS_2A
            lda FR0+1
            bne RTS_2A
            lda FR0
            beq RTS_2A
            sta ERRNUM  ; Reuse ERRNUM to store ON target
            ldy STINDEX
            dey
            lda (STMCUR),Y
            pha
LF61E       dec ERRNUM
            beq LF62B
            jsr SKPCTOK
            cpx #CCOM
            beq LF61E
            pla
RTS_2A      rts
LF62B       pla
            cmp #CEXEC
            beq LF649
            cmp #CGOG
            beq LF651
            pha
            jsr GETUINT
            pla
            cmp #CGTO
            beq LF642
            lda #TOK_ON
            jsr X_GS1
LF642       lda FR0
            ldy FR0+1
            jmp GTO_LINE
LF649       lda #TOK_ENDPROC ; Used to signal "ON * EXEC"
            jsr X_GS1
            jmp GTO_EXEC
LF651       jmp X_GO_S

REXPAND     sta ECSIZE
            clc
            lda TOPRSTK
            sta TEMPA
            adc ECSIZE
            tay
            lda TOPRSTK+1
            sta TEMPA+1
            adc #$00
            cmp MEMTOP+1
            bcc LF672
            bne ERR_2
            cpy MEMTOP
            bcc LF672
            bne ERR_2
LF672       sta TOPRSTK+1
            sta APPMHI+1
            sty TOPRSTK
            sty APPMHI
            rts

ERR_2       lda #$02
            jmp SERROR

MV6RS       lda FR0
            sta (TEMPA),Y
            iny
            lda FR0+1
            sta (TEMPA),Y
            iny
            lda FR0+2
            sta (TEMPA),Y
            iny
            lda FR0+3
            sta (TEMPA),Y
            iny
            lda FR0+4
            sta (TEMPA),Y
            iny
            lda FR0+5
            sta (TEMPA),Y
            rts

RSTPTR      lda STARP
            sta RUNSTK
            sta TOPRSTK
            sta APPMHI
            lda STARP+1
            sta RUNSTK+1
            sta TOPRSTK+1
            sta APPMHI+1
            rts

ZVAR        ldx VVTP
            stx ZTEMP1
            ldy VVTP+1
            sty ZTEMP1+1
LF6B7       ldx ZTEMP1
            cpx ENDVVT
            lda ZTEMP1+1
            sbc ENDVVT+1
            bcs LF6E4
            ldy #$00
            lda (ZTEMP1),Y
            and #$FC
            sta (ZTEMP1),Y
            ldy #$02
            ldx #$06
            lda #$00
LF6CF       sta (ZTEMP1),Y
            iny
            dex
            bne LF6CF
            lda ZTEMP1
            clc
            adc #$08
            sta ZTEMP1
            lda ZTEMP1+1
            adc #$00
            sta ZTEMP1+1
            bne LF6B7
LF6E4       jmp GEN_LNHASH

RUNINIT     ldy #$00
            sty STOPLN
            sty STOPLN+1
            sty ERRNUM
            sty DEGFLAG
            sty DATAD
            sty DATALN
            sty DATALN+1
            dey
            sty TRAPLN+1
            sty BRKKEY
            jmp CLSALL

X_FF        lda (STMCUR),Y
            eor #CMINUS
            sta F_FOR
            rts

F_FOR       .byte $00

; Skip until a statement:
;  X = statement to search
;  A = statement that increases the search count (loop of above)
;  Y = ELSE statement if searching ENDIF
SKIP_STMT   ldy #$FF
SKIP_ELSE   stx SKP_SEARCH+1
            sta SKP_INCR+1
            sty SKP_ELSE+1
            lda #$00
            sta FR0+3
            lda STMCUR
            sta SAVCUR
            lda STMCUR+1
            sta SAVCUR+1
SKP_LOOP    ldy NXTSTD
            cpy LLNGTH
            bcs LF762
            lda (STMCUR),Y
            sta NXTSTD
            iny
            lda (STMCUR),Y
            iny
            sty STINDEX
SKP_SEARCH  cmp #$00
            beq LF740
SKP_INCR    cmp #$00
            beq LF749
SKP_ELSE    cmp #$00
            bne SKP_LOOP
            lda FR0+3
            bne SKP_LOOP
SKP_RTS     rts
LF740       lda FR0+3
            beq SKP_RTS
            dec FR0+3
            jmp SKP_LOOP
LF749       cmp #$07
            bne @+
            ldy NXTSTD
            dey
            lda (STMCUR),Y
            cmp #CTHEN
            beq SKP_LOOP
@           inc FR0+3
            bne SKP_LOOP
SKP_ERR     jsr RESCUR
ERR_22      lda #$16
            jmp SERROR
LF762       ldy #$01
            lda (STMCUR),Y
            bmi SKP_ERR
            clc
            lda LLNGTH
            adc STMCUR
            sta STMCUR
            bcc @+
            inc STMCUR+1
@           ldy #$01
            lda (STMCUR),Y
            bmi SKP_ERR
            iny
            lda (STMCUR),Y
            sta LLNGTH
            iny
            sty NXTSTD
            jmp SKP_LOOP

X_WHILE     jsr X_GS
            jsr EXEXPR
            ldx ARSLVL
            lda ARGSTK1,X
            bne RTS_UNTIL
            jsr X_POP
            lda #TOK_WHILE
            ldx #TOK_WEND
            jmp SKIP_STMT

X_UNTIL     jsr EXEXPR
            jsr X_POP
            bcs ERR_23
            cmp #TOK_REPEAT
            bne ERR_22
            ldx ARSLVL
            ldy ARGSTK1,X
            bne RTS_UNTIL
            lda #$04
            jsr RCONT
            lda #TOK_REPEAT
            jmp RETURN
RTS_UNTIL   rts

X_WEND      jsr X_POP
            bcs ERR_24
            cmp #TOK_WHILE
            bne ERR_22
            jsr RETURN
            ldy L00B2
            dey
            sty NXTSTD
            rts

ERR_23      lda #$17
            .byte $2C   ; Skip 2 bytes
ERR_24      lda #$18
            jmp SERROR

X_POP       lda RUNSTK+1
            cmp TOPRSTK+1
            bcc @+
            lda RUNSTK
            cmp TOPRSTK
            bcs RTS1_SEC
@           sec
            lda TOPRSTK
            sbc #$04
            sta TOPRSTK
            sta APPMHI
            bcs @+
            dec TOPRSTK+1
            dec APPMHI+1
@           ldy #$03
            lda (TOPRSTK),Y
            sta L00B2
            dey
            lda (TOPRSTK),Y
            sta TSLNUM+1
            dey
            lda (TOPRSTK),Y
            sta TSLNUM
            dey
            lda (TOPRSTK),Y
            bne RTS1_CLC
            tay
            sec
            lda TOPRSTK
            sbc #$0D
            sta TOPRSTK
            sta APPMHI
            bcs @+
            dec TOPRSTK+1
            dec APPMHI+1
@           tya
RTS1_CLC    clc
            rts
RTS1_SEC    sec
            rts

X_RETURN    jsr X_POP
            bcs ERR_16
            cmp #TOK_GOSUB
            beq RETURN
            cmp #TOK_ON
            beq RETURN
            cmp #TOK_EXEC
            bne X_RETURN
            beq ERR_16

RETURN      ldy L00B2
            cmp (L00A0),Y
            bne ERR_15
            lda L00A0+1
            beq ERR_15
            sta STMCUR+1
            lda L00A0
            sta STMCUR
            dey
            lda (STMCUR),Y
            sta NXTSTD
            ldy #$02
            lda (STMCUR),Y
            sta LLNGTH
            rts

ERR_15      lda #$0F
            .byte $2C   ; Skip 2 bytes
ERR_16      lda #$10
            .byte $2C   ; Skip 2 bytes
ERR_26      lda #$1A
            jmp SERROR

X_EXIT      jsr X_POP
            bcs ERR_26
            bne @+
            lda #TOK_FOR
@           tax
            inx ; Search "NEXT" if "FOR", "WEND" if "WHILE", "LOOP" if "DO",
                ; "UNTIL" if "REPEAT"
            jmp SKIP_STMT

RET_ON_EXEC lda #TOK_ON
            bne RETURN

X_ENDPROC   jsr X_POP
            bcs ERR_28
            cmp #TOK_EXEC
            beq RETURN
            cmp #TOK_ENDPROC ; Used to signal "ON * EXEC"
            beq RET_ON_EXEC
            cmp #TOK_ON
            beq ERR_28
            cmp #TOK_GOSUB
            bne X_ENDPROC
            ; BUG: This should fall-through to ERR_28, instead it generates "ERROR 104"
ERR_LABEL   sec
            sbc #$A4    ; Generate ERROR from label type, $C1 -> ERR-29, $C2 -> ERR-30
            .byte $2C   ; Skip 2 bytes
ERR_28      lda #$1C
            jmp SERROR

X_EXEC      jsr X_GS
GTO_EXEC    ldx #EVLABEL + EVL_EXEC
GTO_LABEL   ldy STINDEX
            lda (STMCUR),Y
            bne LF890
            iny
            lda (STMCUR),Y
LF890       eor #$80
            jsr VAR_PTR
            txa
            cmp (WVVTPT),Y
            bne ERR_LABEL
            ldy #$03
            lda (WVVTPT),Y
            sta STMCUR+1
            dey
            lda (WVVTPT),Y
            sta STMCUR
            lda (STMCUR),Y
            sta LLNGTH
            iny
            lda (STMCUR),Y
            sta NXTSTD
            rts

X_GO_S      ldx #EVLABEL + EVL_GOS
            bne GTO_LABEL

ERR_27      lda #$1B
            .byte $2C   ; Skip 2 bytes
ERR_25      lda #$19
            jmp SERROR

X_LOOP      jsr X_POP
            bcs ERR_25
            cmp #TOK_DO
            bne ERR_22B
            lda #$04
            jsr RCONT
            lda #TOK_DO
            jmp RETURN
ERR_22B     jmp ERR_22

ERR_21      lda #$15
            .byte $2C   ; Skip 2 bytes
ERR_19      lda #$13
            .byte $2C   ; Skip 2 bytes
ERR_18      lda #$12
            .byte $2C   ; Skip 2 bytes
X_ERROR     lda #$11
SERROR      ; Set error number and handle
            sta ERRNUM
ERROR       lda #$00
            cld
            sta DSPFLG
            jsr SAVSTOPLN
            ldy TRAPLN+1
            bmi ERR_NOTRAP
            lda TRAPLN
            ldx #$80
            stx TRAPLN+1
            ldx ERRNUM
            stx ERRSAVE
            ldx #$00
            stx ERRNUM
            jmp GTO_LINE

ERR_NOTRAP  lda ERRNUM          ; ERRM1 in BASIC sources
            cmp #$80
            bne ERR_PRINT
            jmp X_STOP
ERR_PRINT   jsr PUTEOL
            lda #TOK_ERROR
            jsr IPRINTSTMT
            ldx ERRNUM
            lda #$00
            jsr PUT_AX
            lda ERRNUM
            cmp #$1F            ; Last TBXL error is 30 ($1E)
            bcc @+
            sbc #$62            ; I/O error, subtract the gap
@           sta L00AF
            cmp #$4C            ; We know 76 errors in the table
            bcs ERR_PLNUM
            ldx #$00
            lda #>ERRTAB
            ldy #<ERRTAB
            jsr STR_TABN
            jsr P_SPCSTR        ; Print SPC + string + SPC
ERR_PLNUM   ldy #$01            ; ERRM2 in BASIC sources
            lda (STMCUR),Y
            bmi ERR_NOLN
            lda #<ERRTAB
            ldy #>ERRTAB
            jsr P_STRB_AY
            ldy #$01
            lda (STMCUR),Y
            sta FR0+1
            dey
            lda (STMCUR),Y
            sta FR0
            jsr PUT_INT
ERR_NOLN    jsr PUTEOL          ; ERRDONE in BASIC sources
            jsr TRACE_OFF
            jmp SYN_START

PUT_AX      sta FR0+1
            stx FR0
PUT_INT     jsr T_IFP
PUT_FP      jsr T_FASC
PUT_INBUF   lda INBUFF
            ldy INBUFF+1
P_STRB_AY   sta SCRADR
            sty SCRADR+1
            jmp P_STRB

ERRTAB
           .cb ' AT LINE '
           .cb '?BLOAD'
           .cb 'MEM'
           .cb 'VALUE'
           .cb '>#VARS'
           .cb '$LEN'
           .cb '?DATA'
           .cb '>32767'
           .cb 'INPUT'
           .cb 'DIM'
           .cb 'STACK'
           .cb 'OVERFLOW'
           .cb '?LINE'
           .cb '?FOR'
           .cb 'TOO LONG'
           .cb '?DEL'
           .cb '?GOSUB'
           .cb 'GARBAGE'
           .cb '?CHR'
           .cb 'MEM'
           .cb '#'
           .cb '?LOAD'
           .cb '?NEST'
           .cb '?WHILE'
           .cb '?REPEAT'
           .cb '?DO'
           .cb '?EXIT'
           .cb 'XPROC'
           .cb '?EXEC'
           .cb '?PROC'
           .cb '?#'
           .cb 'IS OPEN'
           .cb '?DEV'
           .cb 'WR ONLY'
           .cb 'CMD'
           .cb 'NOT OPEN'
           .cb '#'
           .cb 'RD ONLY'
           .cb 'EOF'
           .cb 'TRUNC'
           .cb 'TIMEOUT'
           .cb 'NAK'
           .cb '!FRAME'
           .cb 'CURSOR'
           .cb '!OVERRUN'
           .cb 'CHKSUM'
           .cb 'DONE'
           .cb 'MODE'
           .cb 'NOT IMPL'
           .cb 'RAM'
           .cb ' '
           .cb ' '
           .cb ' '
           .cb ' '
           .cb ' '
           .cb ' '
           .cb ' '
           .cb ' '
           .cb ' '
           .cb ' '
           .cb ' '
           .cb ' '
           .cb 'D?:'
           .cb '>#FILES'
           .cb 'DSK FULL'
           .cb 'FATAL I/O'
           .cb 'FILE#'
           .cb 'NAME'
           .cb 'POINT'
           .cb 'LOCKED'
           .cb 'DCMD'
           .cb '>DIR'
           .cb '?FILE'
           .cb 'POINT'
           .cb '?APPND'
           .cb 'BAD SECTORS'

X_TIME      lda RTCLOK+2
            ldy RTCLOK+1
            ldx RTCLOK
            cmp RTCLOK+2
            bne X_TIME
            pha
            stx FR0+1
            sty FR0
            jsr T_IFP
            ldx #$05
@           lda FP_256,X
            sta FR1,X
            dex
            bpl @-
            jsr T_FMUL
            jsr T_FMOVE
            pla
            sta FR0
            lda #$00
            sta FR0+1
            jsr T_IFP
            jsr T_FADD
            lda #$00
            sta VTYPE
            sta VNUM
            jmp X_PUSHVAL

X_TIMEP     jsr X_TIME
            dec ARSLVL
            ldx #$05
@           lda JF_DAY,X
            sta FR1,X
            dex
            bpl @-
            jsr T_FDIV
            ldy #$00
            lda FR0
            cmp #$40
            bne @+
            sty FR0+1
@           sty CIX
            lda #$24
            jsr TM_EXTRACT
            lda #$60
            jsr TM_EXTRACT
            lda #$60
            jsr TM_EXTRACT
            ldy #$06
            lda #<LBUFF
            jmp RET_STR_A

TM_EXTRACT  pha
            jsr NORMALIZE
            jsr T_FMOVE
            jsr T_FLD1
            pla
            sta FR0+1
            jsr T_FMUL
            lda #$00
            ldy FR0
            cpy #$40
            bne @+
            ldy FR0+1
            sta FR0+1
            tya
@           tax
            lsr
            lsr
            lsr
            lsr
            jsr TM_GETDIG
            txa
            and #$0F
TM_GETDIG   ora #'0'
            cmp #'9'+1
            bcc @+
            adc #'A'-'9' - 2
@           ldy CIX
            sta LBUFF,Y
            inc CIX
            rts
FP_256      .fl 256
JF_DAY      .fl 4320000 ; A day in jiffies: 50Hz * 60 * 60 * 24

X_TIMESET   jsr EXEXPR
            jsr SETSEOL
            ldy #$00
            sty CIX
            sty FR1+1
            sty FR1+2
            jsr TS_GET2DIG      ; Get HOURS
            cmp #24
            bcs TS_ERR18
            sta FR1
            jsr TS_MUL60
            jsr TS_GET2DIG      ; Get MINUTES
            cmp #60
            bcs TS_ERR18
            jsr TS_ADD
            jsr TS_MUL60
            jsr TS_GET2DIG      ; Get SECONDS
            cmp #60
            bcs TS_ERR18
            jsr TS_ADD
            jsr TS_MUL5         ; Multiply by 5*10 = 50 (PAL)
            jsr TS_MUL10
            lda FR1
            ldy FR1+1
            ldx FR1+2
@           sta RTCLOK+2        ; Write and retry until stable
            sty RTCLOK+1
            stx RTCLOK
            cmp RTCLOK+2
            bne @-
            jmp RSTSEOL
TS_ERR18    jsr RSTSEOL
            jmp ERR_18
TS_GET2DIG  jsr T_GETDIGIT
            inc CIX
            bcs TS_ERR18
            asl
            sta FR1+3
            asl
            asl
            adc FR1+3
            sta FR1+3
            jsr T_GETDIGIT
            inc CIX
            bcs TS_ERR18
            adc FR1+3
            rts
TS_ADD      clc
            adc FR1
            sta FR1
            bcc @+
            inc FR1+1
            bne @+
            inc FR1+2
@           rts
TS_MUL10    asl FR1
            rol FR1+1
            rol FR1+2   ; *2
TS_MUL5     ldy FR1+2
            lda FR1
            ldx FR1+1
            asl FR1
            rol FR1+1
            rol FR1+2   ; *4
            asl FR1
            rol FR1+1
            rol FR1+2   ; *8
            adc FR1
            sta FR1
            txa
            adc FR1+1
            sta FR1+1
            tya
            adc FR1+2
            sta FR1+2   ; *10
            rts
TS_MUL60    jsr TS_MUL10; *10
            ldy FR1+2
            lda FR1
            ldx FR1+1
            asl FR1
            rol FR1+1
            rol FR1+2   ; *20
            adc FR1
            sta FR1
            txa
            adc FR1+1
            sta FR1+1
            tya
            adc FR1+2   ; *30
            asl FR1
            rol FR1+1
            rol
            sta FR1+2   ; *60
.if .not .def tb_fixes
            rts         ; Remove extra RTS
.endif
TS_RTS      rts


FNTPTR = MVLNG  ; Use MVLNG as font pointer

X_TEXT      jsr GET2INT
            sta L0099
            bne TS_RTS
            jsr EXEXPR
            ldx ARSLVL
            lda VARSTK0,X
            bmi @+
            ; Convert number to string
            jsr X_STRP
@           jsr X_POPSTR
TXT_NXTCH   lda FR0+2
            ora FR0+3
            beq TS_RTS
            ldy #$00
            sty L00DB
            sty L00DC
            lda (FR0),Y
            bpl @+
            dec L00DB
@           jsr ATA2SCR
            asl
            asl
            sta FNTPTR
            lda #$00
            rol
            asl FNTPTR
            rol
            adc CHBAS
            sta FNTPTR+1
            jsr PREPLOT
            bcs TS_RTS
            ; Plot one row of the character
TXT_NROW    ldy #$08
            sty L00DD
            ldy L00DC
            lda (FNTPTR),Y
            eor L00DB
            sta L00DA
            ldx L00ED
            ldy FR1+3
TXT_NCOL    asl L00DA
            lda (L00DE),Y
            and PLOT_MASK,X
            bcc @+
            ora PLOT_PIX,X
@           sta (L00DE),Y
            dec L00DD
            beq TXT_ECOL
            jsr PLOT_ICOL
            cpy FR1+1
            bcc TXT_NCOL
            ; End of column, increment row
TXT_ECOL    jsr PLOT_IROW2
            inc L00DC
            lda L00DC
            cmp #$08
            bcs @+
            adc L0099
            cmp FR1
            bcc TXT_NROW
            ; Next character
@           lda L009B
            adc #$07
            sta L009B
            bcc @+
            inc L009C
@           inc FR0
            bne @+
            inc FR0+1
@           lda FR0+2
            bne @+
            dec FR0+3
@           dec FR0+2
            jmp TXT_NXTCH

            ; Transform ATASCII to screen code
ATASCR_T    .byte $40,$20,$60,$00

ATA2SCR     tay
            asl
            asl
            rol
            rol
            and #$03
            tax
            tya
            eor ATASCR_T,X
            rts

GR_ROWS     .byte $18,$18,$0C,$18,$30,$30,$60,$60
            .byte $C0,$C0,$C0,$C0,$18,$0C,$C0,$C0
GR_STRIDE   .byte $28,$14,$14,$0A,$0A,$14,$14,$28
            .byte $28,$28,$28,$28,$28,$28,$14,$28
GR_COLRS    .byte $00,$00,$00,$02,$03,$02,$03,$02
            .byte $03,$01,$01,$01,$00,$00,$03,$02
GR_PPBYTE   .byte $00,$01,$03,$07
GR_MASK     .byte $00,$F0,$FC,$FE
GR_BPP      .byte $04,$02,$01

RTS_SEC     sec
            rts

            ; Fill tables for fast PLOT
            ;
            ; INPUT:
            ;   L0099 : plot row
            ;   L009B : plot column (lo)
            ;   L008C :             (hi)
            ;   COLOR : color to use (OS variable)
            ;   DINDEX: current graphics mode (OS variable)
            ;
            ; OUTPUT:
            ;   carry    : set on error
            ;   PLOT_PIX : table of bytes to plot the pixel (OR-ed to the screen)
            ;   PLOT_MASK: table of masks to plot (AND-ed to the screen)
            ;   L00DE    : pointer to screen byte at start of row
            ;   FR1+3    : byte to plot in the line
            ;   L00ED    : index into PLOT_PIX/PLOT_MASK table for current point
            ;
PREPLOT     lda DINDEX
            and #$0F
            tax
            lda #$00
            sta L00DF
            lda L0099
            asl
            rol L00DF
            asl
            rol L00DF
            adc L0099
            bcc @+
            inc L00DF
@           asl
            sta L00DE
            rol L00DF
            lda GR_ROWS,X
            sta FR1
            cmp L0099
            beq RTS_SEC
            bcc RTS_SEC
            ldy GR_COLRS,X
            sty FR1+2
            lda GR_MASK,Y
            sta PLOT_MASK
            lda GR_STRIDE,X
            sta FR1+1
            lsr
            lsr
            lsr
            lsr
            tax
            beq PP_SKIP
@           asl L00DE
            rol L00DF
            dex
            bne @-
PP_SKIP     clc
            lda L00DE
            adc SAVMSC
            sta L00DE
            lda L00DF
            adc SAVMSC+1
            sta L00DF
            lda L009C
            sta FR1+4
            lda L009B
            sta FR1+3
            ldy FR1+2
            sty L00ED
            beq PP_SKIP2
            and GR_PPBYTE,Y
            sta L00ED
@           lsr FR1+4
            ror FR1+3
            dey
            bne @-
PP_SKIP2    lda FR1+4
            bne RTS_SEC
            lda FR1+3
            cmp FR1+1
            bcs RTS_SEC
            ldx FR1+2
            bne PP_NTEXT
            ; Text modes, convert to screen code
            lda COLOR
            jsr ATA2SCR
            sta PLOT_PIX
            clc
            rts

            ; Graphics mode, get masks
PP_NTEXT    ldy GR_PPBYTE,X
            sty FR1+4
            lda GR_BPP-1,X
            sta L00EE
            lda COLOR
            ora PLOT_MASK
            eor PLOT_MASK
PP_PIXLOOP  sta PLOT_PIX,Y
            ldx L00EE
@           asl
            dex
            bne @-
            dey
            bpl PP_PIXLOOP
            ldy FR1+4
            lda PLOT_MASK
PP_MSKLOOP  sta PLOT_MASK,Y
            ldx L00EE
@           sec
            rol
            dex
            bne @-
            dey
            bpl PP_MSKLOOP
            clc
PP_RTS      rts

            ; PAINT (flood fill)
            ; NOTE:
            ;   Fills complete horizontal lines, storing a list of pixel spans in
            ;   a buffer indexed by PNTSTK, initialized to the top of the return
            ;   stack, up to MEMTOP.
            ;   Each span is stored in 3 bytes, as expanded column:
            ;     0: left byte ($00 to $7F), bit 7 = direction (up/down)
            ;     1: bit 3-5: left pos
            ;        but 0-2: right pos
            ;     2: right byte ($00 to $7F)
            ;
PNTSTK = MVLNG  ; Use MVLNG as Paint Stack Pointer

X_PAINT     jsr GET2INT
            sta L0099
            bne PP_RTS
            jsr PREPLOT
            bcs PP_RTS
            lda TOPRSTK
            sta PNTSTK
            lda TOPRSTK+1
            sta PNTSTK+1
            lda MEMTOP
            sbc #$06
            sta L00E7
            lda MEMTOP+1
            sbc #$00
            sta L00E8
            ; Paint next span
PAINT_NXT   clc
            lda PNTSTK
            adc #$03
            sta PNTSTK
            bcc @+
            inc PNTSTK+1
@           cmp L00E7
            lda PNTSTK+1
            sbc L00E8
            bcc @+
            jmp ERR_2   ; Not enough memory for the next span
@           ldx L00ED
            ldy FR1+3
            jsr PLOT_GET
            beq @+
            jmp PAINT_ESPN
            ; Plot all possible points to the left
@           jsr PLOT_SET
PLOT_LNXT   jsr PLOT_DCOL
            tya
            bmi PLOT_LEND
            jsr PLOT_GET
            bne PLOT_LEND
            jsr PLOT_SET
            jmp PLOT_LNXT
            ; Store last point to the left
PLOT_LEND   jsr PLOT_ICOL
            tya
            ldy #$00
            sta (PNTSTK),Y
            txa
            asl
            asl
            asl
            iny
            sta (PNTSTK),Y
            ; Plot all possible points to the right
            ldy FR1+3
            ldx L00ED
PLOT_RNXT   jsr PLOT_ICOL
            cpy FR1+1
            bcs PLOT_REND
            jsr PLOT_GET
            bne PLOT_REND
            jsr PLOT_SET
            jmp PLOT_RNXT
            ; Store last point to the right
PLOT_REND   jsr PLOT_DCOL
            tya
            ldy #$02
            sta (PNTSTK),Y
            txa
            dey
            ora (PNTSTK),Y
            sta (PNTSTK),Y
            ; Test pixels in the next row (from current span)
            ldy L0099
            iny
            cpy FR1
            bcs LFE85
            jsr PLOT_IROW
            ; Start from left span coordinate
            jsr PAINT_GETL
PAINT_SPDN  ; Check if we have more pixels in the span to test DOWN
            ldy #$01
            lda (PNTSTK),Y
            and #$07
            cmp L00ED
            iny
            lda (PNTSTK),Y
            sbc FR1+3
            bcc LFE82
            ldy #$00
            lda (PNTSTK),Y
            ora #$80
LFE7D       sta (PNTSTK),Y
            jmp PAINT_NXT
LFE82       jsr PLOT_DROW
            ; Test pixels in prev row (from current span)
LFE85       ldy L0099
            dey
            cpy FR1
            bcs LFEAC
            jsr PLOT_DROW
            ; Start from left span coordinate
            jsr PAINT_GETL
PAINT_SPUP  ; Check if we have more pixels in the span to test UP
            ldy #$01
            lda (PNTSTK),Y
            and #$07
            cmp L00ED
            iny
            lda (PNTSTK),Y
            sbc FR1+3
            bcc @+
            ldy #$00
            lda (PNTSTK),Y
            and #$7F
            bpl LFE7D
@           jsr PLOT_IROW
LFEAC       ldy #$01
            lda (PNTSTK),Y
            and #$07
            tax
            iny
            lda (PNTSTK),Y
            tay
            // Ensure that we are outside span, we tested all
            jsr PLOT_ICOL
            ; End current span, continue from next pixel on old span
PAINT_ESPN  jsr PLOT_ICOL
            stx L00ED
            sty FR1+3
            sec
            lda PNTSTK
            sbc #$03
            sta PNTSTK
            bcs @+
            dec PNTSTK+1
@           cmp TOPRSTK
            bne @+
            lda PNTSTK+1
            cmp TOPRSTK+1
            beq PAINT_RTS
@           ldy #$00
            lda (PNTSTK),Y
            bpl PAINT_SPUP
            bmi PAINT_SPDN

            ; Increment plot row
PLOT_IROW   inc L0099
PLOT_IROW2  clc
            lda L00DE
            adc FR1+1
            sta L00DE
            bcc PAINT_RTS
            inc L00DF
PAINT_RTS   rts
            ; Decrement plot row
PLOT_DROW   dec L0099
            sec
            lda L00DE
            sbc FR1+1
            sta L00DE
            bcs @+
            dec L00DF
@           rts
            ; Read left pixel from span list
PAINT_GETL  ldy #$00
            lda (PNTSTK),Y
            and #$7F
            sta FR1+3
            iny
            lda (PNTSTK),Y
            lsr
            lsr
            lsr
            sta L00ED
            rts
            ; Increment plot column
PLOT_ICOL   cpx FR1+4
            inx
            bcc @+
            ldx #$00
            iny
@           rts
            ; Decrement plot column
PLOT_DCOL   dex
            bpl @+
            ldx FR1+4
            dey
@           rts
            ; Plots a pixel at current coordinates
PLOT_SET    lda (L00DE),Y
            and PLOT_MASK,X
            ora PLOT_PIX,X
            sta (L00DE),Y
            rts
            ; Get pixel value at current coordinates
PLOT_GET    lda (L00DE),Y
            ora PLOT_MASK,X
            eor PLOT_MASK,X
            beq @+
            lda PLOT_PIX
            rts
@           lda PLOT_PIX
            beq @+
            lda #$00
            rts
@           lda #$01
            rts

X_CLS       jsr CLEAR_XYPOS
            lda DSPFLG
            pha
            stx DSPFLG
            jsr CHKIOCHAN
            ldy #$7D
            jsr PRCX
            pla
            sta DSPFLG
            jmp CIOERR_Y

X_TRACE     lda (STMCUR),Y
            cmp #TOK_STOP
            beq TRACE_OFF
            lda #{JMP}      ; JMP DO_TRACE
            ldx #<DO_TRACE
            ldy #>DO_TRACE
            bne PATCH_EXECNL
TRACE_OFF   lda #{LDY #2}   ; LDY #02
            ldx #$02
            ldy #{LDA (0),Y}; LDA (STMCUR),Y
PATCH_EXECNL
            sta EXECNL      ; Patch instruction
            stx EXECNL+1
            sty EXECNL+2
            rts

DO_TRACE    lda #'['
            jsr PUTCHAR
            ldy #$00
            lda (STMCUR),Y
            tax
            iny
            lda (STMCUR),Y
            jsr PUT_AX
            lda #']'
            jsr PUTCHAR
            ; This is the first instructions of EXECNL, replaced
            ; with the JMP to the trace code.
            ldy #$02
            lda (STMCUR),Y
            jmp EXECNT

ERRLNUM     jsr RESCUR
            lda #$0C
            jmp SERROR

X_GOSUB     jsr X_GS    ; Save return address and skip to X_GOTO

X_GOTO      jsr GETUINT
GTO_LINE    sta TSLNUM
            sty TSLNUM+1
            jsr SEARCHLINE
            bcs ERRLNUM
            pla
            pla
            lda BRKKEY
            beq CHK_BRK_

; Execute new line
; NOTE: you can't change the first two instructions without changing
;       TRACE_ON / TRACE_OFF, because the first 3 bytes are overwritten
;       with a JMP to DO_TRACE.
EXECNL      ldy #$02
            lda (STMCUR),Y
; Continue execution after trace
EXECNT      sta LLNGTH
            iny
; Execute new statement
EXECNS      cpy LLNGTH
            bcs NEXT_LINE
            lda (STMCUR),Y
            sta NXTSTD
            iny
            lda (STMCUR),Y
            iny
            sty STINDEX
            jsr EXE_STMT
            ldy NXTSTD
            lda BRKKEY
            bne EXECNS
CHK_BRK_    jmp CHK_BRK

EXE_STMT    asl
            sta JUMP_STMT+1
JUMP_STMT   jmp (STMT_X_TAB)

; Execute next line, or return to parsing if not more lines
NEXT_LINE   ldy #$01
            lda (STMCUR),Y
            bmi SYN_PROMPT_
            clc
            lda LLNGTH
            adc STMCUR
            sta STMCUR
            bcc @+
            inc STMCUR+1
@           lda (STMCUR),Y
            bpl EXECNL
            jmp X_END

SYN_PROMPT_ jmp SNX3
;
        @SEGMENT_SIZE TB_SEGMENT_6 $FFFA

; vi:syntax=mads
