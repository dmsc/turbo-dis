;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                            ;;
;; TurboBasic XL v1.5 disassembly, in MADS format.            ;;
;;                                                            ;;
;; Disassembled and translated to MADS by dmsc.               ;;
;;                                                            ;;
;; Version 2017-06-11                                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; This disassembly is based on the published TurboBasic XL binaries,
; and should be public-domain by now.
;


;
; System equates
;
; OS EQUATES
; ----------
;
; IO EQUATES
;
ICHID       = $0000
ICDNO       = $0001
ICCOM       = $0002
ICSTA       = $0003
ICBAL       = $0004
ICBAH       = $0005
ICPTL       = $0006
ICPTH       = $0007
ICBLL       = $0008
ICBLH       = $0009
ICAX1       = $000A
ICAX2       = $000B
ICAX3       = $000C
ICAX4       = $000D
ICAX5       = $000E
ICAX6       = $000F
;
; IOCB Command Code Equates
;
ICOPEN    = $03           ;open
ICGETREC  = $05           ;get record
ICGETCHR  = $07           ;get character(s)
ICPUTREC  = $09           ;put record
ICPUTCHR  = $0B           ;put character(s)
ICCLOSE   = $0C           ;close
ICSTATIS  = $0D           ;status
ICSPECIL  = $0E           ;special
ICRENAME  = $20           ;rename disk file
ICDELETE  = $21           ;delete disk file
ICLOCKFL  = $23           ;lock file (set to read-only)
ICUNLOCK  = $24           ;unlock file
ICPOINT   = $25           ;point sector
ICNOTE    = $26           ;note sector
;
; DISPLAY LIST EQUATES
;
ADLI        = $0080
AVB         = $0040
ALMS        = $0040
AVSCR       = $0020
AHSCR       = $0010
AJMP        = $0001
AEMPTY1     = $0000
AEMPTY2     = $0010
AEMPTY3     = $0020
AEMPTY4     = $0030
AEMPTY5     = $0040
AEMPTY6     = $0050
AEMPTY7     = $0060
AEMPTY8     = $0070
;
; OS VARIABLES FOR XL/XE
;
; PAGE 0
;
NGFLAG      = $0001
CASINI      = $0002
RAMLO       = $0004
TRAMSZ      = $0006
CMCMD       = $0007
WARMST      = $0008
BOOT        = $0009
DOSVEC      = $000A
DOSINI      = $000C
APPMHI      = $000E
POKMSK      = $0010
BRKKEY      = $0011
RTCLOK      = $0012
BUFADR      = $0015
ICCOMT      = $0017
DSKFMS      = $0018
DSKUTL      = $001A
ABUFPT      = $001C
ICHIDZ      = $0020
ICDNOZ      = $0021
ICCOMZ      = $0022
ICSTAZ      = $0023
ICBALZ      = $0024
ICBAHZ      = $0025
ICPTLZ      = $0026
ICPTHZ      = $0027
ICBLLZ      = $0028
ICBLHZ      = $0029
ICAX1Z      = $002A
ICAX2Z      = $002B
ICAX3Z      = $002C
ICAX4Z      = $002D
ICAX5Z      = $002E
ICAX6Z      = $002F
STATUS      = $0030
CHKSUM      = $0031
BUFRLO      = $0032
BUFRHI      = $0033
BFENLO      = $0034
BFENHI      = $0035
LTEMP       = $0036
BUFRFL      = $0038
RECVDN      = $0039
XMTDON      = $003A
CHKSNT      = $003B
NOCKSM      = $003C
BPTR        = $003D
FTYPE       = $003E
FEOF        = $003F
FREQ        = $0040
SOUNDR      = $0041
CRITIC      = $0042
FMSZPG      = $0043
ZCHAIN      = $004A
DSTAT       = $004C
ATRACT      = $004D
DRKMSK      = $004E
COLRSH      = $004F
TEMP        = $0050
HOLD1       = $0051
LMARGN      = $0052
RMARGN      = $0053
ROWCRS      = $0054
COLCRS      = $0055
DINDEX      = $0057
SAVMSC      = $0058
OLDROW      = $005A
OLDCOL      = $005B
OLDCHR      = $005D
OLDADR      = $005E
FKDEF       = $0060
PALNTS      = $0062
LOGCOL      = $0063
ADRESS      = $0064
MLTTMP      = $0066
SAVADR      = $0068
RAMTOP      = $006A
BUFCNT      = $006B
BUFSTR      = $006C
BITMSK      = $006E
SHFAMT      = $006F
ROWAC       = $0070
COLAC       = $0072
ENDPT       = $0074
DELTAR      = $0076
DELTAC      = $0077
KEYDEF      = $0079
SWPFLG      = $007B
HOLDCH      = $007C
INSDAT      = $007D
COUNTR      = $007E
;
; PAGE 2
;
VDSLST      = $0200
VPRCED      = $0202
VINTER      = $0204
VBREAK      = $0206
VKEYBD      = $0208
VSERIN      = $020A
VSEROR      = $020C
VSEROC      = $020E
VTIMR1      = $0210
VTIMR2      = $0212
VTIMR4      = $0214
VIMIRQ      = $0216
CDTMV1      = $0218
CDTMV2      = $021A
CDTMV3      = $021C
CDTMV4      = $021E
CDTMV5      = $0220
VVBLKI      = $0222
VVBLKD      = $0224
CDTMA1      = $0226
CDTMA2      = $0228
CDTMF3      = $022A
SRTIMR      = $022B
CDTMF4      = $022C
INTEMP      = $022D
CDTMF5      = $022E
SDMCTL      = $022F
SDLSTL      = $0230
SDLSTH      = $0231
SSKCTL      = $0232
SPARE       = $0233
LPENH       = $0234
LPENV       = $0235
BRKKY       = $0236
VPIRQ       = $0238
CDEVIC      = $023A
CCOMND      = $023B
CAUX1       = $023C
CAUX2       = $023D
TMPSIO      = $023E
ERRFLG      = $023F
DFLAGS      = $0240
DBSECT      = $0241
BOOTAD      = $0242
COLDST      = $0244
RECLEN      = $0245
DSKTIM      = $0246
PDVMSK      = $0247
SHPDVS      = $0248
PDMSK       = $0249
RELADR      = $024A
PPTMPA      = $024C
PPTMPX      = $024D
CHSALT      = $026B
VSFLAG      = $026C
KEYDIS      = $026D
FINE        = $026E
GPRIOR      = $026F
PADDL0      = $0270
PADDL1      = $0271
PADDL2      = $0272
PADDL3      = $0273
PADDL4      = $0274
PADDL5      = $0275
PADDL6      = $0276
PADDL7      = $0277
STICK0      = $0278
STICK1      = $0279
STICK2      = $027A
STICK3      = $027B
PTRIG0      = $027C
PTRIG1      = $027D
PTRIG2      = $027E
PTRIG3      = $027F
PTRIG4      = $0280
PTRIG5      = $0281
PTRIG6      = $0282
PTRIG7      = $0283
STRIG0      = $0284
STRIG1      = $0285
STRIG2      = $0286
STRIG3      = $0287
HIBYTE      = $0288
WMODE       = $0289
BLIM        = $028A
IMASK       = $028B
JVECK       = $028C
NEWADR      = $028E
TXTROW      = $0290
TXTCOL      = $0291
TINDEX      = $0293
TXTMSC      = $0294
TXTOLD      = $0296
CRETRY      = $029C
HOLD3       = $029D
SUBTMP      = $029E
HOLD2       = $029F
DMASK       = $02A0
TMPLBT      = $02A1
ESCFLG      = $02A2
TABMAP      = $02A3
LOGMAP      = $02B2
INVFLG      = $02B6
FILFLG      = $02B7
TMPROW      = $02B8
TMPCOL      = $02B9
SCRFLG      = $02BB
HOLD4       = $02BC
DRETRY      = $02BD
SHFLOC      = $02BE
BOTSCR      = $02BF
PCOLR0      = $02C0
PCOLR1      = $02C1
PCOLR2      = $02C2
PCOLR3      = $02C3
COLOR0      = $02C4
COLOR1      = $02C5
COLOR2      = $02C6
COLOR3      = $02C7
COLOR4      = $02C8
RUNADR      = $02C9
HIUSED      = $02CB
ZHIUSE      = $02CD
GBYTEA      = $02CF
LOADAD      = $02D1
ZLOADA      = $02D3
DSCTLN      = $02D5
ACMISR      = $02D7
KRPDER      = $02D9
KEYREP      = $02DA
NOCLIK      = $02DB
HELPFG      = $02DC
DMASAV      = $02DD
PBPNT       = $02DE
PBUFSZ      = $02DF
RUNAD       = $02E0
INITAD      = $02E2
RAMSIZ      = $02E4
MEMTOP      = $02E5
MEMLO       = $02E7
HNDLOD      = $02E9
DVSTAT      = $02EA
CBAUDL      = $02EE
CBAUDH      = $02EF
CRSINH      = $02F0
KEYDEL      = $02F1
CH1         = $02F2
CHACT       = $02F3
CHBAS       = $02F4
NEWROW      = $02F5
NEWCOL      = $02F6
ROWINC      = $02F8
COLINC      = $02F9
CHAR        = $02FA
ATACHR      = $02FB
CH          = $02FC
FILDAT      = $02FD
DSPFLG      = $02FE
SSFLAG      = $02FF
;
; PAGE 3
;
DDEVIC      = $0300
DUNIT       = $0301
DCOMND      = $0302
DSTATS      = $0303
DBUFLO      = $0304
DBUFHI      = $0305
DTIMLO      = $0306
DUNUSE      = $0307
DBYTLO      = $0308
DBYTHI      = $0309
DAUX1       = $030A
DAUX2       = $030B
TIMER1      = $030C
ADDCOR      = $030E
CASFLG      = $030F
TIMER2      = $0310
TEMP1       = $0312
TEMP2       = $0314
TEMP3       = $0315
SAVIO       = $0316
TIMFLG      = $0317
STACKP      = $0318
TSTAT       = $0319
HATABS      = $031A
PUPBT1      = $033D
PUPBT2      = $033E
PUPBT3      = $033F
IOCB0       = $0340
IOCB1       = $0350
IOCB2       = $0360
IOCB3       = $0370
IOCB4       = $0380
IOCB5       = $0390
IOCB6       = $03A0
IOCB7       = $03B0
PRNBUF      = $03C0
SUPERF      = $03E8
CKEY        = $03E9
CASSBT      = $03EA
CARTCK      = $03EB
DERRF       = $03EC
ACMVAR      = $03ED
BASICF      = $03F8
MINTLK      = $03F9
GINTLK      = $03FA
CHLINK      = $03FB
CASBUF      = $03FD
;
; HARDWARE REGISTERS
;
; GTIA
;
M0PF        = $D000
HPOSP0      = $D000
M1PF        = $D001
HPOSP1      = $D001
M2PF        = $D002
HPOSP2      = $D002
M3PF        = $D003
HPOSP3      = $D003
P0PF        = $D004
HPOSM0      = $D004
P1PF        = $D005
HPOSM1      = $D005
P2PF        = $D006
HPOSM2      = $D006
P3PF        = $D007
HPOSM3      = $D007
M0PL        = $D008
SIZEP0      = $D008
M1PL        = $D009
SIZEP1      = $D009
M2PL        = $D00A
SIZEP2      = $D00A
M3PL        = $D00B
SIZEP3      = $D00B
P0PL        = $D00C
SIZEM       = $D00C
P1PL        = $D00D
GRAFP0      = $D00D
P2PL        = $D00E
GRAFP1      = $D00E
P3PL        = $D00F
GRAFP2      = $D00F
TRIG0       = $D010
GRAFP3      = $D010
TRIG1       = $D011
GRAFM       = $D011
TRIG2       = $D012
COLPM0      = $D012
TRIG3       = $D013
COLPM1      = $D013
PAL         = $D014
COLPM2      = $D014
COLPM3      = $D015
COLPF0      = $D016
COLPF1      = $D017
COLPF2      = $D018
COLPF3      = $D019
COLBK       = $D01A
PRIOR       = $D01B
VDELAY      = $D01C
GRACTL      = $D01D
HITCLR      = $D01E
CONSOL      = $D01F
;
; POKEY
;
POT0        = $D200
AUDF1       = $D200
POT1        = $D201
AUDC1       = $D201
POT2        = $D202
AUDF2       = $D202
POT3        = $D203
AUDC2       = $D203
POT4        = $D204
AUDF3       = $D204
POT5        = $D205
AUDC3       = $D205
POT6        = $D206
AUDF4       = $D206
POT7        = $D207
AUDC4       = $D207
ALLPOT      = $D208
AUDCTL      = $D208
KBCODE      = $D209
STIMER      = $D209
RANDOM      = $D20A
SKREST      = $D20A
POTGO       = $D20B
SERIN       = $D20D
SEROUT      = $D20D
IRQST       = $D20E
IRQEN       = $D20E
SKSTAT      = $D20F
SKCTL       = $D20F
;
; PIA
;
PORTA       = $D300
PORTB       = $D301
PACTL       = $D302
PBCTL       = $D303
;
; ANTIC
;
DMACLT      = $D400
CHACTL      = $D401
DLISTL      = $D402
DLISTH      = $D403
HSCROL      = $D404
VSCROL      = $D405
PMBASE      = $D407
CHBASE      = $D409
WSYNC       = $D40A
VCOUNT      = $D40B
PENH        = $D40C
PENV        = $D40D
NMIEN       = $D40E
NMIST       = $D40F
NMIRES      = $D40F
;
; FLOATING POINT ROUTINES
;
AFP         = $D800
FASC        = $D8E6
IFP         = $D9AA
FPI         = $D9D2
ZFR0        = $DA44
ZF1         = $DA46
FSUB        = $DA60
FADD        = $DA66
FMUL        = $DADB
FDIV        = $DB28
SKPSPC      = $DBA1
PLYEVL      = $DD40
FLD0R       = $DD89
FLD0P       = $DD8D
FLD1R       = $DD98
FLD1P       = $DD9C
FSTOR       = $DDA7
FSTOP       = $DDAB
FMOVE       = $DDB6
EXP         = $DDC0
EXP10       = $DDCC
LOG         = $DECD
LOG10       = $DED1
;
; BASIC FLOATING POINT TABLES
;
P10COF      = $DE4D
SQR10       = $DF66
LGCOEF      = $DF72
ATNCOEF     = $DFAE
FP9S        = $DFEA
FP_PI4      = $DFF0     ; PI/4
;
; ROM VECTORS
;
EDITRV      = $E400
KEYBDV      = $E420
DSKINV      = $E453
CIOV        = $E456
SIOV        = $E459
SETVBV      = $E45C
SYSVBV      = $E45F
XITVBV      = $E462
SIOINV      = $E465
SENDEV      = $E468
INTINV      = $E46B
CIOINV      = $E46E
SELFSV      = $E471
WARMSV      = $E474
COLDSV      = $E477
RBLOKV      = $E47A
CSOPIV      = $E47D
PUPDIV      = $E480
SELFTSV     = $E483
PENTV       = $E486
PHUNLV      = $E489
PHINIV      = $E48C
GPDVV       = $E48F
;
; User equates
;
CR          = $9B
INBUFF      = $F3
CIX         = $F2
FR1         = $E0
VTYPE       = $D2
VNUM        = $D3
FR0         = $D4
EPCHAR      = $5D ; Special char - used to recognize prompt
;
; Variable types
;
EVSTR       = $80
EVARRAY     = $40
EVLABEL     = $C0
EVSDTA      = $02
EVDIM       = $01
EVL_EXEC    = $01
EVL_GOS     = $02
;
; Code equates
;
LOMEM       = $80
OUTBUFF     = $80
VNTP        = $82
VNTD        = $84
VVTP        = $86
ENDVVT      = $88
STMTAB      = $88
STMCUR      = $8A
STARP       = $8C
ENDSTAR     = $8E
RUNSTK      = $8E
TOPRSTK     = $90
MEOLFLG     = $92

L0094       = $0094

SCRADR      = $95

L0097       = $0097
L0098       = $0098
L0099       = $0099
L009A       = $009A
L009B       = $009B
L009C       = $009C
L009D       = $009D
L009E       = $009E

LLNGTH      = $9F
TSLNUM      = $A0

L00A0       = $00A0
L00A2       = $00A2
L00A3       = $00A3
L00A4       = $00A4
L00A5       = $00A5
L00A6       = $00A6

NXTSTD      = $00A7
STINDEX     = $00A8
OPSTKX      = $00A9
ARSLVL      = $00AA
EXSVOP      = $00AB
TVSCIX      = $00AC
EXSVPR      = $00AC

L00AD       = $00AD
L00AE       = $00AE
L00AF       = $00AF

SVONTC      = $B0
COMCNT      = $B0

L00B1       = $00B1
L00B2       = $00B2
L00B3       = $00B3

ENTDTD      = $00B4

L00B5       = $00B5

DATAD       = $B6
DATALN      = $B7

ERRNUM      = $B9
INDENTLVL   = $B9

STOPLN      = $00BA

L00BC       = $00BC
L00BD       = $00BD

SAVCUR      = $BE       ; Save current line number

IOCMD       = $C0
IODVC       = $C1
PROMPT      = $C2
ERRSAVE     = $C3

TEMPA       = $C4

L00C6       = $00C6
L00C7       = $00C7

COLOR       = $C8
PTABW       = $C9
LOADFLG     = $CA

L00DA       = $00DA
L00DB       = $00DB
L00DC       = $00DC
L00DD       = $00DD
L00DE       = $00DE
L00DF       = $00DF
L00E6       = $00E6
L00E7       = $00E7
L00E8       = $00E8
L00E9       = $00E9
L00EA       = $00EA
L00EB       = $00EB
L00EC       = $00EC
L00ED       = $00ED
L00EE       = $00EE
L00EF       = $00EF
L00F0       = $00F0
L00F1       = $00F1
L00F5       = $00F5
L00F6       = $00F6
L00F7       = $00F7
L00F8       = $00F8
L00F9       = $00F9
L00FA       = $00FA
DEGFLAG     = $00FB
L00FC       = $00FC
L00FD       = $00FD
L0480       = $0480
L0481       = $0481
L0482       = $0482
L0483       = $0483

LBUFF       = $0580

PLOT_MASK   = $05C0
PLOT_PIX    = $05C8

PLYARG      = $05E0
FPSCR       = $05E6
FPSCR1      = $05EC

LB000       = $B000
ROM_CHMAP   = $E000
NMI_VEC     = $FFFA
IRQ_VEC     = $FFFE

; The TurboBasic XL low ram address - adjust to load in bigger DOS
TBXL_LOW_ADDRESS = $2080
; The character map of the loader - used to avoid screen flicker while loading
RAM_CHMAP   = $5C00
; The loader address - will be overwritten by the main code
TBXL_LOADER = $2100
; The loader for RAM under ROM parts and initialization address
TBXL_ROMLOADER = $6000

;
; Start of loader
;
            ; Adjust MEMLO
            org MEMLO
            .word TOP_LOWMEM

            ; Load character definitions for chars 64-95
            org RAM_CHMAP + $200
            .byte $00,$18,$18,$FF,$3C,$3C,$66,$42
            .byte $00,$00,$00,$06,$66,$7E,$76,$66
            .byte $00,$00,$18,$3C,$66,$7E,$66,$66
            .byte $00,$3E,$73,$33,$3E,$30,$30,$78
            .byte $00,$7C,$37,$33,$3E,$30,$30,$78
            .byte $00,$00,$60,$63,$36,$3C,$39,$63
            .byte $00,$01,$01,$0F,$03,$03,$F6,$E4
            .byte $00,$80,$80,$F0,$C0,$C0,$60,$20
            .byte $00,$01,$03,$06,$06,$06,$03,$01
            .byte $00,$E1,$33,$06,$06,$06,$33,$E1
            .byte $00,$C7,$63,$33,$36,$36,$66,$CE
            .byte $00,$0E,$9C,$9C,$F6,$66,$66,$67
            .byte $00,$7E,$33,$33,$3E,$30,$30,$78
            .byte $00,$67,$66,$66,$66,$66,$66,$3C
            .byte $00,$FF,$31,$31,$31,$31,$31,$7B
            .byte $00,$FB,$81,$81,$F1,$81,$81,$FB
            .byte $00,$F8,$8C,$8C,$F8,$B0,$98,$CC
;
            org TBXL_LOADER
;
SPLASHSCR   ldx #$00
COPYCHR     lda ROM_CHMAP,X
            sta RAM_CHMAP,X
            lda ROM_CHMAP+$100,X
            sta RAM_CHMAP+$100,X
            lda ROM_CHMAP+$300,X
            sta RAM_CHMAP+$300,X
            inx
            bne COPYCHR
            lda #$10
            sta COLOR2
            lda #>RAM_CHMAP
            sta COLOR1
            sta CRSINH
            sta CHBAS
            lda #<LOAD_MSG
            sta IOCB0+ICBAL
            lda #>LOAD_MSG
            sta IOCB0+ICBAH
            lda #(END_LOAD_MSG - LOAD_MSG)
            sta IOCB0+ICBLL
            stx IOCB0+ICBLH
            lda #$0B
            sta IOCB0+ICCOM
            jsr CIOV
            stx CRSINH
            rts

LOAD_MSG    .byte $7d, CR
            .byte $7f, $7f, $20, $00, $01, $02, $03, $04, $05, $06, $07, CR
            .byte $7f, $7f, $08, $09, $0A, $0B, $0C, $0D, $0E, $0F, $10, CR
            .byte CR
            .byte $7f, '    TURBO-BASIC XL 1.5', CR
            .byte $7f, ' (c) 1985 Frank Ostrowski', CR
            .byte CR
END_LOAD_MSG

;           Run our splash screen
            INI SPLASHSCR


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Start of TurboBasic XL Code in low RAM
;
            org TBXL_LOW_ADDRESS

RESET_V     lda #<RESET_V
            ldy #>RESET_V
            sta DOSINI
            sty DOSINI+1
            lda #$FF
            sta PORTB
JMPDOS      jsr $0000
            lda #$FE
            sta PORTB
            lda LOMEM
            ldy LOMEM+1
            sta MEMLO
            sty MEMLO+1
            jmp COLDSTART

; Reserve 64 bytes for the operation stack.
OPSTK       .ds $40

; Align the variable stack
;            org $2100
            org (* + $FF) & $FF00
VARSTK0     .ds $20
VARSTK1     .ds $20
ARGSTK0     .ds $20
ARGSTK1     .ds $20
ARGSTK2     .ds $20
ARGSTK3     .ds $20
ARGSTK4     .ds $20
ARGSTK5     .ds $20

;            org $2200
; Table with statement execution address
; This table MUST be at a page address ($XX00)
STMT_X_TAB  .word X_REM,X_DATA,X_INPUT,X_COLOR
            .word X_LIST,X_ENTER,X_LET,X_IF
            .word X_FOR,X_NEXT,X_GOTO,X_GOTO
            .word X_GOSUB,X_TRAP,X_BYE,X_CONT
            .word X_DIM,X_CLOSE,X_CLR,X_DEG
            .word X_DIM,X_END,X_NEW,X_OPEN
            .word X_LOAD,X_SAVE,X_STATUS,X_NOTE
            .word X_POINT,X_XIO,X_ON,X_POKE
            .word X_PRINT,X_RAD,X_READ,X_RESTORE
            .word X_RETURN,X_RUN,X_STOP,X_POP
            .word X_PRINT,X_GET,X_PUT,X_GRAPHICS
            .word X_PLOT,X_POSITION,X_DOS,X_DRAWTO
            .word X_SETCOLOR,X_LOCATE,X_DSOUND,X_LPRINT
            .word X_CSAVE,X_CLOAD,X_LET,X_ERROR
            .word X_DPOKE,X_MOVE,X_NMOVE,X_FF
            .word X_REPEAT,X_UNTIL,X_WHILE,X_WEND
            .word X_ELSE,X_ENDIF,X_BPUT,X_BGET
            .word X_FILLTO,X_DO,X_LOOP,X_EXIT
            .word X_DIR,X_LOCK,X_UNLOCK,X_RENAME
            .word X_DELETE,X_PAUSE,X_TIMESET,ERR_27
            .word X_EXEC,X_ENDPROC,X_FCOLOR,X_FL
            .word X_LREM,X_RENUM,X_DEL,X_DUMP
            .word X_TRACE,X_TEXT,X_BLOAD,X_BRUN
            .word X_GO_S,X_LABEL,X_FB,X_PAINT
            .word X_CLS,X_DSOUND,X_CIRCLE,X_PPUT
            .word X_PGET

; MATHPACK temporary variables, used to accelerate MUL and DIV
; EXPAND_POW2 stores all the
FPTMP0      .ds 8
FPTMP1      .ds 8
FPTMP2      .ds 8
FPTMP3      .ds 8
FPTMP4      .ds 8
FPTMP5      .ds 8

.if .not .def tb_fixes
; Note: 6 bytes skipped to align next block to $2300
            .ds 6
;            org $2300
            nop
            jsr DISROM
            jmp ERR_9
.endif ; tb_fixes

IO_DIRSPEC  .byte 'D:*.*', CR
DEV_S_      .byte 'S:', CR
DEV_C_      .byte 'C:', CR
DEV_P_      .byte 'P:', CR

BLOADFLAG   .ds 1

; Note: Skip this 13 bytes so that DISROM has an address with <(DISROM-1) == >(DISROM-1)
;       This is used as return to USR call
            .ds (>*)-((* & $00FF) - 1)

;            org $2324
DISROM      lda PORTB
            and #$FC
            ora #$02
            sta PORTB
            rts

; Note: this table needs to be in address with low-part = $1D * 2 = $3A ($XX3A),
;       because the first executable token is '<=' at $1D
            org ((* - $3A + $FF) & $FF00) + $3A
OPETAB
            .word X_LTE       ; CLE     '<='
            .word X_NEQU      ; CNE     '<>'
            .word X_GTE       ; CGE     '>='
            .word X_LT        ; CLT     '<'
            .word X_GT        ; CGT     '>'
            .word X_EQU       ; CEQ     '='
            .word X_POW       ; CEXP    '^'
            .word X_FMUL      ; CMUL    '*'
            .word X_FADD      ; CPLUS   '+'
            .word X_FSUB      ; CMINUS  '-'
            .word X_FDIV      ; CDIV    '/'
            .word X_NOT       ; CNOT    'NOT'
            .word X_OR        ; COR     'OR'
            .word X_AND       ; CAND    'AND'
            .word X_LPAREN    ; CLPRN   '('
            .word X_RPAREN    ; CRPRN   ')'
            .word X_FPASIGN   ; CAASN   '='
            .word X_STRASIGN  ; CSASN   '='
            .word X_LTE       ; CSLE    '<='
            .word X_NEQU      ; CSNE    '<>'
            .word X_GTE       ; CSGE    '>='
            .word X_LT        ; CSLT    '<'
            .word X_GT        ; CSGT    '>'
            .word X_EQU       ; CSEQ    '='
            .word X_UPLUS     ; CUPLUS  '+'
            .word X_FNEG      ; CUMINUS '-'
            .word X_STRLPAREN ; CSLPRN  '('
            .word X_ARRLPAREN ; CALPRN  '('
            .word X_DIMLPAREN ; CDLPRN  '('
            .word X_RPAREN    ; CFLPRN  '('
            .word X_DIMLPAREN ; CDSLPRN '('
            .word X_ARRCOMMA  ; CACOM   ','
            .word X_STRP      ; CSTR    'STR$'
            .word X_CHRP      ; CCHR    'CHR$'
            .word X_USR       ; CUSR    'USR'
            .word X_ASC       ; CASC    'ASC'
            .word X_VAL       ; CVAL    'VAL'
            .word X_LEN       ; CLEN    'LEN'
            .word X_ADR       ; CADR    'ADR'
            .word X_ATN       ; CATN    'ATN'
            .word X_COS       ; CCOS    'COS'
            .word X_PEEK      ; CPEEK   'PEEK'
            .word X_SIN       ; CSIN    'SIN'
            .word X_RNDFN     ; CRND    'RND'
            .word X_FRE       ; CFRE    'FRE'
            .word X_EXP       ; CFEXP   'EXP'
            .word X_LOG       ; CLOG    'LOG'
            .word X_CLOG      ; CCLOG   'CLOG'
            .word X_SQR       ; CSQR    'SQR'
            .word X_SGN       ; CSGN    'SGN'
            .word X_ABS       ; CABS    'ABS'
            .word X_INT       ; CINT    'INT'
            .word X_PADDLE    ; CPADDLE 'PADDLE'
            .word X_STICK     ; CSTICK  'STICK'
            .word X_PTRIG     ; CPTRIG  'PTRIG'
            .word X_STRIG     ; CSTRIG  'STRIG'
            .word X_DPEEK     ; CDPEEK  'DPEEK'
            .word X_BITAND    ; CIAND   '&'
            .word X_BITOR     ; CIOR    '!'
            .word X_INSTR     ; CINSTR  'INSTR'
            .word X_INKEYP    ; CINKEYP 'INKEY$'
            .word X_EXOR      ; CEXOR   'EXOR'
            .word X_HEXP      ; CHEXP   'HEX$'
            .word X_DEC       ; CDEC    'DEC'
            .word X_DIV       ; CFDIV   'DIV'
            .word X_FRAC      ; CFRAC   'FRAC'
            .word X_TIMEP     ; CTIMEP  'TIME$'
            .word X_TIME      ; CTIME   'TIME'
            .word X_MOD       ; CMOD    'MOD'
            .word X_ONEXEC    ; CEXEC   'EXEC'
            .word X_RND       ; CRNDU   'RND'
            .word X_RAND      ; CRAND   'RAND'
            .word X_TRUNC     ; CTRUNC  'TRUNC'
            .word X_N0        ; CN0     '%0'
            .word X_N1        ; CN1     '%1'
            .word X_N2        ; CN2     '%2'
            .word X_N3        ; CN3     '%3'
            .word X_ONGOS     ; CGOG    'GO#'
            .word X_UINSTR    ; CUINSTR 'UINSTR'
            .word X_ERR       ; CERR    'ERR'
            .word X_ERL       ; CERL    'ERL'

OPRTAB      ; Table with right operator precedence
            .byte $00 ; CDQ     '"'
            .byte $00 ; CSOE
            .byte $00 ; CCOM    ','
            .byte $00 ; CDOL    '$'
            .byte $00 ; CEOS    ':'
            .byte $00 ; CSC     ';'
            .byte $00 ; CCR     CR
            .byte $00 ; CGTO    'GOTO'
            .byte $00 ; CGS     'GOSUB'
            .byte $00 ; CTO     'TO'
            .byte $00 ; CSTEP   'STEP'
            .byte $00 ; CTHEN   'THEN'
            .byte $00 ; CPND    '#'
            .byte $20 ; CLE     '<='
            .byte $20 ; CNE     '<>'
            .byte $20 ; CGE     '>='
            .byte $20 ; CLT     '<'
            .byte $20 ; CGT     '>'
            .byte $20 ; CEQ     '='
            .byte $2C ; CEXP    '^'
            .byte $28 ; CMUL    '*'
            .byte $22 ; CPLUS   '+'
            .byte $22 ; CMINUS  '-'
            .byte $28 ; CDIV    '/'
            .byte $1E ; CNOT    'NOT'
            .byte $1A ; COR     'OR'
            .byte $1C ; CAND    'AND'
            .byte $32 ; CLPRN   '('
            .byte $04 ; CRPRN   ')'
            .byte $32 ; CAASN   '='
            .byte $32 ; CSASN   '='
            .byte $30 ; CSLE    '<='
            .byte $30 ; CSNE    '<>'
            .byte $30 ; CSGE    '>='
            .byte $30 ; CSLT    '<'
            .byte $30 ; CSGT    '>'
            .byte $30 ; CSEQ    '='
            .byte $2E ; CUPLUS  '+'
            .byte $2E ; CUMINUS '-'
            .byte $32 ; CSLPRN  '('
            .byte $32 ; CALPRN  '('
            .byte $32 ; CDLPRN  '('
            .byte $32 ; CFLPRN  '('
            .byte $32 ; CDSLPRN '('
            .byte $04 ; CACOM   ','
            .byte $32 ; CSTR    'STR$'
            .byte $32 ; CCHR    'CHR$'
            .byte $32 ; CUSR    'USR'
            .byte $32 ; CASC    'ASC'
            .byte $32 ; CVAL    'VAL'
            .byte $32 ; CLEN    'LEN'
            .byte $32 ; CADR    'ADR'
            .byte $32 ; CATN    'ATN'
            .byte $32 ; CCOS    'COS'
            .byte $32 ; CPEEK   'PEEK'
            .byte $32 ; CSIN    'SIN'
            .byte $32 ; CRND    'RND'
            .byte $32 ; CFRE    'FRE'
            .byte $32 ; CFEXP   'EXP'
            .byte $32 ; CLOG    'LOG'
            .byte $32 ; CCLOG   'CLOG'
            .byte $32 ; CSQR    'SQR'
            .byte $32 ; CSGN    'SGN'
            .byte $32 ; CABS    'ABS'
            .byte $32 ; CINT    'INT'
            .byte $32 ; CPADDLE 'PADDLE'
            .byte $32 ; CSTICK  'STICK'
            .byte $32 ; CPTRIG  'PTRIG'
            .byte $32 ; CSTRIG  'STRIG'
            .byte $32 ; CDPEEK  'DPEEK'
            .byte $2A ; CIAND   '&'
            .byte $2A ; CIOR    '!'
            .byte $32 ; CINSTR  'INSTR'
            .byte $32 ; CINKEYP 'INKEY$'
            .byte $2A ; CEXOR   'EXOR'
            .byte $32 ; CHEXP   'HEX$'
            .byte $32 ; CDEC    'DEC'
            .byte $28 ; CFDIV   'DIV'
            .byte $32 ; CFRAC   'FRAC'
            .byte $32 ; CTIMEP  'TIME$'
            .byte $32 ; CTIME   'TIME'
            .byte $28 ; CMOD    'MOD'
            .byte $00 ; CEXEC   'EXEC'
            .byte $32 ; CRNDU   'RND'
            .byte $32 ; CRAND   'RAND'
            .byte $32 ; CTRUNC  'TRUNC'
            .byte $32 ; CN0     '%0'
            .byte $32 ; CN1     '%1'
            .byte $32 ; CN2     '%2'
            .byte $32 ; CN3     '%3'
            .byte $00 ; CGOG    'GO#'
            .byte $32 ; CUINSTR 'UINSTR'
            .byte $32 ; CERR    'ERR'
            .byte $32 ; CERL    'ERL'

OPLTAB      ; Table with left operator precedence
            .byte $00 ; CDQ     '"'
            .byte $00 ; CSOE
            .byte $00 ; CCOM    ','
            .byte $00 ; CDOL    '$'
            .byte $00 ; CEOS    ':'
            .byte $00 ; CSC     ';'
            .byte $00 ; CCR     CR
            .byte $00 ; CGTO    'GOTO'
            .byte $00 ; CGS     'GOSUB'
            .byte $00 ; CTO     'TO'
            .byte $00 ; CSTEP   'STEP'
            .byte $00 ; CTHEN   'THEN'
            .byte $00 ; CPND    '#'
            .byte $20 ; CLE     '<='
            .byte $20 ; CNE     '<>'
            .byte $20 ; CGE     '>='
            .byte $20 ; CLT     '<'
            .byte $20 ; CGT     '>'
            .byte $20 ; CEQ     '='
            .byte $2C ; CEXP    '^'
            .byte $28 ; CMUL    '*'
            .byte $22 ; CPLUS   '+'
            .byte $22 ; CMINUS  '-'
            .byte $28 ; CDIV    '/'
            .byte $1D ; CNOT    'NOT'
            .byte $1A ; COR     'OR'
            .byte $1C ; CAND    'AND'
            .byte $02 ; CLPRN   '('
            .byte $30 ; CRPRN   ')'
            .byte $01 ; CAASN   '='
            .byte $01 ; CSASN   '='
            .byte $30 ; CSLE    '<='
            .byte $30 ; CSNE    '<>'
            .byte $30 ; CSGE    '>='
            .byte $30 ; CSLT    '<'
            .byte $30 ; CSGT    '>'
            .byte $30 ; CSEQ    '='
            .byte $2D ; CUPLUS  '+'
            .byte $2D ; CUMINUS '-'
            .byte $02 ; CSLPRN  '('
            .byte $02 ; CALPRN  '('
            .byte $02 ; CDLPRN  '('
            .byte $02 ; CFLPRN  '('
            .byte $02 ; CDSLPRN '('
            .byte $03 ; CACOM   ','
            .byte $02 ; CSTR    'STR$'
            .byte $02 ; CCHR    'CHR$'
            .byte $02 ; CUSR    'USR'
            .byte $02 ; CASC    'ASC'
            .byte $02 ; CVAL    'VAL'
            .byte $02 ; CLEN    'LEN'
            .byte $02 ; CADR    'ADR'
            .byte $02 ; CATN    'ATN'
            .byte $02 ; CCOS    'COS'
            .byte $02 ; CPEEK   'PEEK'
            .byte $02 ; CSIN    'SIN'
            .byte $02 ; CRND    'RND'
            .byte $02 ; CFRE    'FRE'
            .byte $02 ; CFEXP   'EXP'
            .byte $02 ; CLOG    'LOG'
            .byte $02 ; CCLOG   'CLOG'
            .byte $02 ; CSQR    'SQR'
            .byte $02 ; CSGN    'SGN'
            .byte $02 ; CABS    'ABS'
            .byte $02 ; CINT    'INT'
            .byte $02 ; CPADDLE 'PADDLE'
            .byte $02 ; CSTICK  'STICK'
            .byte $02 ; CPTRIG  'PTRIG'
            .byte $02 ; CSTRIG  'STRIG'
            .byte $02 ; CDPEEK  'DPEEK'
            .byte $2A ; CIAND   '&'
            .byte $2A ; CIOR    '!'
            .byte $02 ; CINSTR  'INSTR'
            .byte $32 ; CINKEYP 'INKEY$'
            .byte $2A ; CEXOR   'EXOR'
            .byte $02 ; CHEXP   'HEX$'
            .byte $02 ; CDEC    'DEC'
            .byte $28 ; CFDIV   'DIV'
            .byte $02 ; CFRAC   'FRAC'
            .byte $32 ; CTIMEP  'TIME$'
            .byte $32 ; CTIME   'TIME'
            .byte $28 ; CMOD    'MOD'
            .byte $00 ; CEXEC   'EXEC'
            .byte $32 ; CRNDU   'RND'
            .byte $02 ; CRAND   'RAND'
            .byte $02 ; CTRUNC  'TRUNC'
            .byte $32 ; CN0     '%0'
            .byte $32 ; CN1     '%1'
            .byte $32 ; CN2     '%2'
            .byte $32 ; CN3     '%3'
            .byte $00 ; CGOG    'GO#'
            .byte $02 ; CUINSTR 'UINSTR'
            .byte $32 ; CERR    'ERR'
            .byte $32 ; CERL    'ERL'

B_CIOV      inc PORTB
            jsr CIOV
            dec PORTB
            cpy #$00

; Non executable statements, all point here
X_REM
X_DATA
X_LREM
X_LABEL
X_LPAREN
X_UPLUS
X_ONEXEC
X_ONGOS
            rts


NMI_END     pla
            tax
IRQ_END     dec PORTB
            pla
            rti

NMI_PROC    bit NMIST
            bpl L24B3
            jmp (VDSLST)
L24B3       pha
            txa
            pha
            lda #>NMI_END
            pha
            lda #<NMI_END
            pha
            tsx
            lda $100 + 5,X
            pha
            cld
            pha
            txa
            pha
            tya
            pha
            inc PORTB
            sta NMIRES
            jmp (VVBLKI)

IRQ_PROC    pha
            lda #>IRQ_END
            pha
            lda #<IRQ_END
            pha
            php
            inc PORTB
            jmp (VIMIRQ)

; Calls PUTCHAR from IO channel X
PDUM_ROM    inc PORTB
            jsr PDUM
            dec PORTB
            rts

; Calls PUTCHAR from IO channel X
PDUM        lda IOCB0+ICPTH,X
            pha
            lda IOCB0+ICPTL,X
            pha
            tya
            ldy #$5C
            rts

GETKEY      inc PORTB
JSR_GETKEY  jsr $0000
            dec PORTB
            rts

X_DOS       jsr CLSALL
            inc PORTB
            lda JMPDOS+1
            ldy JMPDOS+2
            sta DOSINI
            sty DOSINI+1
            jmp (DOSVEC)

X_BYE       jsr CLSALL
            inc PORTB
            jmp SELFSV

X_DPEEK     jsr X_POPINT
            inc PORTB
            ldy #$01
            lda (FR0),Y
            tax
            dey
            lda (FR0),Y
            dec PORTB
            sta FR0
            stx FR0+1
            jmp X_RET_INT

X_DPOKE     jsr GET2INT
            inc PORTB
            ldy #$00
            sta (L009B),Y
            lda FR0+1
            iny
            bne L254C

ERR_3C      jmp ERR_3

X_POKE      jsr GET2INT
            bne ERR_3C
            inc PORTB
L254C       sta (L009B),Y
            lda PORTB
            and #$FC
            ora #$02
            sta PORTB
            rts

X_USR       jsr DO_USR
            jsr T_IFP
            jmp X_PUSHVAL

DO_USR      lda #>(DISROM-1)
            pha
.if (<(DISROM-1)) != (>(DISROM-1))
            lda #<(DISROM-1)
.endif
            pha
            lda COMCNT
            sta L00C6
L256A       jsr X_POPINT
            dec L00C6
            bmi L257A
            lda FR0
            pha
            lda FR0+1
            pha
            jmp L256A
L257A       inc PORTB
            lda COMCNT
            pha
            jmp (FR0)

ERR_2_      jmp ERR_2

; Expand memory for a table
EXPLOW      lda #$00
EXPAND      sty L00A4
            sta L00A5
            clc
            lda TOPRSTK
            adc L00A4
            tay
            lda TOPRSTK+1
            adc L00A5
            cmp MEMTOP+1
            bcc L25A4
            bne ERR_2_
            cpy MEMTOP
            bcc L25A4
            bne ERR_2_
L25A4       sec
            lda TOPRSTK
            sbc $00,X
            sta L00A2
            lda TOPRSTK+1
            sbc NGFLAG,X
            sta L00A3
            clc
            lda $00,X
            sta L0097
            sta L0099
            adc L00A4
            sta L009B
            lda NGFLAG,X
            sta L0098
            sta L009A
            adc L00A5
            sta L009C
L25C6       lda $00,X
            adc L00A4
            sta $00,X
            lda NGFLAG,X
            adc L00A5
            sta NGFLAG,X
            inx
            inx
            cpx #$92
            bcc L25C6
            sta APPMHI+1
            lda TOPRSTK
            sta APPMHI

DO_MOVEDWN  inc PORTB
            ldx L00A3
            clc
            txa
            adc L009A
            sta L009A
            clc
            txa
            adc L009C
            sta L009C
            inx
            ldy L00A2
            beq L2619
L25F4       dey
            lda (L0099),Y
            sta (L009B),Y
            tya
            bne L25F4
            beq L2619
L25FE       dec L009A
            dec L009C
L2602       dey
            lda (L0099),Y
            sta (L009B),Y
            dey
            lda (L0099),Y
            sta (L009B),Y
            dey
            lda (L0099),Y
            sta (L009B),Y
            dey
            lda (L0099),Y
            sta (L009B),Y
            tya
            bne L2602
L2619       dex
            bne L25FE
            dec PORTB
            rts

; Move memory up, freeing heap
CONTLOW     lda #$00
CONTRACT    sty L00A4
            sta L00A5
            sec
            lda TOPRSTK
            sbc $00,X
            sta L00A2
            lda TOPRSTK+1
            sbc NGFLAG,X
            sta L00A3
            sec
            lda $00,X
            sta L0099
            sbc L00A4
            sta L009B
            lda NGFLAG,X
            sta L009A
            sbc L00A5
            sta L009C
L2644       sec
            lda $00,X
            sbc L00A4
            sta $00,X
            lda NGFLAG,X
            sbc L00A5
            sta NGFLAG,X
            inx
            inx
            cpx #$92
            bcc L2644
            sta APPMHI+1
            lda TOPRSTK
            sta APPMHI

DO_MOVEUP   inc PORTB
            ldy #$00
            ldx L00A3
            beq L2683
L2666       lda (L0099),Y
            sta (L009B),Y
            iny
            lda (L0099),Y
            sta (L009B),Y
            iny
            lda (L0099),Y
            sta (L009B),Y
            iny
            lda (L0099),Y
            sta (L009B),Y
            iny
            bne L2666
            inc L009A
            inc L009C
            dex
            bne L2666
L2683       ldx L00A2
            beq L268F
L2687       lda (L0099),Y
            sta (L009B),Y
            iny
            dex
            bne L2687
L268F       dec PORTB
            rts

FP_ZERO     clc
            jmp T_ZFR0

RET_CLC     clc
            rts

RET_SEC     sec
            rts

T_FSQ       jsr T_FMOVE

T_FMUL      lda FR0
            beq RET_CLC
            lda FR1
            beq FP_ZERO
            eor FR0
            and #$80
            sta L00EE
            lda FR1
            and #$7F
            sta FR1
            lda FR0
            and #$7F
            sec
            sbc #$40
            sec
            adc FR1
            bmi RET_SEC
            ora L00EE
            tay
            jsr EXPAND_POW2
            sta L00DA
            sta L00DB
            sta L00DC
            sta L00DD
            sta L00DE
            sta L00DF
            sty FR0
            ldy #$07
L26D4       lsr FR1+5
            bcc L2708
            clc
            lda L00DE
            adc FPTMP5,Y
            sta L00DE
            lda L00DD
            adc FPTMP4,Y
            sta L00DD
            lda L00DC
            adc FPTMP3,Y
            sta L00DC
            lda L00DB
            adc FPTMP2,Y
            sta L00DB
            lda L00DA
            adc FPTMP1,Y
            sta L00DA
            lda FR0+5
            adc FPTMP0,Y
            sta FR0+5
            dey
            bpl L26D4
            bmi L270D
L2708       beq L270D
            dey
            bpl L26D4
L270D       ldy #$07
L270F       lsr FR1+4
            bcc L2743
            clc
            lda L00DD
            adc FPTMP5,Y
            sta L00DD
            lda L00DC
            adc FPTMP4,Y
            sta L00DC
            lda L00DB
            adc FPTMP3,Y
            sta L00DB
            lda L00DA
            adc FPTMP2,Y
            sta L00DA
            lda FR0+5
            adc FPTMP1,Y
            sta FR0+5
            lda FR0+4
            adc FPTMP0,Y
            sta FR0+4
            dey
            bpl L270F
            bmi L2748
L2743       beq L2748
            dey
            bpl L270F
L2748       ldy #$07
L274A       lsr FR1+3
            bcc L277E
            clc
            lda L00DC
            adc FPTMP5,Y
            sta L00DC
            lda L00DB
            adc FPTMP4,Y
            sta L00DB
            lda L00DA
            adc FPTMP3,Y
            sta L00DA
            lda FR0+5
            adc FPTMP2,Y
            sta FR0+5
            lda FR0+4
            adc FPTMP1,Y
            sta FR0+4
            lda FR0+3
            adc FPTMP0,Y
            sta FR0+3
            dey
            bpl L274A
            bmi L2783
L277E       beq L2783
            dey
            bpl L274A
L2783       ldy #$07
L2785       lsr FR1+2
            bcc L27B9
            clc
            lda L00DB
            adc FPTMP5,Y
            sta L00DB
            lda L00DA
            adc FPTMP4,Y
            sta L00DA
            lda FR0+5
            adc FPTMP3,Y
            sta FR0+5
            lda FR0+4
            adc FPTMP2,Y
            sta FR0+4
            lda FR0+3
            adc FPTMP1,Y
            sta FR0+3
            lda FR0+2
            adc FPTMP0,Y
            sta FR0+2
            dey
            bpl L2785
            bmi L27BE
L27B9       beq L27BE
            dey
            bpl L2785
L27BE       ldy #$07
L27C0       lsr FR1+1
            bcc L27F4
            clc
            lda L00DA
            adc FPTMP5,Y
            sta L00DA
            lda FR0+5
            adc FPTMP4,Y
            sta FR0+5
            lda FR0+4
            adc FPTMP3,Y
            sta FR0+4
            lda FR0+3
            adc FPTMP2,Y
            sta FR0+3
            lda FR0+2
            adc FPTMP1,Y
            sta FR0+2
            lda FR0+1
            adc FPTMP0,Y
            sta FR0+1
            dey
            bpl L27C0
            bmi L27F9
L27F4       beq L27F9
            dey
            bpl L27C0
L27F9       jmp NORMDIVMUL
L27FC       clc
            rts
L27FE       sec
            rts

T_FDIV      lda FR1
            beq L27FE
            lda FR0
            beq L27FC
            eor FR1
            and #$80
            sta L00EE
            lda FR1
            and #$7F
            sta FR1
            lda FR0
            and #$7F
            sec
            sbc FR1
            clc
            adc #$40
            bmi L27FE
            ora L00EE
            tay
            jsr EXPAND_POW2
            sta L00E6
            sta L00E7
            sta L00E8
            sta L00E9
            sta L00EA
            sta FR1
            sta L00DA
            sty FR0
            ldy #$00
L2838       lda FR1
            cmp FPTMP0,Y
            bne L2867
            lda FR1+1
            cmp FPTMP1,Y
            bne L2867
            lda FR1+2
            cmp FPTMP2,Y
            bne L2867
            lda FR1+3
            cmp FPTMP3,Y
            bne L2867
            lda FR1+4
            cmp FPTMP4,Y
            bne L2867
            lda FR1+5
            cmp FPTMP5,Y
            bne L2867
            ldx #$00
            jmp FDIVSKP0
L2867       bcc L2893
            lda FR1+5
            sbc FPTMP5,Y
            sta FR1+5
            lda FR1+4
            sbc FPTMP4,Y
            sta FR1+4
            lda FR1+3
            sbc FPTMP3,Y
            sta FR1+3
            lda FR1+2
            sbc FPTMP2,Y
            sta FR1+2
            lda FR1+1
            sbc FPTMP1,Y
            sta FR1+1
            lda FR1
            sbc FPTMP0,Y
            sta FR1
L2893       rol FR0+1
            iny
            cpy #$08
            bne L2838
            ldy #$00
L289C       lda FR1+1
            cmp FPTMP0,Y
            bne L28CB
            lda FR1+2
            cmp FPTMP1,Y
            bne L28CB
            lda FR1+3
            cmp FPTMP2,Y
            bne L28CB
            lda FR1+4
            cmp FPTMP3,Y
            bne L28CB
            lda FR1+5
            cmp FPTMP4,Y
            bne L28CB
            lda L00E6
            cmp FPTMP5,Y
            bne L28CB
            ldx #$01
            jmp FDIVSKP0
L28CB       bcc L28F7
            lda L00E6
            sbc FPTMP5,Y
            sta L00E6
            lda FR1+5
            sbc FPTMP4,Y
            sta FR1+5
            lda FR1+4
            sbc FPTMP3,Y
            sta FR1+4
            lda FR1+3
            sbc FPTMP2,Y
            sta FR1+3
            lda FR1+2
            sbc FPTMP1,Y
            sta FR1+2
            lda FR1+1
            sbc FPTMP0,Y
            sta FR1+1
L28F7       rol FR0+2
            iny
            cpy #$08
            bne L289C
            ldy #$00
L2900       lda FR1+2
            cmp FPTMP0,Y
            bne L292F
            lda FR1+3
            cmp FPTMP1,Y
            bne L292F
            lda FR1+4
            cmp FPTMP2,Y
            bne L292F
            lda FR1+5
            cmp FPTMP3,Y
            bne L292F
            lda L00E6
            cmp FPTMP4,Y
            bne L292F
            lda L00E7
            cmp FPTMP5,Y
            bne L292F
            ldx #$02
            jmp FDIVSKP0
L292F       bcc L295B
            lda L00E7
            sbc FPTMP5,Y
            sta L00E7
            lda L00E6
            sbc FPTMP4,Y
            sta L00E6
            lda FR1+5
            sbc FPTMP3,Y
            sta FR1+5
            lda FR1+4
            sbc FPTMP2,Y
            sta FR1+4
            lda FR1+3
            sbc FPTMP1,Y
            sta FR1+3
            lda FR1+2
            sbc FPTMP0,Y
            sta FR1+2
L295B       rol FR0+3
            iny
            cpy #$08
            bne L2900
            ldy #$00
L2964       lda FR1+3
            cmp FPTMP0,Y
            bne L2993
            lda FR1+4
            cmp FPTMP1,Y
            bne L2993
            lda FR1+5
            cmp FPTMP2,Y
            bne L2993
            lda L00E6
            cmp FPTMP3,Y
            bne L2993
            lda L00E7
            cmp FPTMP4,Y
            bne L2993
            lda L00E8
            cmp FPTMP5,Y
            bne L2993
            ldx #$03
            jmp FDIVSKP0
L2993       bcc L29BF
            lda L00E8
            sbc FPTMP5,Y
            sta L00E8
            lda L00E7
            sbc FPTMP4,Y
            sta L00E7
            lda L00E6
            sbc FPTMP3,Y
            sta L00E6
            lda FR1+5
            sbc FPTMP2,Y
            sta FR1+5
            lda FR1+4
            sbc FPTMP1,Y
            sta FR1+4
            lda FR1+3
            sbc FPTMP0,Y
            sta FR1+3
L29BF       rol FR0+4
            iny
            cpy #$08
            bne L2964
            ldy #$00
L29C8       lda FR1+4
            cmp FPTMP0,Y
            bne L29F7
            lda FR1+5
            cmp FPTMP1,Y
            bne L29F7
            lda L00E6
            cmp FPTMP2,Y
            bne L29F7
            lda L00E7
            cmp FPTMP3,Y
            bne L29F7
            lda L00E8
            cmp FPTMP4,Y
            bne L29F7
            lda L00E9
            cmp FPTMP5,Y
            bne L29F7
            ldx #$04
            jmp FDIVSKP0
L29F7       bcc L2A23
            lda L00E9
            sbc FPTMP5,Y
            sta L00E9
            lda L00E8
            sbc FPTMP4,Y
            sta L00E8
            lda L00E7
            sbc FPTMP3,Y
            sta L00E7
            lda L00E6
            sbc FPTMP2,Y
            sta L00E6
            lda FR1+5
            sbc FPTMP1,Y
            sta FR1+5
            lda FR1+4
            sbc FPTMP0,Y
            sta FR1+4
L2A23       rol FR0+5
            iny
            cpy #$08
            bne L29C8
            lda FR0+1
            bne FDIVEND
            ldy #$00
L2A30       lda FR1+5
            cmp FPTMP0,Y
            bne L2A5F
            lda L00E6
            cmp FPTMP1,Y
            bne L2A5F
            lda L00E7
            cmp FPTMP2,Y
            bne L2A5F
            lda L00E8
            cmp FPTMP3,Y
            bne L2A5F
            lda L00E9
            cmp FPTMP4,Y
            bne L2A5F
            lda L00EA
            cmp FPTMP5,Y
            bne L2A5F
            ldx #$05
            jmp FDIVSKP0
L2A5F       bcc L2A8B
            lda L00EA
            sbc FPTMP5,Y
            sta L00EA
            lda L00E9
            sbc FPTMP4,Y
            sta L00E9
            lda L00E8
            sbc FPTMP3,Y
            sta L00E8
            lda L00E7
            sbc FPTMP2,Y
            sta L00E7
            lda L00E6
            sbc FPTMP1,Y
            sta L00E6
            lda FR1+5
            sbc FPTMP0,Y
            sta FR1+5
L2A8B       rol L00DA
            iny
            cpy #$08
            bne L2A30
FDIVEND     jmp NORMDIVMUL

FDIVSKP0    rol FR0+1,X ; Skip if remainder is 0 at end of FDIV
            iny
            cpy #$08
            bne FDIVSKP0
            beq FDIVEND

EXPAND_POW2 sed
            clc
            lda FR1+5
            sta FPTMP5+7
            adc FR1+5
            sta FPTMP5+6
            lda FR1+4
            sta FPTMP4+7
            adc FR1+4
            sta FPTMP4+6
            lda FR1+3
            sta FPTMP3+7
            adc FR1+3
            sta FPTMP3+6
            lda FR1+2
            sta FPTMP2+7
            adc FR1+2
            sta FPTMP2+6
            lda FR1+1
            sta FPTMP1+7
            adc FR1+1
            sta FPTMP1+6
            lda #$00
            sta FPTMP0+7
            adc #$00
            sta FPTMP0+6
            ldx #$02
L2ADE       lda FPTMP5+4,X
            adc FPTMP5+4,X
            sta FPTMP5+3,X
            lda FPTMP4+4,X
            adc FPTMP4+4,X
            sta FPTMP4+3,X
            lda FPTMP3+4,X
            adc FPTMP3+4,X
            sta FPTMP3+3,X
            lda FPTMP2+4,X
            adc FPTMP2+4,X
            sta FPTMP2+3,X
            lda FPTMP1+4,X
            adc FPTMP1+4,X
            sta FPTMP1+3,X
            lda FPTMP0+4,X
            adc FPTMP0+4,X
            sta FPTMP0+3,X
            dex
            bne L2ADE
            lda FPTMP5+6
            adc FPTMP5+4
            sta FPTMP5+3
            lda FPTMP4+6
            adc FPTMP4+4
            sta FPTMP4+3
            lda FPTMP3+6
            adc FPTMP3+4
            sta FPTMP3+3
            lda FPTMP2+6
            adc FPTMP2+4
            sta FPTMP2+3
            lda FPTMP1+6
            adc FPTMP1+4
            sta FPTMP1+3
            lda FPTMP0+6
            adc FPTMP0+4
            sta FPTMP0+3
            ldx #$02
L2B4F       lda FPTMP5+1,X
            adc FPTMP5+1,X
            sta FPTMP5,X
            lda FPTMP4+1,X
            adc FPTMP4+1,X
            sta FPTMP4,X
            lda FPTMP3+1,X
            adc FPTMP3+1,X
            sta FPTMP3,X
            lda FPTMP2+1,X
            adc FPTMP2+1,X
            sta FPTMP2,X
            lda FPTMP1+1,X
            adc FPTMP1+1,X
            sta FPTMP1,X
            lda FPTMP0+1,X
            adc FPTMP0+1,X
            sta FPTMP0,X
            dex
            bpl L2B4F
            lda FR0+1
            sta FR1+1
            lda FR0+2
            sta FR1+2
            lda FR0+3
            sta FR1+3
            lda FR0+4
            sta FR1+4
            lda FR0+5
            sta FR1+5

T_ZFR0      lda #$00
            sta FR0
            sta FR0+1
            sta FR0+2
            sta FR0+3
            sta FR0+4
            sta FR0+5
            rts

; Initializes INBUFF to $0580
T_LDBUFA    lda #>LBUFF
            sta INBUFF+1
            lda #<LBUFF
            sta INBUFF
            rts

T_SKPSPC    inc PORTB
            jsr SKPSPC
            dec PORTB
            rts

T_FASC      inc PORTB
            jsr FASC
            dec PORTB
            rts

T_AFP       inc PORTB
            jsr AFP
            dec PORTB
            rts

T_GETDIGIT  ldy CIX
            lda (INBUFF),Y
            sec
            sbc #$30
            cmp #$0A
            rts

T_IFP       ldy FR0
            lda FR0+1
            sta L00F7
            jsr T_ZFR0
            sed
            tya
            beq L2C17
            lsr
            lsr
            lsr
            lsr
            sta L00F8
            tya
            and #$07
            ldy #$00
            bcc L2BF8
            adc #$0007
L2BF8       lsr L00F8
            bcc L2BFE
            adc #$0015
L2BFE       lsr L00F8
            bcc L2C04
            adc #$0031
L2C04       lsr L00F8
            bcc L2C0D
            adc #$0063
            bcc L2C0D
            iny
L2C0D       lsr L00F8
            bcc L2C17
            adc #<$0127
            iny
            bcc L2C17
            iny
L2C17       ldx L00F7
            beq L2C8A
            lsr L00F7
            bcc L2C26
            adc #<$0255
            iny
            iny
            bcc L2C26
            iny
L2C26       lsr L00F7
            bcc L2C32
            adc #<$0511
            tax
            tya
            adc #>$0511
            tay
            txa
L2C32       lsr L00F7
            bcc L2C3E
            adc #<$1023
            tax
            tya
            adc #>$1023
            tay
            txa
L2C3E       lsr L00F7
            bcc L2C4A
            adc #<$2047
            tax
            tya
            adc #>$2047
            tay
            txa
L2C4A       lsr L00F7
            bcc L2C56
            adc #<$4095
            tax
            tya
            adc #>$4095
            tay
            txa
L2C56       lsr L00F7
            bcc L2C66
            adc #<$8191
            tax
            tya
            adc #>$8191
            tay
            txa
            bcc L2C66
            inc FR0+1
L2C66       lsr L00F7
            bcc L2C78
            adc #<$6383 ; $16383
            tax
            tya
            adc #>$6383 ; $16383
            tay
            lda FR0+1
            adc #$01    ; $16383
            sta FR0+1
            txa
L2C78       lsr L00F7
            bcc L2C8A
            adc #<$2767 ; $32737
            tax
            tya
            adc #>$2767 ; $32767
            tay
            lda FR0+1
            adc #$03    ; $32767
            sta FR0+1
            txa
L2C8A       sty FR0+2
            sta FR0+3
            lda #$42
            sta FR0
            jmp NORMALIZE

RET_CLC2    clc
            rts

T_FSUB      lda FR1
            eor #$80
            sta FR1

T_FADD      lda FR1
            and #$7F
            beq RET_CLC2
            sta L00F7
            lda FR0
            and #$7F
            sec
            sbc L00F7
            bcs L2CE1
            lda FR0
            ldy FR1
            sta FR1
            sty FR0
            lda FR0+1
            ldy FR1+1
            sta FR1+1
            sty FR0+1
            lda FR0+2
            ldy FR1+2
            sta FR1+2
            sty FR0+2
            lda FR0+3
            ldy FR1+3
            sta FR1+3
            sty FR0+3
            lda FR0+4
            ldy FR1+4
            sta FR1+4
            sty FR0+4
            lda FR0+5
            ldy FR1+5
            sta FR1+5
            sty FR0+5
            jmp T_FADD
L2CE1       tay
            beq L2D2F
            dey
            beq L2D1D
            dey
            beq L2D0C
            dey
            beq L2CFD
            dey
            bne RET_CLC2
            lda FR1+1
            sta FR1+5
            sty FR1+4
            sty FR1+3
            sty FR1+2
            jmp L2D2D
L2CFD       lda FR1+2
            sta FR1+5
            lda FR1+1
            sta FR1+4
            sty FR1+3
            sty FR1+2
            jmp L2D2D
L2D0C       lda FR1+3
            sta FR1+5
            lda FR1+2
            sta FR1+4
            lda FR1+1
            sta FR1+3
            sty FR1+2
            jmp L2D2D
L2D1D       lda FR1+4
            sta FR1+5
            lda FR1+3
            sta FR1+4
            lda FR1+2
            sta FR1+3
            lda FR1+1
            sta FR1+2
L2D2D       sty FR1+1
L2D2F       sed
            lda FR0
            eor FR1
            bmi L2D70
            clc
            lda FR0+5
            adc FR1+5
            sta FR0+5
            lda FR0+4
            adc FR1+4
            sta FR0+4
            lda FR0+3
            adc FR1+3
            sta FR0+3
            lda FR0+2
            adc FR1+2
            sta FR0+2
            lda FR0+1
            adc FR1+1
            sta FR0+1
            bcc L2D6D
            lda FR0+4
            sta FR0+5
            lda FR0+3
            sta FR0+4
            lda FR0+2
            sta FR0+3
            lda FR0+1
            sta FR0+2
            lda #$01
            sta FR0+1
            inc FR0
L2D6D       jmp NORMALIZE

L2D70       sec
            lda FR0+5
            sbc FR1+5
            sta FR0+5
            lda FR0+4
            sbc FR1+4
            sta FR0+4
            lda FR0+3
            sbc FR1+3
            sta FR0+3
            lda FR0+2
            sbc FR1+2
            sta FR0+2
            lda FR0+1
            sbc FR1+1
            sta FR0+1
            bcs NORMALIZE
            lda FR0
            eor #$80
            sta FR0
            sec
            tya
            sbc FR0+5
            sta FR0+5
            tya
            sbc FR0+4
            sta FR0+4
            tya
            sbc FR0+3
            sta FR0+3
            tya
            sbc FR0+2
            sta FR0+2
            tya
            sbc FR0+1
            sta FR0+1
            jmp NORMALIZE

NORMDIVMUL  ldx L00DA
            bne L2DBA

NORMALIZE   ldx #$00
L2DBA       cld
            ldy FR0
            beq L2E2C
            lda FR0+1
            bne L2E1F
            dey
            lda FR0+2
            bne L2E0F
            dey
            lda FR0+3
            bne L2DFD
            dey
            lda FR0+4
            bne L2DED
            dey
            lda FR0+5
            bne L2DDF
            dey
            txa
            beq L2E2C
            sta FR0+1
            bne L2E1F
L2DDF       sta FR0+1
            stx FR0+2
            lda #$00
            sta FR0+5
            sta FR0+4
            sta FR0+3
            beq L2E1F
L2DED       sta FR0+1
            lda FR0+5
            sta FR0+2
            stx FR0+3
            lda #$00
            sta FR0+5
            sta FR0+4
            beq L2E1F
L2DFD       sta FR0+1
            lda FR0+4
            sta FR0+2
            lda FR0+5
            sta FR0+3
            stx FR0+4
            lda #$00
            sta FR0+5
            beq L2E1F
L2E0F       sta FR0+1
            lda FR0+3
            sta FR0+2
            lda FR0+4
            sta FR0+3
            lda FR0+5
            sta FR0+4
            stx FR0+5
L2E1F       sty FR0
            tya
            and #$7F
            cmp #$71
            bcs L2E30
            cmp #$0F
            bcs L2E2F
L2E2C       jsr T_ZFR0
L2E2F       clc
L2E30       rts

T_PLYEVL    stx L00FC
            sty L00FD
            sta L00EF
            jsr FMOVPLYARG
            jsr T_FLD1P
            dec L00EF
L2E3F       jsr T_FMUL
            bcs L2E7B
            lda L00FC
            adc #$06
            sta L00FC
            bcc L2E4E
            inc L00FD
L2E4E       jsr T_FLD1P
            jsr T_FADD
            bcs L2E7B
            dec L00EF
            beq L2E7B
            lda PLYARG
            sta FR1
            lda PLYARG+1
            sta FR1+1
            lda PLYARG+2
            sta FR1+2
            lda PLYARG+3
            sta FR1+3
            lda PLYARG+4
            sta FR1+4
            lda PLYARG+5
            sta FR1+5
            jmp L2E3F
L2E7B       rts

T_FLD1P     ldy #$05
            lda (L00FC),Y
            sta FR1+5
            dey
            lda (L00FC),Y
            sta FR1+4
            dey
            lda (L00FC),Y
            sta FR1+3
            dey
            lda (L00FC),Y
            sta FR1+2
            dey
            lda (L00FC),Y
            sta FR1+1
            dey
            lda (L00FC),Y
            sta FR1
            rts

            ; Move FR0 to FR1
T_FMOVE     lda FR0
            sta FR1
            lda FR0+1
            sta FR1+1
            lda FR0+2
            sta FR1+2
            lda FR0+3
            sta FR1+3
            lda FR0+4
            sta FR1+4
            lda FR0+5
            sta FR1+5
            rts

            ; Move FR0 to PLYARG
FMOVPLYARG  lda FR0
            sta PLYARG+0
            lda FR0+1
            sta PLYARG+1
            lda FR0+2
            sta PLYARG+2
            lda FR0+3
            sta PLYARG+3
            lda FR0+4
            sta PLYARG+4
            lda FR0+5
            sta PLYARG+5
            rts

            ; Move FR0 to FPSCR
FMOVSCR     lda FR0
            sta FPSCR+0
            lda FR0+1
            sta FPSCR+1
            lda FR0+2
            sta FPSCR+2
            lda FR0+3
            sta FPSCR+3
            lda FR0+4
            sta FPSCR+4
            lda FR0+5
            sta FPSCR+5
            rts

            ; Load FR0 from PLYARG
LDPLYARG    ldx #$00
            jmp LD_PLY_X

            ; Load FR0 from FPSCR
LDFPSCR     ldx #$06
            jmp LD_PLY_X

            ; Load FR0 from FPSCR1
LDFPSCR1    ldx #$0C
LD_PLY_X    lda PLYARG+0,X
            sta FR0
            lda PLYARG+1,X
            sta FR0+1
            lda PLYARG+2,X
            sta FR0+2
            lda PLYARG+3,X
            sta FR0+3
            lda PLYARG+4,X
            sta FR0+4
            lda PLYARG+5,X
            sta FR0+5
            rts

            ; Load FR1 from FPSCR1
LD1FPSCR1   ldx #$0C
            jmp LD1_PLY_X

            ; Load FR1 from FPSCR
LD1FPSCR    ldx #$06
LD1_PLY_X   lda PLYARG+0,X
            sta FR1
            lda PLYARG+1,X
            sta FR1+1
            lda PLYARG+2,X
            sta FR1+2
            lda PLYARG+3,X
            sta FR1+3
            lda PLYARG+4,X
            sta FR1+4
            lda PLYARG+5,X
            sta FR1+5
L2F43       rts

            ; Calculate FR0 = EXP(FR0)
            ; $DDC0 in original mathpack
T_FEXP      ldx #$05
            inc PORTB
L2F49       lda LDE89,X
            sta FR1,X
            dex
            bpl L2F49
            dec PORTB
            jsr T_FMUL
            bcs L2F43

            ; Calculate FR0 = EXP10(FR0)
            ; $DDCC in original mathpack
T_EXP10     lda #$00
            sta L00F1
            lda FR0
            sta L00F0
            and #$7F
            sta FR0
            cmp #$40
            bcc L2F87
            bne L2F43
            lda FR0+1
            and #$F0
            lsr
            sta L00F1
            lsr
            lsr
            adc L00F1
            sta L00F1
            lda FR0+1
            and #$0F
            adc L00F1
            sta L00F1
            lda #$00
            sta FR0+1
            jsr NORMALIZE
L2F87       lda #$0A
            ldx #<P10COF
            ldy #>P10COF
            inc PORTB
            jsr T_PLYEVL
            dec PORTB
            jsr T_FSQ
            lda L00F1
            beq L2FAC
            lsr
            clc
            adc FR0
            bmi L2FB9
            sta FR0
            lsr L00F1
            bcc L2FAC
            jsr L329B
L2FAC       asl L00F0
            bcc L2FBA
            jsr T_FMOVE
            jsr T_FLD1
            jmp T_FDIV
L2FB9       sec
L2FBA       rts

T_FLD1      lda #$40
            sta FR0
            ldy #$01
            sty FR0+1
            dey
            sty FR0+2
            sty FR0+3
            sty FR0+4
            sty FR0+5
            rts

            ; Compute FR0 = (FR0 - C) / (FR1 + C)
            ; with C in [X:Y]
            ; $DE95 in original mathpack
REDRNG      stx L00FC
            sty L00FD
            jsr FMOVPLYARG
            jsr T_FLD1P
            jsr T_FADD
            jsr FMOVSCR
            jsr LDPLYARG
            jsr T_FLD1P
            jsr T_FSUB
            jsr LD1FPSCR
            jmp T_FDIV
RTS_SEC3    sec
            rts

            ; Compute FR0 = LN(FR0)
            ; $DECD in orignal mathpack
T_FLOG      lda #$05
            bne L2FF4

            ; Compute FR0 = LOG_10(FR0)
            ; $DED1 in orignal mathpack
T_FCLOG     lda #$00
L2FF4       sta L00F0
            lda FR0
            bmi RTS_SEC3
            beq RTS_SEC3
            asl
            eor #$80
            sta L00F1
            lda #$40
            sta FR0
            lda FR0+1
            and #$F0
            beq L3010
            inc L00F1
            jsr L32A3
L3010       ldx #<SQR10
            ldy #>SQR10
            inc PORTB
            jsr REDRNG
            jsr FMOVSCR
            jsr T_FSQ
            lda #$0A
            ldx #<LGCOEF
            ldy #>LGCOEF
            jsr T_PLYEVL
            dec PORTB
            jsr LD1FPSCR
            jsr T_FMUL
            lda #$3F
            sta FR1
            lda #$50
            sta FR1+1
            lda #$00
            sta FR1+2
            sta FR1+3
            sta FR1+4
            sta FR1+5
            jsr T_FADD
            jsr T_FMOVE
            lda L00F1
            bpl L3053
            clc
            eor #$FF
            adc #$01
L3053       sta FR0
            lda #$00
            sta FR0+1
            jsr T_IFP
            lda L00F1
            and #$80
            ora FR0
            sta FR0
            jsr T_FADD
            ldx L00F0
            beq RTS_CLC
            inc PORTB
L306E       lda LDE89,X
            sta FR1,X
            dex
            bpl L306E
            dec PORTB
            jmp T_FDIV
RTS_CLC     clc
            rts
RTS_SEC2    sec
            rts

T_FSIN      lda #$04    ; Positive SIN
            bit FR0
            bpl SINCOS
            lda #$02    ; Negative SIN
            bne SINCOS

T_FCOS      lda #$01    ; Positive/Negative COS

SINCOS      sta L00F0
            ; Get absolute value of FR0
            lda FR0
            and #$7F
            sta FR0
            ; And divide by 90° or PI/2
            ldx DEGFLAG
            lda F_PI2,X
            sta FR1
            lda F_PI2+1,X
            sta FR1+1
            lda F_PI2+2,X
            sta FR1+2
            lda F_PI2+3,X
            sta FR1+3
            lda F_PI2+4,X
            sta FR1+4
            lda F_PI2+5,X
            sta FR1+5
            jsr T_FDIV
            bcs RTS_SEC2
            ; Extract integer/fractional parts
            lda FR0
            and #$7F
            sec
            sbc #$40
            bmi L30E6   ; Less than 1.0, already have fractional part
            cmp #$04
            bpl RTS_SEC2        ; More than 100000000, error
            tax
            lda FR0+1,X         ; Get lower two digits
            sta L00F1           ; Calculate (10*A+B) MOD 4 == ((A MOD 2)*2 + B) MOD 4
            and #$10
            beq L30D1
            lda #$02
L30D1       clc
            adc L00F1
            and #$03            ; We now have te quadrant
            adc L00F0           ; Add starting quadrant from the start
            sta L00F0
            stx L00F1
            lda #$00
L30DE       sta FR0+1,X         ; Set integer part to 0
            dex
            bpl L30DE
            jsr NORMALIZE       ; And normalize FP number

L30E6       lsr L00F0           ; Check odd quadrants, and compute FR0 = (1-FR0)
            bcc L30F3
            jsr T_FMOVE
            jsr T_FLD1
            jsr T_FSUB

L30F3       jsr FMOVSCR         ; Store FR0 into FPSCR
            jsr T_FSQ           ; And get FR0^2
            bcs RTS_SEC2
            lda #$06
            ldx #<SCOEF
            ldy #>SCOEF
            jsr T_PLYEVL        ; Evaluate polynomial in X^2
            jsr LD1FPSCR
            jsr T_FMUL          ; Multiply by original X
            lsr L00F0           ; Check quadrant to negate result
            bcc L3117
            clc
            lda FR0
            beq L3117
            eor #$80
            sta FR0
L3117       rts

SCOEF       .fl -3.551499391e-6
            .fl 1.60442752e-4
            .fl -4.6817543551e-3
            .byte $3F,$07,$96,$92,$62,$39 ; .fl 7.96926239e-2 ; MADS error
            .fl -6.459640867e-1
F_PI2       .fl 1.570796326  ; used in RAD mode
            .fl 90           ; used in DEG mode
F_1DEG      .byte $3f, $01, $74, $53, $29, $25 ; = PI / 180
            ;.fl 0.01745329251994 ; can't make mads produce the last digit!!!
T_FATN      lda #$00
            sta L00F0
            sta L00F1
            lda FR0
            and #$7F
            cmp #$40
            bmi L3171
            lda FR0
            and #$80
            sta L00F0
            inc L00F1
            lda #$7F
            and FR0
            sta FR0
            ldx #<FP9S
            ldy #>FP9S
            inc PORTB
            jsr REDRNG
            dec PORTB
L3171       jsr FMOVSCR
            jsr T_FSQ
            bcs L31C0
            lda #$0B
            ldx #<ATNCOEF
            ldy #>ATNCOEF
            inc PORTB
            jsr T_PLYEVL
            dec PORTB
            bcs L31C0
            jsr LD1FPSCR
            jsr T_FMUL
            bcs L31C0
            lda L00F1
            beq L31AF
            ldx #$05
            inc PORTB
L319B       lda FP_PI4,X
            sta FR1,X
            dex
            bpl L319B
            dec PORTB
            jsr T_FADD
            lda L00F0
            ora FR0
            sta FR0
L31AF       lda DEGFLAG
            beq L31C0
            ldx #$05
L31B5       lda F_1DEG,X
            sta FR1,X
            dex
            bpl L31B5
            jsr T_FDIV
L31C0       rts
L31C1       sec
            rts
L31C3       clc
            rts

T_FSQRT     lda #$00
            sta L00F1
            lda FR0
            bmi L31C1
            beq L31C3
            cmp #$3F
            beq L31D8
            clc
            adc #$01
            sta L00F1
L31D8       lda #$06
            sta L00EF
            lda #$3F
            sta FR0
            jsr FMOVSCR
            jsr T_FMOVE
            jsr T_FLD1
            inc FR0+1
            jsr T_FSUB
            jsr LD1FPSCR
            jsr T_FMUL
L31F4       lda FR0
            sta FPSCR1+0
            lda FR0+1
            sta FPSCR1+1
            lda FR0+2
            sta FPSCR1+2
            lda FR0+3
            sta FPSCR1+3
            lda FR0+4
            sta FPSCR1+4
            lda FR0+5
            sta FPSCR1+5
            jsr T_FMOVE
            jsr LDFPSCR
            jsr T_FDIV
            jsr LD1FPSCR1
            jsr T_FSUB
            jsr L324F
            lda FR0
            beq L3234
            jsr LD1FPSCR1
            jsr T_FADD
            dec L00EF
            bpl L31F4
            bmi L3237
L3234       jsr LDFPSCR1
L3237       lda L00F1
            beq L324A
            lsr
            clc
            adc FR0
            sbc #$1F
            sta FR0
            lsr L00F1
            bcc L324A
            jsr L329B
L324A       clc
            rts
L324C       jmp T_ZFR0
L324F       lda FR0
            and #$7F
            cmp #$0F
            bcc L324C
            jsr T_FMOVE
            sed
            ldx #$00
            ldy #$04
            clc
L3260       lda FR0+5
            adc FR1+5
            sta FR0+5
            lda FR0+4
            adc FR1+4
            sta FR0+4
            lda FR0+3
            adc FR1+3
            sta FR0+3
            lda FR0+2
            adc FR1+2
            sta FR0+2
            lda FR0+1
            adc FR1+1
            sta FR0+1
            txa
            adc #$00
            tax
            dey
            bne L3260
            cld
            txa
            beq L32A3
            lda FR0+4
            sta FR0+5
            lda FR0+3
            sta FR0+4
            lda FR0+2
            sta FR0+3
            lda FR0+1
            sta FR0+2
            stx FR0+1
L329B       lda FR0+1
            cmp #$10
            bcc L32D2
            inc FR0
L32A3       lda FR0+1
            cmp #$10
            bcc L32D0
            lsr
            ror FR0+2
            ror FR0+3
            ror FR0+4
            ror FR0+5
            lsr
            ror FR0+2
            ror FR0+3
            ror FR0+4
            ror FR0+5
            lsr
            ror FR0+2
            ror FR0+3
            ror FR0+4
            ror FR0+5
            lsr
            ror FR0+2
            ror FR0+3
            ror FR0+4
            ror FR0+5
            sta FR0+1
            rts
L32D0       dec FR0
L32D2       lda #$00
            asl FR0+5
            rol FR0+4
            rol FR0+3
            rol FR0+2
            rol FR0+1
            rol
            asl FR0+5
            rol FR0+4
            rol FR0+3
            rol FR0+2
            rol FR0+1
            rol
            asl FR0+5
            rol FR0+4
            rol FR0+3
            rol FR0+2
            rol FR0+1
            rol
            asl FR0+5
            rol FR0+4
            rol FR0+3
            rol FR0+2
            rol FR0+1
            rol
            rts
L3301       cmp #$FF
            bcc L3307
            cpy #$50
L3307       txa
            adc #$00
            sta FR0
            rts
L330D       tya
            and #$F0
            lsr
            sta FR0
            lsr
            lsr
            adc FR0
            sta FR0
            tya
            and #$0F
            ldx FR0+2
            cpx #$50
            adc FR0
            sta FR0
            rts
T_FPI       ldx #$00
            ldy FR0+1
            lda FR0
            stx FR0+1
            sec
            sbc #$40
            bcc L3301
            beq L330D
            cmp #$02
            beq L337D
            bcs L337C
            lda FR0+2
            and #$F0
            lsr
            sta FR0
            lsr
            lsr
            adc FR0
            sta FR0
            lda FR0+2
            and #$0F
            ldx FR0+3
            cpx #$50
            adc FR0
            sta FR0
L3353       tya
            and #$0F
            tax
            lda X100L,X
            adc FR0
            sta FR0
            lda X100H,X
            adc FR0+1
            sta FR0+1
            tya
            and #$F0
            beq L337C
            lsr
            lsr
            lsr
            tax
            lda FR0
            adc X1000-2,X
            sta FR0
            lda FR0+1
            adc X1000-1,X
            sta FR0+1
L337C       rts
L337D       cpy #$07
            bcs L337C
            lda FR0+3
            and #$F0
            lsr
            sta FR0
            lsr
            lsr
            adc FR0
            sta FR0
            lda FR0+3
            and #$0F
            ldx FR0+4
            cpx #$50
            adc FR0
            sta FR0
            lda X10000L,Y
            adc FR0
            sta FR0
            lda X10000H,Y
            adc FR0+1
            sta FR0+1
            ldy FR0+2
            bne L3353
            rts
X10000L     .byte <0,<10000,<20000,<30000,<40000,<50000,<60000
X10000H     .byte >0,>10000,>20000,>30000,>40000,>50000,>60000
X1000       .word 1000,2000,3000,4000,5000,6000,7000,8000,9000
X100L       .byte <0,<100,<200,<300,<400,<500,<600,<700,<800,<900
X100H       .byte >0,>100,>200,>300,>400,>500,>600,>700,>800,>900

ERR_3H      jmp ERR_3

X_RENUM     jsr X_GS
            jsr GET3INT
            sta L00A2
            sty L00A3
            ora L00A3
            beq ERR_3H
            tya
            ora L009A
            ora L009C
            bmi ERR_3H
            lda L0099
            sta TSLNUM
            lda L009A
            sta TSLNUM+1
            jsr SEARCHLINE
            lda STMCUR
            sta FR1+2
            lda STMCUR+1
            sta FR1+3
            lda #$80
            sta FR0+1
            asl
            sta FR0
            jsr L350E
            bmi ERR_3H
            lda STMTAB+1
            sta STMCUR+1
            lda STMTAB
L341E       sta STMCUR
            ldy #$01
            lda (STMCUR),Y
            bmi L346A
            iny
            lda (STMCUR),Y
            sta LLNGTH
            iny
L342C       lda (STMCUR),Y
            sta NXTSTD
            iny
            sty STINDEX
            lda (STMCUR),Y
            cmp #TOK_GOTO
            beq L3443
            cmp #TOK_GO_TO
            beq L3443
            cmp #TOK_GOSUB
            beq L3443
            cmp #TOK_TRAP
L3443       beq L34AE
            cmp #TOK_ON
            beq L34B4
            cmp #TOK_RESTORE
            beq L34A7
            cmp #TOK_IF
            beq L349E
            cmp #TOK_LIST
            beq L34C0
            cmp #TOK_DEL
            beq L34C0
L3459       ldy NXTSTD
            cpy LLNGTH
            bcc L342C
            clc
            lda STMCUR
            adc LLNGTH
            bcc L341E
            inc STMCUR+1
            bcs L341E
L346A       lda FR1+3
            sta STMCUR+1
            lda FR1+2
L3470       sta STMCUR
            ldy #$01
            lda (STMCUR),Y
            bmi L3498
            lda L009C
            sta (STMCUR),Y
            dey
            lda L009B
            sta (STMCUR),Y
            clc
            adc L00A2
            sta L009B
            lda L009C
            adc L00A3
            sta L009C
            ldy #$02
            lda (STMCUR),Y
            adc STMCUR
            bcc L3470
            inc STMCUR+1
            bcs L3470
L3498       jsr GEN_LNHASH
            jmp POP_RETURN

L349E       jsr SKIPTOK
            cpx #CTHEN
            bne L3459
            dec STINDEX
L34A7       ldy STINDEX
            iny
            cpy NXTSTD
            bcs L3459
L34AE       jsr L34D5
            jmp L3459

L34B4       jsr SKIPTOK
            cpx #CGTO
            beq L34C2
            cpx #CGS
            bne L3459
            .byte $2C   ; Skip 2 bytes
L34C0       inc STINDEX
L34C2       lda STINDEX
            cmp NXTSTD
            bcs L3459
            pha
            jsr L34D7
            pla
            sta STINDEX
            jsr SKPCTOK
            jmp L34C2
L34D5       inc STINDEX
L34D7       ldy STINDEX
            sty L00DC
            lda (STMCUR),Y
            beq L350D
            cmp #$0F
            bcs L350D
            jsr GETTOK
            jsr T_FPI
            lda FR0+1
            bmi L350D
            bcs L350D
            jsr L350E
            php
            bcs L34F9
            sta FR0
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
L350D       rts
L350E       lda FR0
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
            lda L009B
            sta FR1
            lda L009C
L352B       sta FR1+1
            ldy #$01
            lda (L00DA),Y
            bmi L3560
            cmp FR0+1
            bne L353C
            dey
            lda (L00DA),Y
            cmp FR0
L353C       bcs L355D
            ldy #$02
            lda (L00DA),Y
            adc L00DA
            sta L00DA
            bcc L354A
            inc L00DB
L354A       dey
            lda (L00DA),Y
            bmi L3560
            clc
            lda FR1
            adc L00A2
            sta FR1
            lda FR1+1
            adc L00A3
            jmp L352B
L355D       clc
            beq L3561
L3560       sec
L3561       lda FR1
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

X_BLOAD     lda #$00
            .byte $2C   ; Skip 2 bytes
X_BRUN      lda #$80
            sta BLOADFLAG
            lda #<LOW_RTS
            ldy #>LOW_RTS
            sta RUNAD
            sty RUNAD+1
            lda #$04
            ldy #$01
            jsr OPEN_Y_CHN
            inc PORTB
            jsr BGET_WORD
            cmp #$FF
            bne BL_ERR_1
            iny
            bne BL_ERR_1
L359A       lda #<LOW_RTS
            ldy #>LOW_RTS
            sta INITAD
            sty INITAD+1
            jsr BGET_WORD
            cmp #$FF
            bne L35AF
            cpy #$FF
            beq L359A
L35AF       sta IOCB0+ICBAL,X
            tya
            sta IOCB0+ICBAH,X
            jsr BGET_WORD
            sec
            sbc IOCB0+ICBAL,X
            sta IOCB0+ICBLL,X
            tya
            sbc IOCB0+ICBAH,X
            sta IOCB0+ICBLH,X
            inc IOCB0+ICBLL,X
            bne L35CF
            inc IOCB0+ICBLH,X
L35CF       jsr CIOV
            tya
            bmi BL_ERR_A
            jsr JSR_INITAD
            lda IOCB1+ICSTA
            cmp #$03
            bne L359A
            ldx #$10
            lda #$0C
            sta IOCB0+ICCOM,X
            jsr CIOV
            bit BLOADFLAG
            bpl L35F1
            jsr JSR_RUNAD
L35F1       lda #$FE
            sta PORTB
LOW_RTS     rts
BL_ERR_1    lda #$01
BL_ERR_A    tay
BL_ERR_Y    jsr DISROM
            tya
            jmp X_ERR

JSR_INITAD  jmp (INITAD)

JSR_RUNAD   jmp (RUNAD)

BGET_WORD   lda #$07
            ldx #$10
            sta IOCB0+ICCOM,X
            lda #$00
            sta IOCB0+ICBLL,X
            sta IOCB0+ICBLH,X
            jsr CIOV
            bmi BL_ERR_Y
            pha
            lda #$00
            sta IOCB0+ICBLL,X
            jsr CIOV
            bmi BL_ERR_Y
            tay
            pla
            rts

; This is the end of low memory use
TOP_LOWMEM

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Loader for the RAM under ROM parts and initialization, this will be
; erased on first run
;
            org TBXL_ROMLOADER

INIT        ldx KEYBDV+4
            ldy KEYBDV+5
            inx
            bne L600A
            iny
L600A       stx JSR_GETKEY+1
            sty JSR_GETKEY+2
            lda #$00
            sta NMIEN
            sei
            lda #$FE
            sta PORTB
            lda #<NMI_PROC
            sta NMI_VEC
            lda #>NMI_PROC
            sta NMI_VEC+1
            lda #<IRQ_PROC
            sta IRQ_VEC
            lda #>IRQ_PROC
            sta IRQ_VEC+1
            lda #>$CC00
            jsr ROM2RAM
            lda #>$E000
            jsr ROM2RAM
            lda #$40
            sta NMIEN
            cli
            ; Activate ROM and load rest of file
            lda #$FF
            sta PORTB
            jsr LOAD_BLOCK

            lda #$00
            sta BOOT
            lda DOSINI
            ldy DOSINI+1
            sta JMPDOS+1
            sty JMPDOS+2
            lda #<RESET_V
            ldy #>RESET_V
            sta DOSINI
            sty DOSINI+1
            lda #$FE
            sta PORTB
            sta LOADFLG
            ldx #$01
            stx BASICF
            stx BOOT
            dex
            stx COLDST
            jsr INIT_MEM
            lda #$00
            sta TSLNUM
            sta TSLNUM+1
            jsr SRCHLN_NC

            ; Insert startup program, open "E:" and run
            ldy #ARUN_LEN
            ldx #STMCUR
            jsr EXPLOW
            ldy #ARUN_LEN-1
L6084       lda ARUN_PROG,Y
            sta (L0097),Y
            dey
            bpl L6084
            jsr GEN_LNHASH
            lda #>(EXECNL-1)
            pha
            lda #<(EXECNL-1)
            pha
            jsr OPEN_EDITR
            dec PORTB
            lda #$00
            tay
L609E       sta LB000,Y
            dey
            bpl L609E
            jmp RUN_NOFILE

ARUN_PROG
            ; This is:
            ;  0 TRAP %1 : RUN "D:AUTORUN.BAS"
            ;  1 NEW
            .word 0
            .byte $19,$07,TOK_TRAP,CN1,CEOS
            .byte $19, TOK_RUN,$0F,$0D,'D:AUTORUN.BAS', CCR
            .word 1
            .byte $06,$06,TOK_NEW,CCR
ARUN_LEN    = * - ARUN_PROG

OPEN_EDITR  lda #$FF
            sta PORTB
            lda #>$C000
            sta RAMTOP
            lsr
            sta APPMHI+1
            lda EDITRV+1
            pha
            lda EDITRV
            pha
            rts

ROM2RAM     sta FR0+1
            ldy #$00
            sty FR0
            ldx #$04
L60E3       lda #$FF
            sta PORTB
L60E8       lda (FR0),Y
            sta VARSTK0,Y
            iny
            bne L60E8
            dec PORTB
L60F3       lda VARSTK0,Y
            sta (FR0),Y
            iny
            bne L60F3
            inc FR0+1
            dex
            bne L60E3
            rts

            ; Load 4 bytes (block header) from file
            ;  FR0+2/FR0+3 : START_ADDR
            ;  FR0+4/FR0+5 : END_ADDR
LOAD_BLOCK  ldx #$10
            lda #(FR0+2)
            sta IOCB0+ICBAL,X
            lda #$00
            sta IOCB0+ICBAH,X
            sta IOCB0+ICBLH,X
            lda #$04
            sta IOCB0+ICBLL,X
            lda #$07
            sta IOCB0+ICCOM,X
            jsr CIOV
            bmi LOAD_END

            ; Load block data to buffer
            lda #<LOAD_BUFFER
            sta L00DA
            sta IOCB0+ICBAL,X
            lda #>LOAD_BUFFER
            sta L00DB
            sta IOCB0+ICBAH,X
            ; Calculate length: LEN = END-START+1
            lda FR0+4
            sbc FR0+2
            sta L00DC
            lda FR0+5
            sbc FR0+3
            sta L00DD
            inc L00DC
            bne L613F
            inc L00DD
L613F       lda L00DC
            sta IOCB0+ICBLL,X
            lda L00DD
            sta IOCB0+ICBLH,X
            jsr CIOV
            bmi LOAD_ERROR

            ; Now, copy block to real location in RAM under ROM
            dec PORTB
            ldy #$00
            ldx L00DD
            beq L6165
L6157       lda (L00DA),Y
            sta (FR0+2),Y
            iny
            bne L6157
            inc FR0+3
            inc L00DB
            dex
            bne L6157
L6165       ldx L00DC
            beq L6171
L6169       lda (L00DA),Y
            sta (FR0+2),Y
            iny
            dex
            bne L6169
L6171       lda #$FF
            sta PORTB
            bmi LOAD_BLOCK
LOAD_END    rts
LOAD_ERROR  jmp (DOSVEC)
;
LOAD_BUFFER = *

            ini INIT


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Start of code under ROM, at OS addresses
;
            org $C000

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
            lda L009D
            cmp ENDVVT
            lda L009E
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

X_DSOUND    sta L00A2
            iny
            cpy NXTSTD
            bcs ENDSOUND
            jsr GETBYTE
            ldy #$00
            bit L00A2
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
            bit L00A2
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
            sta (L009D),Y
            iny
            lda ARGSTK1+1,X
            sta (L009D),Y
            iny
            lda ARGSTK2+1,X
            sta (L009D),Y
            iny
            lda ARGSTK3+1,X
            sta (L009D),Y
            iny
            lda ARGSTK4+1,X
            sta (L009D),Y
            iny
            lda ARGSTK5+1,X
            sta (L009D),Y
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
            bpl LC69E
            lda ARSLVL
            sta L00AF
            dec ARSLVL
LC69E       lda COMCNT
            tay
            beq LC6AA
            dec COMCNT
            jsr X_POPINT
            bmi ERR_9_
LC6AA       sty L0098
            sta L0097
            jsr X_POPINT
            bmi ERR_9_
            sta L00F5
            sty L00F6
            jsr X_POPVAL
            bit L00B1
            bvc LC6C6
            lda #$00
            sta L00B1
            rts

ERR_9_      jmp ERR_9

LC6C6       lsr VTYPE
            bcc ERR_9_
            lda L00F5
            cmp FR0+2
            lda L00F6
            sbc FR0+3
            bcs ERR_9_
            lda L0097
            cmp FR0+4
            lda L0098
            sbc FR0+5
            bcs ERR_9_
            lda FR0+5
            bne LC6F2
            ldy FR0+5
            dey
            bne LC6F2
            lda L00F5
            sta L00F7
            lda L00F6
            sta L00F8
            jmp LC714
LC6F2       ldy #$00
            sty L00F7
            sty L00F8
            ldy #$10
LC6FA       lsr FR0+5
            ror FR0+4
            bcc LC70D
            clc
            lda L00F7
            adc L00F5
            sta L00F7
            lda L00F8
            adc L00F6
            sta L00F8
LC70D       asl L00F5
            rol L00F6
            dey
            bne LC6FA
LC714       clc
            lda L0097
            adc L00F7
            sta L00F5
            lda L0098
            adc L00F8
            asl L00F5
            rol
            sta L00F6
            tay
            lda L00F5
            asl
            rol L00F6
            adc L00F5
            tax
            tya
            adc L00F6
            tay
            txa
            adc FR0
            tax
            tya
            adc FR0+1
            tay
            txa
            adc STARP
            sta L00F5
            tya
            adc STARP+1
            sta L00F6
            bit L00B1
            bpl LC775
            ldx L00AF
            stx ARSLVL
            dec ARSLVL
            ldy #$00
            sty L00B1
            lda ARGSTK0,X
            sta (L00F5),Y
            iny
            lda ARGSTK1,X
            sta (L00F5),Y
            iny
            lda ARGSTK2,X
            sta (L00F5),Y
            iny
            lda ARGSTK3,X
            sta (L00F5),Y
            iny
            lda ARGSTK4,X
            sta (L00F5),Y
            iny
            lda ARGSTK5,X
            sta (L00F5),Y
            rts
LC775       inc ARSLVL
            ldx ARSLVL
            ldy #$05
            lda (L00F5),Y
            sta ARGSTK5,X
            dey
            lda (L00F5),Y
            sta ARGSTK4,X
            dey
            lda (L00F5),Y
            sta ARGSTK3,X
            dey
            lda (L00F5),Y
            sta ARGSTK2,X
            dey
            lda (L00F5),Y
            sta ARGSTK1,X
            dey
            lda (L00F5),Y
            sta ARGSTK0,X
            lsr VARSTK0,X
            rts

X_STRLPAREN lda COMCNT
            beq LC7AD
            jsr POPINT_NZ
            sty L0098
            sta L0097
LC7AD       jsr POPINT_NZ
            sec
            sbc #$01
            sta L00F5
            tya
            sbc #$00
            sta L00F6
            jsr X_POPVAL
            lda L00B1
            bpl LC7CC
            ora COMCNT
            sta L00B1
            ldy FR0+5
            lda FR0+4
            jmp LC7D0
LC7CC       lda FR0+2
            ldy FR0+3
LC7D0       ldx COMCNT
            beq LC7E4
            dec COMCNT
            cpy L0098
            bcc LC817
            bne LC7E0
            cmp L0097
            bcc LC817
LC7E0       ldy L0098
            lda L0097
LC7E4       sec
            sbc L00F5
            sta FR0+2
            tax
            tya
            sbc L00F6
            sta FR0+3
            bcc LC817
            tay
            bne LC7F7
            txa
            beq LC817
LC7F7       jsr PTRSTR
            clc
            lda FR0
            adc L00F5
            sta FR0
            lda FR0+1
            adc L00F6
            sta FR0+1
            bit L00B1
            bpl LC80C
RTS_0B      rts

LC80C       jmp X_PUSHVAL

POPINT_NZ   jsr X_POPINT
            bne RTS_0B
            tax
            bne RTS_0B
LC817       lda #$05
            jmp SERROR

X_STRASIGN  jsr X_POPSTR
LC81F       lda FR0
            sta L0099
            lda FR0+1
            sta L009A
            lda FR0+2
            sta L00A2
            ldy FR0+3
            sty L00A3
            ldy OPSTKX
            beq LC842
            lda #$80
            sta L00B1
            jsr EXOPOP
            lda FR0+3
            ldy FR0+2
            rol L00B1
            bcs LC849
LC842       jsr X_POPSTR
            lda FR0+5
            ldy FR0+4
LC849       cmp L00A3
            bcc LC853
            bne LC857
            cpy L00A2
            bcs LC857
LC853       sta L00A3
            sty L00A2
LC857       clc
            lda FR0
            sta L009B
            adc L00A2
            tay
            lda FR0+1
            sta L009C
            adc L00A3
            tax
            sec
            tya
            sbc STARP
            sta L00F9
            txa
            sbc STARP+1
            sta L00FA
            jsr DO_MOVEUP
            lda VNUM
            jsr GETVAR
            sec
            lda L00F9
            sbc FR0
            tay
            lda L00FA
            sbc FR0+1
            tax
            lda #$02
            and L00B1
            beq LC899
            lda #$00
            sta L00B1
            cpx FR0+3
            bcc LC898
            bne LC899
            cpy FR0+2
            bcs LC899
LC898       rts

LC899       sty FR0+2
            stx FR0+3
            jmp RTNVAR

X_DIM       ldy STINDEX
            cpy NXTSTD
            bcc LC8A7
            rts
LC8A7       jsr EXEXPR
            lsr VTYPE
            bcs LC915
            sec
            rol VTYPE
            bmi LC918
            lda L00F5
            adc #$01
            sta L00F5
            sta FR0+2
            lda L00F6
            adc #$00
            bmi LC915
            sta FR0+3
            sta L00F6
            lda L0097
            adc #$01
            sta FR0+4
            lda L0098
            adc #$00
            sta FR0+5
            bmi LC915
            ldy #$00
            sty L00F7
            sty L00F8
            ldy #$10
LC8DB       lda L00F5
            lsr
            bcc LC8EF
            clc
            lda L00F7
            adc FR0+4
            sta L00F7
            lda L00F8
            adc FR0+5
            sta L00F8
            bmi LC915
LC8EF       ror L00F8
            ror L00F7
            ror L00F6
            ror L00F5
            dey
            bne LC8DB
            asl L00F5
            rol L00F6
            bmi LC915
            ldx L00F6
            lda L00F5
            asl
            rol L00F6
            bmi LC915
            adc L00F5
            sta L00F5
            tay
            txa
            adc L00F6
            sta L00F6
            bpl LC92C
LC915       jmp ERR_9
LC918       lda #$00
            sta FR0+2
            sta FR0+3
            ldy L00F5
            sty FR0+4
            lda L00F6
            sta FR0+5
            bne LC92C
            cpy #$00
            beq LC915
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
            ldx L00F6
            beq LC952
LC948       sta (L0097),Y
            iny
            bne LC948
            inc L0098
            dex
            bne LC948
LC952       ldx L00F5
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

LC99D       lda #EVLABEL + EVL_EXEC
            .byte $2C   ; Skip 2 bytes
LC9A0       lda #EVLABEL + EVL_GOS
            tax
            iny
            lda (L0099),Y
            bne LC9AB
            iny
            lda (L0099),Y
LC9AB       eor #$80
            jsr VAR_PTR
            txa
            cmp (L009D),Y
            beq LC9E8
            sta (L009D),Y
            lda L0099
            ldy #$02
            sta (L009D),Y
            iny
            lda L009A
            sta (L009D),Y
            jmp LC9E8

GEN_LNHASH  lda L0099
            pha
            lda L009A
            pha
            lda #$00
            tay
LC9CE       sta (LOMEM),Y
            iny
            iny
            bne LC9CE
            lda STMTAB+1
            sta L009A
            lda STMTAB
LC9DA       sta L0099
            ldy #$04
            lda (L0099),Y
            cmp #TOK_PROC
            beq LC99D
            cmp #TOK_PND
            beq LC9A0
LC9E8       ldy #$01
            lda (L0099),Y
            asl
            bcs LCA0A
            tay
            lda (LOMEM),Y
            bne LC9FD
            lda L009A
            sta (LOMEM),Y
            iny
            lda L0099
            sta (LOMEM),Y
LC9FD       clc
            ldy #$02
            lda (L0099),Y
            adc L0099
            bcc LC9DA
            inc L009A
            bcs LC9DA
LCA0A       lda STMTAB
            sta L0099
            lda STMTAB+1
            sta L009A
            ldy #$00
LCA14       lda (LOMEM),Y
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
            bne LCA14
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
            sta L00F5
            sty CIX
            ldy CIX
LCAA4       iny
            lda (INBUFF),Y
            sta L00F6
            iny
            sty CIX
            lda (INBUFF),Y
            cmp #$01
            beq LCAD5
            ldy L00F6
            cpy L00F5
            bcs LCABB
            dey
            bcc LCAA4
LCABB       dey
            sty CIX
LCABE       ldy #$01
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
            sta L00F5
LCAD9       lda L00F5
            cmp DATAD
            bcs LCAF1
LCADF       inc CIX
            ldy CIX
            lda (INBUFF),Y
            cmp #CR
            beq LCABE
            cmp #','
            bne LCADF
            inc L00F5
            bne LCAD9
LCAF1       lda #$40
            sta L00A6
            inc CIX
            jmp LCB42

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
            jsr LCB5B
            ldy #$00
            sty L00A6
            sty CIX
LCB42       jsr GETTOK
            inc STINDEX
            lda VTYPE
            bmi LCB6E
            jsr T_AFP
            bcs LCB65
            jsr INP_COMMA
            bne LCB65
            jsr RTNVAR
            jmp LCBAC
LCB5B       lda BRKKEY
            beq LCB60
            rts
LCB60       dec BRKKEY
            jmp CHK_BRK
LCB65       lda #$00
            sta ENTDTD
            lda #$08
            jmp SERROR
LCB6E       ldy #$00
            lda #$11
            sta OPSTK
            sty OPSTKX
            sty COMCNT
            sty ARSLVL
            sty L00B1
            jsr X_PUSHVAL
            dec CIX
            lda CIX
            sta L00F5
            ldx #$FF
LCB88       inx
            inc CIX
            ldy CIX
            lda (INBUFF),Y
            cmp #CR
            beq LCB9B
            cmp #','
            bne LCB88
            bit L00A6
            bvc LCB88
LCB9B       ldy L00F5
            lda STINDEX
            pha
            txa
            ldx #INBUFF
            jsr RISC
            pla
            sta STINDEX
            jsr LC81F
LCBAC       bit L00A6
            bvc LCBC1
            inc DATAD
            ldx STINDEX
            inx
            cpx NXTSTD
            bcs LCBC8
            jsr INP_COMMA
            bcc LCBD8
            jmp LCABE
LCBC1       ldx STINDEX
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
            jmp LCB42

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Second part
;
            org $D800

X_MOVE      jsr GET3INT
            sta L00A2
            sty L00A3
            jmp DO_MOVEUP

X_NMOVE     jsr GET3INT
            sta L00A2
            sty L00A3
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
            sta L00FC
            lsr
            lsr
            adc L00FC
            sta L00FC
            lda FR1+1
            and #$0F
            adc L00FC
            sta L00FC
            jsr FMOVPLYARG
            lsr L00FC
            bcs LDBF6
            jsr T_FLD1
LDBF6       jsr FMOVSCR
            lda L00FC
            beq LDC4D
            jsr LDPLYARG
LDC00       jsr T_FSQ
            bcs ERR_11_
            lsr L00FC
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
XPRINT0     ldy STINDEX
            lda (STMCUR),Y
            cmp #CCOM
            beq XPRINT_TAB
            cmp #CCR
            beq XPRINT_EOL
            cmp #CEOS
            beq XPRINT_EOL
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

GETINTNXT   inc STINDEX
            jmp GETINT

XPRINT_NUL  inc STINDEX
            jmp XPRINT0

XPRINT_EOL  ldy STINDEX
            dey
            ; BUG: if last token was a number or string ending on $15 or $12,
            ;      no enter is printed.
            lda (STMCUR),Y
            cmp #CSC
            beq LDD92
            cmp #CCOM
            beq LDD92
            jsr PUTEOL
LDD92       lda #$00
            sta L00B5
            rts

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
LDE89       cpy NXTSTD
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
            beq LDFBC
LDF95       lda LBUFF,X
            and #$7F
            inx
            eor (SCRADR),Y
            bne LDFA2
            iny
            bne LDF95
LDFA2       asl
            beq LDFBA
            bcs LDFAD
LDFA7       iny
            lda (SCRADR),Y
            bpl LDFA7
LDFAC       sec
LDFAD       inc L00AF
            beq ERR_04
            tya
            adc SCRADR
            bcc LDF8B
            inc SCRADR+1
            bcs LDF8B
LDFBA       clc
            rts
LDFBC       sec
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
            beq LDFBC
LDFD3       lda LBUFF,X
            and #$7F
            inx
            cmp #$2E
            beq LDFBA
            eor (SCRADR),Y
            bne LDFE4
            iny
            bne LDFD3
LDFE4       asl
            beq LDFBA
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Third part, after character map
;
            org $E400

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
            lda (L009D),Y
            sta VTYPE
            ldy #$02
            lda (L009D),Y
            sta FR0
            iny
            lda (L009D),Y
            sta FR0+1
            iny
            lda (L009D),Y
            sta FR0+2
            iny
            lda (L009D),Y
            sta FR0+3
            iny
            lda (L009D),Y
            sta FR0+4
            iny
            lda (L009D),Y
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
            sta (L009D),Y
            iny
            lda VNUM
            sta (L009D),Y
            iny
            lda FR0
            sta (L009D),Y
            iny
            lda FR0+1
            sta (L009D),Y
            iny
            lda FR0+2
            sta (L009D),Y
            iny
            lda FR0+3
            sta (L009D),Y
            iny
            lda FR0+4
            sta (L009D),Y
            iny
            lda FR0+5
            sta (L009D),Y
            rts

; GVVTADR in Atari Basic - get pointer to variable table in L009D
VAR_PTR     asl
            rol
            rol
            rol
            tay
            ror
            and #$F8
            clc
            adc VVTP
            sta L009D
            tya
            and #$07
            adc VVTP+1
            sta L009E
            ldy #$00
            rts

; Initializes memory pointers, erasing current program
INIT_MEM    lda #$00
            sta MEOLFLG
            sta LOADFLG
            lda MEMLO
            ldy MEMLO+1
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
            sty L00A6
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
            sta L00A6   ; No line number
LE6BF       jsr UCASEBUF
            sty STINDEX
            lda (INBUFF),Y
            cmp #CR
            bne SYN_STMT
            bit L00A6
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
            jsr LE821
            bcc LE751
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
            ora L00A6
            sta L00A6
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
LE751       lda L0094
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
            bit L00A6
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
            bit L00A6
            bpl P_SYNERROR
            jsr LF231
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

LE821       ldy #$00
            sty OPSTKX
            lda (SCRADR),Y
            asl
            tay
            lda SYN_ATAB,Y
            sta L009D
            sta L0482
            lda SYN_ATAB+1,Y
            sta L009E
            sta L0483
            lda L0094
            sta L0481
            lda CIX
            sta L0480
LE843       inc L009D
            bne LE849
            inc L009E
LE849       ldx #$00
            lda (L009D,X)
            bmi LE85B
            cmp #$05
            bcc LE8A2
            jsr LE8E6
            bcc LE843
            jmp LE8BC
LE85B       asl
            tay
            lda SYN_ATAB+1,Y
            pha
            lda SYN_ATAB,Y
            pha
            cpy #$12
            bcs LE878
            pla
            tay
            pla
            jsr JSR_AY
            bcc LE843
            jmp LE8BC

JSR_AY      pha
            tya
            pha
            rts

LE878       ldx OPSTKX
            inx
            inx
            inx
            inx
            beq ERR_14B
            stx OPSTKX
            lda CIX
            sta L0480,X
            lda L0094
            sta L0481,X
            lda L009D
            sta L0482,X
            lda L009E
            sta L0483,X
            pla
            sta L009D
            pla
            sta L009E
            jmp LE843
ERR_14B     jmp ERR_14
LE8A2       ldx OPSTKX
            bne LE8A7
            rts
LE8A7       lda L0482,X
            sta L009D
            lda L0483,X
            sta L009E
            dex
            dex
            dex
            dex
            stx OPSTKX
            bcs LE8BC
            jmp LE843
LE8BC       inc L009D
            bne LE8C2
            inc L009E
LE8C2       ldx #$00
            lda (L009D,X)
            bmi LE8BC
            cmp #$03
            beq LE8A2
            bcs LE8BC
            lda CIX
            cmp LLNGTH
            bcc LE8D6
            sta LLNGTH
LE8D6       ldx OPSTKX
            lda L0480,X
            sta CIX
            lda L0481,X
            sta L0094
            jmp LE843

RTS_2       rts

LE8E6       cmp #$0F
            bne SRCONT
            inc L009D
            bne LE8F0
            inc L009E
LE8F0       ldx #$00
            lda (L009D,X)
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
            jmp LE751
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
            lda (L009D),Y
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
LNVARN      lda #$00
            beq GETVARN

            ; Check string variable name
LSTVARN     lda #EVSTR
GETVARN     sta VTYPE
            jsr UCASEBUF
            sty TVSCIX
            jsr CHK_NAMECHR
            bcs LE9AD
            jsr SRCONT
            lda SVONTC
            beq LE994
            ldy L00B2
            lda (INBUFF),Y
            cmp #'0'
            bcc LE9AD
LE994       inc CIX
            jsr CHK_NAMECHR
            bcc LE994
            cmp #'0'
            bcc LE9A3
            cmp #'9'+1
            bcc LE994
LE9A3       cmp #'$'
            beq LE9AF
            bit VTYPE
            bpl LE9B8
            bvs LE9C5
LE9AD       sec
            rts
LE9AF       bit VTYPE
            bpl LE9AD
            bvs LE9AD
            iny
            bne LE9C5
LE9B8       lda (INBUFF),Y
            cmp #'('
            bne LE9C5
            iny
            lda #EVARRAY
            ora VTYPE
            sta VTYPE
LE9C5       lda TVSCIX
            sta CIX
            sty TVSCIX
            ldy VNTP+1
            lda VNTP
            jsr OVSEARCH
LE9D2       bcs LE9DE
            cpx TVSCIX
            beq LEA19
LE9D8       jsr LDFAC
            jmp LE9D2
LE9DE       sec
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
LE9FA       sta (L0097),Y
            dex
            lda LBUFF,X
            dey
            bpl LE9FA
            ldy #$08    ; Expand VVT by 8 bytes
            ldx #STMTAB
            jsr EXPLOW
            inc L00B1
            jsr T_ZFR0
            ldy #$07
LEA11       lda VTYPE,Y
            sta (L0097),Y
            dey
            bpl LEA11
LEA19       tya
            pha
            lda L009D
            pha
            ldx L009E
            lda L00AF
            jsr VAR_PTR
            lda (L009D),Y
            eor VTYPE
            tay
            stx L009E
            pla
            sta L009D
            cpy #$80
            pla
            tay
            bcs LE9D8
            bit VTYPE
            bvc LEA3D
            bmi LEA3D
            dec TVSCIX
LEA3D       lda TVSCIX
            sta CIX
            lda L00AF
            bpl LEA4C
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
            bcc LEA66
            cmp #'Z'+1
            rts

LEA62       ldy TVSCIX
            sty CIX
LEA66       sec
            rts

GET_HEXDIG  ldy CIX
            lda (INBUFF),Y
            sec
            sbc #'0'
            bcc LEA66
            cmp #10
            bcc LEA7F
            cmp #'A'-'0'
            bcc LEA66
            sbc #7
            cmp #$10
            bcs LEA66

LEA7F       ldy #$04
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
STR_TABN    stx ARSLVL
            sta SCRADR+1
            sty SCRADR
LF1C1       ldy ARSLVL
            lda L00AF
            beq LF1D7
            dec L00AF
LF1C9       lda (SCRADR),Y
            bmi LF1D0
            iny
            bne LF1C9
LF1D0       iny
            jsr LF1D7
            jmp LF1C1
LF1D7       clc
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

LF1FC       jsr P_SPC
P_STR_SPC   jsr P_STRB
P_SPC       lda #' '
            jmp PUTCHAR

PRINTLINE   ldy #$00
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
            cmp #$40
            bne LF228
LF226       dex
            dex
LF228       stx FR0
LF22A       jsr P_SPC
            dec FR0
            bpl LF22A
LF231       ldy #$02
            lda (STMCUR),Y
            sta LLNGTH
            iny
LF238       lda (STMCUR),Y
            sta NXTSTD
            iny
            sty STINDEX
            jsr LF249
            ldy NXTSTD
            cpy LLNGTH
            bcc LF238
            rts
LF249       jsr L_GTOK
            cmp #TOK_INVLET ; list an invisible "LET"
            beq L_ADV
            cmp #TOK_LREM   ; list a "--"
            beq PRINT_LREM
            jsr IPRINTSTMT
            jsr L_GTOK
            cmp #TOK_ERROR
            beq LF262
            cmp #TOK_DATA+1 ; First statements are "REM" and "DATA"
            bcs L_ADV
LF262       jsr L_NXTOK
            jsr PUTCHAR
            jmp LF262

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

LF2C8       jsr P_STRB
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
            beq LF32F
            cmp #CFDIV
            beq LF32F
            cmp #CMOD
            beq LF32F
            cmp #CEXEC
            beq LF32F
            cmp #CGOG
            beq LF32F
            cmp #CNOT
            beq LF332
            cmp #CACOM+1
            bcs LF2C8
            ldy #$00
            lda (SCRADR),Y
            and #$7F
            jsr IS_NAMECHR
            bcs LF2C8
LF32F       jsr P_SPC
LF332       jsr P_STR_SPC
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
            cpx #$1B
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
            jmp LF75A

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
            jmp LF92E

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
            sta L00BC
            sty L00BD
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

REXPAND     sta L00A4
            clc
            lda TOPRSTK
            sta TEMPA
            adc L00A4
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
            stx L00F5
            ldy VVTP+1
            sty L00F6
LF6B7       ldx L00F5
            cpx ENDVVT
            lda L00F6
            sbc ENDVVT+1
            bcs LF6E4
            ldy #$00
            lda (L00F5),Y
            and #$FC
            sta (L00F5),Y
            ldy #$02
            ldx #$06
            lda #$00
LF6CF       sta (L00F5),Y
            iny
            dex
            bne LF6CF
            lda L00F5
            clc
            adc #$08
            sta L00F5
            lda L00F6
            adc #$00
            sta L00F6
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
            sty L00BD
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
LF73F       rts
LF740       lda FR0+3
            beq LF73F
            dec FR0+3
            jmp SKP_LOOP
LF749       cmp #$07
            bne LF756
            ldy NXTSTD
            dey
            lda (STMCUR),Y
            cmp #CTHEN
            beq SKP_LOOP
LF756       inc FR0+3
            bne SKP_LOOP
LF75A       jsr RESCUR
ERR_22      lda #$16
            jmp SERROR
LF762       ldy #$01
            lda (STMCUR),Y
            bmi LF75A
            clc
            lda LLNGTH
            adc STMCUR
            sta STMCUR
            bcc LF773
            inc STMCUR+1
LF773       ldy #$01
            lda (STMCUR),Y
            bmi LF75A
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
            bcc LF7DF
            lda RUNSTK
            cmp TOPRSTK
            bcs LF816
LF7DF       sec
            lda TOPRSTK
            sbc #$04
            sta TOPRSTK
            sta APPMHI
            bcs LF7EE
            dec TOPRSTK+1
            dec APPMHI+1
LF7EE       ldy #$03
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
            bne LF814
            tay
            sec
            lda TOPRSTK
            sbc #$0D
            sta TOPRSTK
            sta APPMHI
            bcs LF813
            dec TOPRSTK+1
            dec APPMHI+1
LF813       tya
LF814       clc
            rts
LF816       sec
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
            bne LF85B
            lda #TOK_FOR
LF85B       tax
            inx ; Search "NEXT" if "FOR", "WEND" if "WHILE", "LOOP" if "DO",
                ; "UNTIL" if "REPEAT"
            jmp SKIP_STMT

LF860       lda #TOK_ON
            bne RETURN

X_ENDPROC   jsr X_POP
            bcs ERR_28
            cmp #TOK_EXEC
            beq RETURN
            cmp #TOK_ENDPROC ; Used to signal "ON * EXEC"
            beq LF860
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
            cmp (L009D),Y
            bne ERR_LABEL
            ldy #$03
            lda (L009D),Y
            sta STMCUR+1
            dey
            lda (L009D),Y
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
            ldy L00BD
            bmi ERR_NOTRAP
            lda L00BC
            ldx #$80
            stx L00BD
            ldx ERRNUM
            stx ERRSAVE
            ldx #$00
            stx ERRNUM
            jmp GTO_LINE

ERR_NOTRAP  lda ERRNUM
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
            cmp #$1F
            bcc LF91C
            sbc #$62
LF91C       sta L00AF
            cmp #$4C
            bcs LF92E
            ldx #$00
            lda #>ERRTAB
            ldy #<ERRTAB
            jsr STR_TABN
            jsr LF1FC
LF92E       ldy #$01
            lda (STMCUR),Y
            bmi LF949
            lda #<ERRTAB
            ldy #>ERRTAB
            jsr P_STRB_AY
            ldy #$01
            lda (STMCUR),Y
            sta FR0+1
            dey
            lda (STMCUR),Y
            sta FR0
            jsr LF956
LF949       jsr PUTEOL
            jsr TRACE_OFF
            jmp SYN_START

PUT_AX      sta FR0+1
            stx FR0
LF956       jsr T_IFP
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
LFAD8       lda FP_256,X
            sta FR1,X
            dex
            bpl LFAD8
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
LFB03       lda JF_DAY,X
            sta FR1,X
            dex
            bpl LFB03
            jsr T_FDIV
            ldy #$00
            lda FR0
            cmp #$40
            bne LFB18
            sty FR0+1
LFB18       sty CIX
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
            bne LFB4D
            ldy FR0+1
            sta FR0+1
            tya
LFB4D       tax
            lsr
            lsr
            lsr
            lsr
            jsr TM_GETDIG
            txa
            and #$0F
TM_GETDIG   ora #'0'
            cmp #'9'+1
            bcc LFB60
            adc #'A'-'9' - 2
LFB60       ldy CIX
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
LFBB1       sta RTCLOK+2        ; Write and retry until stable
            sty RTCLOK+1
            stx RTCLOK
            cmp RTCLOK+2
            bne LFBB1
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
            bcc LFBEB
            inc FR1+1
            bne LFBEB
            inc FR1+2
LFBEB       rts
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

X_TEXT      jsr GET2INT
            sta L0099
            bne TS_RTS
            jsr EXEXPR
            ldx ARSLVL
            lda VARSTK0,X
            bmi LFC4B
            jsr X_STRP
LFC4B       jsr X_POPSTR
LFC4E       lda FR0+2
            ora FR0+3
            beq TS_RTS
            ldy #$00
            sty L00DB
            sty L00DC
            lda (FR0),Y
            bpl LFC60
            dec L00DB
LFC60       jsr ATA2SCR
            asl
            asl
            sta L00A2
            lda #$00
            rol
            asl L00A2
            rol
            adc CHBAS
            sta L00A3
            jsr PREPLOT
            bcs TS_RTS
LFC77       ldy #$08
            sty L00DD
            ldy L00DC
            lda (L00A2),Y
            eor L00DB
            sta L00DA
            ldx L00ED
            ldy FR1+3
LFC87       asl L00DA
            lda (L00DE),Y
            and PLOT_MASK,X
            bcc LFC93
            ora PLOT_PIX,X
LFC93       sta (L00DE),Y
            dec L00DD
            beq LFCA0
            jsr PLOT_ICOL
            cpy FR1+1
            bcc LFC87
LFCA0       jsr PLOT_IROW2
            inc L00DC
            lda L00DC
            cmp #$08
            bcs LFCB1
            adc L0099
            cmp FR1
            bcc LFC77
LFCB1       lda L009B
            adc #$07
            sta L009B
            bcc LFCBB
            inc L009C
LFCBB       inc FR0
            bne LFCC1
            inc FR0+1
LFCC1       lda FR0+2
            bne LFCC7
            dec FR0+3
LFCC7       dec FR0+2
            jmp LFC4E

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
            bcc LFD31
            inc L00DF
LFD31       asl
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
            beq LFD5F
LFD58       asl L00DE
            rol L00DF
            dex
            bne LFD58
LFD5F       clc
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
            beq LFD86
            and GR_PPBYTE,Y
            sta L00ED
LFD7F       lsr FR1+4
            ror FR1+3
            dey
            bne LFD7F
LFD86       lda FR1+4
            bne RTS_SEC
            lda FR1+3
            cmp FR1+1
            bcs RTS_SEC
            ldx FR1+2
            bne LFD9E
            lda COLOR
            jsr ATA2SCR
            sta PLOT_PIX
            clc
            rts

LFD9E       ldy GR_PPBYTE,X
            sty FR1+4
            lda GR_BPP-1,X
            sta L00EE
            lda COLOR
            ora PLOT_MASK
            eor PLOT_MASK
LFDB0       sta PLOT_PIX,Y
            ldx L00EE
LFDB5       asl
            dex
            bne LFDB5
            dey
            bpl LFDB0
            ldy FR1+4
            lda PLOT_MASK
LFDC1       sta PLOT_MASK,Y
            ldx L00EE
LFDC6       sec
            rol
            dex
            bne LFDC6
            dey
            bpl LFDC1
            clc
LFDCF       rts

            ; PAINT (flood fill)
            ; NOTE:
            ;   Fills complete horizontal lines, storing a list of pixel spans in
            ;   a buffer indexed by (L00A2), initialized to the top of the return
            ;   stack, up to MEMTOP.
            ;   Each span is stored in 3 bytes, as expanded column:
            ;     0: left byte ($00 to $7F), bit 7 = direction (up/down)
            ;     1: bit 3-5: left pos
            ;        but 0-2: right pos
            ;     2: right byte ($00 to $7F)
            ;
X_PAINT     jsr GET2INT
            sta L0099
            bne LFDCF
            jsr PREPLOT
            bcs LFDCF
            lda TOPRSTK
            sta L00A2
            lda TOPRSTK+1
            sta L00A3
            lda MEMTOP
            sbc #$06
            sta L00E7
            lda MEMTOP+1
            sbc #$00
            sta L00E8
            ; Paint next span
PAINT_NXT   clc
            lda L00A2
            adc #$03
            sta L00A2
            bcc LFDFD
            inc L00A3
LFDFD       cmp L00E7
            lda L00A3
            sbc L00E8
            bcc LFE08
            jmp ERR_2

LFE08       ldx L00ED
            ldy FR1+3
            jsr PLOT_GET
            beq LFE14
            jmp LFEBA
            ; Plot all possible points to the left
LFE14       jsr PLOT_SET
LFE17       jsr PLOT_DCOL
            tya
            bmi LFE28
            jsr PLOT_GET
            bne LFE28
            jsr PLOT_SET
            jmp LFE17
            ; Store last point to the left
LFE28       jsr PLOT_ICOL
            tya
            ldy #$00
            sta (L00A2),Y
            txa
            asl
            asl
            asl
            iny
            sta (L00A2),Y
            ; Plot all possible points to the right
            ldy FR1+3
            ldx L00ED
LFE3B       jsr PLOT_ICOL
            cpy FR1+1
            bcs LFE4D
            jsr PLOT_GET
            bne LFE4D
            jsr PLOT_SET
            jmp LFE3B
            ; Store last point to the right
LFE4D       jsr PLOT_DCOL
            tya
            ldy #$02
            sta (L00A2),Y
            txa
            dey
            ora (L00A2),Y
            sta (L00A2),Y
            ; Test pixels in the next row (from current span)
            ldy L0099
            iny
            cpy FR1
            bcs LFE85
            jsr PLOT_IROW
            ; Start from left span coordinate
            jsr PAINT_GETL
LFE68       ; Check if we have more pixels in the span to test DOWN
            ldy #$01
            lda (L00A2),Y
            and #$07
            cmp L00ED
            iny
            lda (L00A2),Y
            sbc FR1+3
            bcc LFE82
            ldy #$00
            lda (L00A2),Y
            ora #$80
LFE7D       sta (L00A2),Y
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
LFE92       ; Check if we have more pixels in the span to test UP
            ldy #$01
            lda (L00A2),Y
            and #$07
            cmp L00ED
            iny
            lda (L00A2),Y
            sbc FR1+3
            bcc LFEA9
            ldy #$00
            lda (L00A2),Y
            and #$7F
            bpl LFE7D
LFEA9       jsr PLOT_IROW
LFEAC       ldy #$01
            lda (L00A2),Y
            and #$07
            tax
            iny
            lda (L00A2),Y
            tay
            // Ensure that we are outside span, we tested all
            jsr PLOT_ICOL
            ; End current span, continue from next pixel on old span
LFEBA       jsr PLOT_ICOL
            stx L00ED
            sty FR1+3
            sec
            lda L00A2
            sbc #$03
            sta L00A2
            bcs LFECC
            dec L00A3
LFECC       cmp TOPRSTK
            bne LFED6
            lda L00A3
            cmp TOPRSTK+1
            beq PAINT_RTS
LFED6       ldy #$00
            lda (L00A2),Y
            bpl LFE92
            bmi LFE68

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
            bcs LFEF9
            dec L00DF
LFEF9       rts
            ; Read left pixel from span list
PAINT_GETL  ldy #$00
            lda (L00A2),Y
            and #$7F
            sta FR1+3
            iny
            lda (L00A2),Y
            lsr
            lsr
            lsr
            sta L00ED
            rts
            ; Increment plot column
PLOT_ICOL   cpx FR1+4
            inx
            bcc LFF13
            ldx #$00
            iny
LFF13       rts
            ; Decrement plot column
PLOT_DCOL   dex
            bpl LFF1A
            ldx FR1+4
            dey
LFF1A       rts
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
            beq LFF34
            lda PLOT_PIX
            rts
LFF34       lda PLOT_PIX
            beq LFF3C
            lda #$00
            rts
LFF3C       lda #$01
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
            lda #$4C       ; JMP DO_TRACE
            ldx #<DO_TRACE
            ldy #>DO_TRACE
            bne LFF6C
TRACE_OFF   lda #$A0       ; LDY #02 / LDA (),Y
            ldx #$02
            ldy #$B1
LFF6C       sta EXECNL      ; Patch instruction
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
            bcc LFFE8
            inc STMCUR+1
LFFE8       lda (STMCUR),Y
            bpl EXECNL
            jmp X_END

SYN_PROMPT_ jmp SNX3
;

; vi:syntax=mads
