;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                            ;;
;; TurboBasic XL v1.5 disassembly, in MADS format.            ;;
;;                                                            ;;
;; Disassembled and translated to MADS by dmsc.               ;;
;;                                                            ;;
;; Version 2017-05-29                                         ;;
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
LOMEM       = $0080
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
FP9S        = $DFEA
ATNCOEF     = $DFAE
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
INBUFF      = $00F3
CIX         = $00F2
FR1         = $00E0
FR0         = $00D4
;
; Code equates
;
L0082       = $0082
L0083       = $0083
L0084       = $0084
L0085       = $0085
L0086       = $0086
L0087       = $0087
L0088       = $0088
L0089       = $0089
STMCUR      = $008A
L008C       = $008C
L008D       = $008D
L008E       = $008E
L008F       = $008F
TOPRSTK     = $0090
MEOLFLG     = $0092
L0094       = $0094
L0095       = $0095
L0096       = $0096
L0097       = $0097
L0098       = $0098
L0099       = $0099
L009A       = $009A
L009B       = $009B
L009C       = $009C
L009D       = $009D
L009E       = $009E
LLNGTH      = $009F
L00A0       = $00A0
L00A1       = $00A1
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
L00B0       = $00B0
L00B1       = $00B1
L00B2       = $00B2
L00B3       = $00B3
L00B4       = $00B4
L00B5       = $00B5
L00B6       = $00B6
L00B7       = $00B7
L00B8       = $00B8
L00B9       = $00B9
L00BA       = $00BA
L00BB       = $00BB
L00BC       = $00BC
L00BD       = $00BD
L00BE       = $00BE
L00BF       = $00BF
L00C0       = $00C0
L00C1       = $00C1
L00C2       = $00C2
L00C3       = $00C3
L00C4       = $00C4
L00C5       = $00C5
L00C6       = $00C6
L00C7       = $00C7
L00C8       = $00C8
L00C9       = $00C9
L00CA       = $00CA
L00D2       = $00D2
L00D3       = $00D3
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
L00FB       = $00FB
L00FC       = $00FC
L00FD       = $00FD
L0480       = $0480
L0481       = $0481
L0482       = $0482
L0483       = $0483
L0500       = $0500
L0501       = $0501
L057F       = $057F
L0580       = $0580
L0581       = $0581
L058C       = $058C
L058D       = $058D
L05C0       = $05C0
L05C8       = $05C8
PLYARG      = $05E0
FPSCR       = $05E6
FPSCR1      = $05EC

LB000       = $B000
LDBA1       = $DBA1
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
            .word $3629

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
            jmp LE65D

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
STMT_X_TAB  .word X_RTS,X_RTS,X_INPUT,X_COLOR
            .word X_LIST,X_ENTER,EXEXPR,X_IF
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
            .word X_CSAVE,X_CLOAD,EXEXPR,X_ERROR
            .word X_DPOKE,X_MOVE,X_NMOVE,X_FF
            .word X_DO,X_UNTIL,X_WHILE,X_WEND
            .word X_ELSE,X_ENDIF,X_BPUT,X_BGET
            .word X_FILLTO,X_DO,X_LOOP,X_EXIT
            .word X_DIR,X_LOCK,X_UNLOCK,X_RENAME
            .word X_DELETE,X_PAUSE,X_TIMESET,ERR_27
            .word X_EXEC,X_ENDPROC,X_FCOLOR,X_FL
            .word X_RTS,X_RENUM,X_DEL,X_DUMP
            .word X_TRACE,X_TEXT,X_BLOAD,X_BRUN
            .word X_GO_S,X_RTS,X_FB,X_PAINT
            .word X_CLS,X_DSOUND,X_CIRCLE,X_PPUT
            .word X_PGET

; MATHPACK temporary variables
L22CA       .ds 8
L22D2       .ds 8
L22DA       .ds 8
L22E2       .ds 8
L22EA       .ds 8
L22F2       .ds 8

L22FA       .ds 6

;            org $2300
            nop
            jsr DISROM
            jmp ERR_9
IO_DIRSPEC  .byte 'D:*.*', CR
L230D       .byte 'S:', CR
L2310       .byte 'C:', CR
            .byte 'P:', CR

BLOADFLAG   .ds 1

; Note: Not known why we skip this 13 bytes
            .ds 13

;            org $2324
DISROM      lda PORTB
            and #$FC
            ora #$02
            sta PORTB
            rts

; Note: this table needs to be in address with low-part = 29*2 = 58 ($XX3A)
            org ((* - $3A + $FF) & $FF00) + $3A
OPETAB
;
            .word X_LTE,X_NEQU,X_GTE,X_LT
            .word X_GT,X_EQU,X_POW,X_FMUL
            .word X_FADD,X_FSUB,X_FDIV,X_NOT
            .word X_OR,X_AND,X_RTS,X_RPAREN
            .word X_FPASIGN,X_STRASIGN,X_LTE,X_NEQU
            .word X_GTE,X_LT,X_GT,X_EQU
            .word X_RTS,X_FNEG,X_STRLPAREN,X_ARRLPAREN
            .word X_DIMLPAREN,X_RPAREN,X_DIMLPAREN,X_ARRCOMMA
            .word X_STRP,X_CHRP,X_USR,X_ASC
            .word X_VAL,X_LEN,X_ADR,X_ATN
            .word X_COS,X_PEEK,X_SIN,X_RNDFN
            .word X_FRE,X_EXP,X_LOG,X_CLOG
            .word X_SQR,X_SGN,X_ABS,X_INT
            .word X_PADDLE,X_STICK,X_PTRIG,X_STRIG
            .word X_DPEEK,X_BITAND,X_BITOR,X_INSTR
            .word X_INKEYP,X_EXOR,X_HEXP,X_DEC
            .word X_DIV,X_FRAC,X_TIMEP,X_TIME
            .word X_MOD,X_RTS,X_RND,X_RAND
            .word X_TRUNC
            .word X_N0,X_N1,X_N2,X_N3
            .word X_RTS,X_UINSTR,X_ERR,X_ERL
            ; Table with right operator precedence
OPRTAB      .byte $00,$00,$00,$00,$00,$00,$00,$00
            .byte $00,$00,$00,$00,$00,$20,$20,$20
            .byte $20,$20,$20,$2C,$28,$22,$22,$28
            .byte $1E,$1A,$1C,$32,$04,$32,$32,$30
            .byte $30,$30,$30,$30,$30,$2E,$2E,$32
            .byte $32,$32,$32,$32,$04,$32,$32,$32
            .byte $32,$32,$32,$32,$32,$32,$32,$32
            .byte $32,$32,$32,$32,$32,$32,$32,$32
            .byte $32,$32,$32,$32,$32,$32,$2A,$2A
            .byte $32,$32,$2A,$32,$32,$28
            .byte $32,$32,$32,$28,$00,$32,$32,$32
            .byte $32,$32,$32,$32,$00,$32,$32,$32
            ; Table with left operator precedence
OPLTAB      .byte $00,$00,$00,$00,$00,$00,$00,$00
            .byte $00,$00,$00,$00,$00,$20,$20,$20
            .byte $20,$20,$20,$2C,$28,$22,$22,$28
            .byte $1D,$1A,$1C,$02,$30,$01,$01,$30
            .byte $30,$30,$30,$30,$30,$2D,$2D,$02
            .byte $02,$02,$02,$02,$03,$02,$02,$02
            .byte $02,$02,$02,$02,$02,$02,$02,$02
            .byte $02,$02,$02,$02,$02,$02,$02,$02
            .byte $02,$02,$02,$02,$02,$02,$2A,$2A
            .byte $02,$32,$2A,$02,$02,$28,$02,$32
            .byte $32,$28,$00,$32,$02,$02,$32,$32
            .byte $32,$32,$00,$02,$32,$32
B_CIOV      inc PORTB
            jsr CIOV
            dec PORTB
            cpy #$00
X_RTS       rts

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
L24DE       inc PORTB
            jsr L24E8
            dec PORTB
            rts
L24E8       lda IOCB0+ICPTH,X
            pha
            lda IOCB0+ICPTL,X
            pha
            tya
            ldy #$5C
            rts

L24F4       inc PORTB
L24F7       jsr $0000
            dec PORTB
            rts

X_DOS       jsr LC534
            inc PORTB
            lda JMPDOS+1
            ldy JMPDOS+2
            sta DOSINI
            sty DOSINI+1
            jmp (DOSVEC)

X_BYE       jsr LC534
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

DO_USR      lda #$23
            pha
            pha
            lda L00B0
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
            lda L00B0
            pha
            jmp (FR0)

L2583       jmp LF67B
L2586       lda #$00
L2588       sty L00A4
            sta L00A5
            clc
            lda TOPRSTK
            adc L00A4
            tay
            lda TOPRSTK+1
            adc L00A5
            cmp MEMTOP+1
            bcc L25A4
            bne L2583
            cpy MEMTOP
            bcc L25A4
            bne L2583
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
L25DE       inc PORTB
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
L2620       lda #$00
L2622       sty L00A4
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
L265D       inc PORTB
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
L2693       clc
            jmp T_ZFR0
L2697       clc
            rts
L2699       sec
            rts

T_FSQ       jsr T_FMOVE

T_FMUL      lda FR0
            beq L2697
            lda FR1
            beq L2693
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
            bmi L2699
            ora L00EE
            tay
            jsr L2A9E
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
            adc L22F2,Y
            sta L00DE
            lda L00DD
            adc L22EA,Y
            sta L00DD
            lda L00DC
            adc L22E2,Y
            sta L00DC
            lda L00DB
            adc L22DA,Y
            sta L00DB
            lda L00DA
            adc L22D2,Y
            sta L00DA
            lda FR0+5
            adc L22CA,Y
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
            adc L22F2,Y
            sta L00DD
            lda L00DC
            adc L22EA,Y
            sta L00DC
            lda L00DB
            adc L22E2,Y
            sta L00DB
            lda L00DA
            adc L22DA,Y
            sta L00DA
            lda FR0+5
            adc L22D2,Y
            sta FR0+5
            lda FR0+4
            adc L22CA,Y
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
            adc L22F2,Y
            sta L00DC
            lda L00DB
            adc L22EA,Y
            sta L00DB
            lda L00DA
            adc L22E2,Y
            sta L00DA
            lda FR0+5
            adc L22DA,Y
            sta FR0+5
            lda FR0+4
            adc L22D2,Y
            sta FR0+4
            lda FR0+3
            adc L22CA,Y
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
            adc L22F2,Y
            sta L00DB
            lda L00DA
            adc L22EA,Y
            sta L00DA
            lda FR0+5
            adc L22E2,Y
            sta FR0+5
            lda FR0+4
            adc L22DA,Y
            sta FR0+4
            lda FR0+3
            adc L22D2,Y
            sta FR0+3
            lda FR0+2
            adc L22CA,Y
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
            adc L22F2,Y
            sta L00DA
            lda FR0+5
            adc L22EA,Y
            sta FR0+5
            lda FR0+4
            adc L22E2,Y
            sta FR0+4
            lda FR0+3
            adc L22DA,Y
            sta FR0+3
            lda FR0+2
            adc L22D2,Y
            sta FR0+2
            lda FR0+1
            adc L22CA,Y
            sta FR0+1
            dey
            bpl L27C0
            bmi L27F9
L27F4       beq L27F9
            dey
            bpl L27C0
L27F9       jmp L2DB4
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
            jsr L2A9E
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
            cmp L22CA,Y
            bne L2867
            lda FR1+1
            cmp L22D2,Y
            bne L2867
            lda FR1+2
            cmp L22DA,Y
            bne L2867
            lda FR1+3
            cmp L22E2,Y
            bne L2867
            lda FR1+4
            cmp L22EA,Y
            bne L2867
            lda FR1+5
            cmp L22F2,Y
            bne L2867
            ldx #$00
            jmp L2A95
L2867       bcc L2893
            lda FR1+5
            sbc L22F2,Y
            sta FR1+5
            lda FR1+4
            sbc L22EA,Y
            sta FR1+4
            lda FR1+3
            sbc L22E2,Y
            sta FR1+3
            lda FR1+2
            sbc L22DA,Y
            sta FR1+2
            lda FR1+1
            sbc L22D2,Y
            sta FR1+1
            lda FR1
            sbc L22CA,Y
            sta FR1
L2893       rol FR0+1
            iny
            cpy #$08
            bne L2838
            ldy #$00
L289C       lda FR1+1
            cmp L22CA,Y
            bne L28CB
            lda FR1+2
            cmp L22D2,Y
            bne L28CB
            lda FR1+3
            cmp L22DA,Y
            bne L28CB
            lda FR1+4
            cmp L22E2,Y
            bne L28CB
            lda FR1+5
            cmp L22EA,Y
            bne L28CB
            lda L00E6
            cmp L22F2,Y
            bne L28CB
            ldx #$01
            jmp L2A95
L28CB       bcc L28F7
            lda L00E6
            sbc L22F2,Y
            sta L00E6
            lda FR1+5
            sbc L22EA,Y
            sta FR1+5
            lda FR1+4
            sbc L22E2,Y
            sta FR1+4
            lda FR1+3
            sbc L22DA,Y
            sta FR1+3
            lda FR1+2
            sbc L22D2,Y
            sta FR1+2
            lda FR1+1
            sbc L22CA,Y
            sta FR1+1
L28F7       rol FR0+2
            iny
            cpy #$08
            bne L289C
            ldy #$00
L2900       lda FR1+2
            cmp L22CA,Y
            bne L292F
            lda FR1+3
            cmp L22D2,Y
            bne L292F
            lda FR1+4
            cmp L22DA,Y
            bne L292F
            lda FR1+5
            cmp L22E2,Y
            bne L292F
            lda L00E6
            cmp L22EA,Y
            bne L292F
            lda L00E7
            cmp L22F2,Y
            bne L292F
            ldx #$02
            jmp L2A95
L292F       bcc L295B
            lda L00E7
            sbc L22F2,Y
            sta L00E7
            lda L00E6
            sbc L22EA,Y
            sta L00E6
            lda FR1+5
            sbc L22E2,Y
            sta FR1+5
            lda FR1+4
            sbc L22DA,Y
            sta FR1+4
            lda FR1+3
            sbc L22D2,Y
            sta FR1+3
            lda FR1+2
            sbc L22CA,Y
            sta FR1+2
L295B       rol FR0+3
            iny
            cpy #$08
            bne L2900
            ldy #$00
L2964       lda FR1+3
            cmp L22CA,Y
            bne L2993
            lda FR1+4
            cmp L22D2,Y
            bne L2993
            lda FR1+5
            cmp L22DA,Y
            bne L2993
            lda L00E6
            cmp L22E2,Y
            bne L2993
            lda L00E7
            cmp L22EA,Y
            bne L2993
            lda L00E8
            cmp L22F2,Y
            bne L2993
            ldx #$03
            jmp L2A95
L2993       bcc L29BF
            lda L00E8
            sbc L22F2,Y
            sta L00E8
            lda L00E7
            sbc L22EA,Y
            sta L00E7
            lda L00E6
            sbc L22E2,Y
            sta L00E6
            lda FR1+5
            sbc L22DA,Y
            sta FR1+5
            lda FR1+4
            sbc L22D2,Y
            sta FR1+4
            lda FR1+3
            sbc L22CA,Y
            sta FR1+3
L29BF       rol FR0+4
            iny
            cpy #$08
            bne L2964
            ldy #$00
L29C8       lda FR1+4
            cmp L22CA,Y
            bne L29F7
            lda FR1+5
            cmp L22D2,Y
            bne L29F7
            lda L00E6
            cmp L22DA,Y
            bne L29F7
            lda L00E7
            cmp L22E2,Y
            bne L29F7
            lda L00E8
            cmp L22EA,Y
            bne L29F7
            lda L00E9
            cmp L22F2,Y
            bne L29F7
            ldx #$04
            jmp L2A95
L29F7       bcc L2A23
            lda L00E9
            sbc L22F2,Y
            sta L00E9
            lda L00E8
            sbc L22EA,Y
            sta L00E8
            lda L00E7
            sbc L22E2,Y
            sta L00E7
            lda L00E6
            sbc L22DA,Y
            sta L00E6
            lda FR1+5
            sbc L22D2,Y
            sta FR1+5
            lda FR1+4
            sbc L22CA,Y
            sta FR1+4
L2A23       rol FR0+5
            iny
            cpy #$08
            bne L29C8
            lda FR0+1
            bne L2A92
            ldy #$00
L2A30       lda FR1+5
            cmp L22CA,Y
            bne L2A5F
            lda L00E6
            cmp L22D2,Y
            bne L2A5F
            lda L00E7
            cmp L22DA,Y
            bne L2A5F
            lda L00E8
            cmp L22E2,Y
            bne L2A5F
            lda L00E9
            cmp L22EA,Y
            bne L2A5F
            lda L00EA
            cmp L22F2,Y
            bne L2A5F
            ldx #$05
            jmp L2A95
L2A5F       bcc L2A8B
            lda L00EA
            sbc L22F2,Y
            sta L00EA
            lda L00E9
            sbc L22EA,Y
            sta L00E9
            lda L00E8
            sbc L22E2,Y
            sta L00E8
            lda L00E7
            sbc L22DA,Y
            sta L00E7
            lda L00E6
            sbc L22D2,Y
            sta L00E6
            lda FR1+5
            sbc L22CA,Y
            sta FR1+5
L2A8B       rol L00DA
            iny
            cpy #$08
            bne L2A30
L2A92       jmp L2DB4
L2A95       rol FR0+1,X
            iny
            cpy #$08
            bne L2A95
            beq L2A92
L2A9E       sed
            clc
            lda FR1+5
            sta L22F2+7
            adc FR1+5
            sta L22F2+6
            lda FR1+4
            sta L22EA+7
            adc FR1+4
            sta L22EA+6
            lda FR1+3
            sta L22E2+7
            adc FR1+3
            sta L22E2+6
            lda FR1+2
            sta L22DA+7
            adc FR1+2
            sta L22DA+6
            lda FR1+1
            sta L22D2+7
            adc FR1+1
            sta L22D2+6
            lda #$00
            sta L22CA+7
            adc #$00
            sta L22CA+6
            ldx #$02
L2ADE       lda L22F2+4,X
            adc L22F2+4,X
            sta L22F2+3,X
            lda L22EA+4,X
            adc L22EA+4,X
            sta L22EA+3,X
            lda L22E2+4,X
            adc L22E2+4,X
            sta L22E2+3,X
            lda L22DA+4,X
            adc L22DA+4,X
            sta L22DA+3,X
            lda L22D2+4,X
            adc L22D2+4,X
            sta L22D2+3,X
            lda L22CA+4,X
            adc L22CA+4,X
            sta L22CA+3,X
            dex
            bne L2ADE
            lda L22F2+6
            adc L22F2+4
            sta L22F2+3
            lda L22EA+6
            adc L22EA+4
            sta L22EA+3
            lda L22E2+6
            adc L22E2+4
            sta L22E2+3
            lda L22DA+6
            adc L22DA+4
            sta L22DA+3
            lda L22D2+6
            adc L22D2+4
            sta L22D2+3
            lda L22CA+6
            adc L22CA+4
            sta L22CA+3
            ldx #$02
L2B4F       lda L22F2+1,X
            adc L22F2+1,X
            sta L22F2,X
            lda L22EA+1,X
            adc L22EA+1,X
            sta L22EA,X
            lda L22E2+1,X
            adc L22E2+1,X
            sta L22E2,X
            lda L22DA+1,X
            adc L22DA+1,X
            sta L22DA,X
            lda L22D2+1,X
            adc L22D2+1,X
            sta L22D2,X
            lda L22CA+1,X
            adc L22CA+1,X
            sta L22CA,X
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

T_INTLBF    lda #$05
            sta INBUFF+1
            lda #$80
            sta INBUFF
            rts

T_SKPSPC    inc PORTB
            jsr LDBA1
            dec PORTB
            rts
T_FASC      inc PORTB
            jsr FASC
            dec PORTB
            rts
T_AFP       inc PORTB
            jsr X_MOVE
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
            adc #$07
L2BF8       lsr L00F8
            bcc L2BFE
            adc #$15
L2BFE       lsr L00F8
            bcc L2C04
            adc #$31
L2C04       lsr L00F8
            bcc L2C0D
            adc #$63
            bcc L2C0D
            iny
L2C0D       lsr L00F8
            bcc L2C17
            adc #$27
            iny
            bcc L2C17
            iny
L2C17       ldx L00F7
            beq L2C8A
            lsr L00F7
            bcc L2C26
            adc #$55
            iny
            iny
            bcc L2C26
            iny
L2C26       lsr L00F7
            bcc L2C32
            adc #$11
            tax
            tya
            adc #$05
            tay
            txa
L2C32       lsr L00F7
            bcc L2C3E
            adc #$23
            tax
            tya
            adc #$10
            tay
            txa
L2C3E       lsr L00F7
            bcc L2C4A
            adc #$47
            tax
            tya
            adc #$20
            tay
            txa
L2C4A       lsr L00F7
            bcc L2C56
            adc #$95
            tax
            tya
            adc #$40
            tay
            txa
L2C56       lsr L00F7
            bcc L2C66
            adc #$91
            tax
            tya
            adc #$81
            tay
            txa
            bcc L2C66
            inc FR0+1
L2C66       lsr L00F7
            bcc L2C78
            adc #$83
            tax
            tya
            adc #$63
            tay
            lda FR0+1
            adc #$01
            sta FR0+1
            txa
L2C78       lsr L00F7
            bcc L2C8A
            adc #$67
            tax
            tya
            adc #$27
            tay
            lda FR0+1
            adc #$03
            sta FR0+1
            txa
L2C8A       sty FR0+2
            sta FR0+3
            lda #$42
            sta FR0
            jmp L2DB8
L2C95       clc
            rts

T_FSUB      lda FR1
            eor #$80
            sta FR1

T_FADD      lda FR1
            and #$7F
            beq L2C95
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
            bne L2C95
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
L2D6D       jmp L2DB8
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
            bcs L2DB8
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
            jmp L2DB8
L2DB4       ldx L00DA
            bne L2DBA
L2DB8       ldx #$00
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
            jsr L2EB5
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

L2EB5       lda FR0
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

L2ED4       lda FR0
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

LDPLYARG    ldx #$00
            jmp LD05C0X

LDFPSCR     ldx #$06
            jmp LD05C0X

LDFPSCR1    ldx #$0C
LD05C0X     lda PLYARG+0,X
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
L2F1E       ldx #$0C
            jmp L2F25
L2F23       ldx #$06
L2F25       lda PLYARG+0,X
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
T_FEXP      ldx #$05
            inc PORTB
L2F49       lda LDE89,X
            sta FR1,X
            dex
            bpl L2F49
            dec PORTB
            jsr T_FMUL
            bcs L2F43
L2F59       lda #$00
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
            jsr L2DB8
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

L2FCD       stx L00FC
            sty L00FD
            jsr L2EB5
            jsr T_FLD1P
            jsr T_FADD
            jsr L2ED4
            jsr LDPLYARG
            jsr T_FLD1P
            jsr T_FSUB
            jsr L2F23
            jmp T_FDIV
L2FEC       sec
            rts

T_FLOG      lda #$05
            bne L2FF4

T_FCLOG     lda #$00
L2FF4       sta L00F0
            lda FR0
            bmi L2FEC
            beq L2FEC
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
            jsr L2FCD
            jsr L2ED4
            jsr T_FSQ
            lda #$0A
            ldx #<LGCOEF
            ldy #>LGCOEF
            jsr T_PLYEVL
            dec PORTB
            jsr L2F23
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
            beq L307C
            inc PORTB
L306E       lda LDE89,X
            sta FR1,X
            dex
            bpl L306E
            dec PORTB
            jmp T_FDIV
L307C       clc
            rts
L307E       sec
            rts

T_FSIN      lda #$04
            bit FR0
            bpl L308C
            lda #$02
            bne L308C

T_FCOS      lda #$01
L308C       sta L00F0
            lda FR0
            and #$7F
            sta FR0
            ldx L00FB
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
            bcs L307E
            lda FR0
            and #$7F
            sec
            sbc #$40
            bmi L30E6
            cmp #$04
            bpl L307E
            tax
            lda FR0+1,X
            sta L00F1
            and #$10
            beq L30D1
            lda #$02
L30D1       clc
            adc L00F1
            and #$03
            adc L00F0
            sta L00F0
            stx L00F1
            lda #$00
L30DE       sta FR0+1,X
            dex
            bpl L30DE
            jsr L2DB8
L30E6       lsr L00F0
            bcc L30F3
            jsr T_FMOVE
            jsr T_FLD1
            jsr T_FSUB
L30F3       jsr L2ED4
            jsr T_FSQ
            bcs L307E
            lda #$06
            ldx #<SCOEF
            ldy #>SCOEF
            jsr T_PLYEVL
            jsr L2F23
            jsr T_FMUL
            lsr L00F0
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
            jsr L2FCD
            dec PORTB
L3171       jsr L2ED4
            jsr T_FSQ
            bcs L31C0
            lda #$0B
            ldx #<ATNCOEF
            ldy #>ATNCOEF
            inc PORTB
            jsr T_PLYEVL
            dec PORTB
            bcs L31C0
            jsr L2F23
            jsr T_FMUL
            bcs L31C0
            lda L00F1
            beq L31AF
            ldx #$05
            inc PORTB
L319B       lda LDFF0,X
            sta FR1,X
            dex
            bpl L319B
            dec PORTB
            jsr T_FADD
            lda L00F0
            ora FR0
            sta FR0
L31AF       lda L00FB
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
            jsr L2ED4
            jsr T_FMOVE
            jsr T_FLD1
            inc FR0+1
            jsr T_FSUB
            jsr L2F23
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
            jsr L2F1E
            jsr T_FSUB
            jsr L324F
            lda FR0
            beq L3234
            jsr L2F1E
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

X_RENUM     jsr X_DO
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
            sta L00A0
            lda L009A
            sta L00A1
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
            lda L0089
            sta STMCUR+1
            lda L0088
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
            cmp #$0A
            beq L3443
            cmp #$0B
            beq L3443
            cmp #$0C
            beq L3443
            cmp #$0D
L3443       beq L34AE
            cmp #$1E
            beq L34B4
            cmp #$23
            beq L34A7
            cmp #$07
            beq L349E
            cmp #$04
            beq L34C0
            cmp #$56
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
L3498       jsr LC9C5
            jmp LF1B5
L349E       jsr L3566
            cpx #$1B
            bne L3459
            dec STINDEX
L34A7       ldy STINDEX
            iny
            cpy NXTSTD
            bcs L3459
L34AE       jsr L34D5
            jmp L3459
L34B4       jsr L3566
            cpx #$17
            beq L34C2
            cpx #$18
            bne L3459
            .byte $2C
L34C0       inc STINDEX
L34C2       lda STINDEX
            cmp NXTSTD
            bcs L3459
            pha
            jsr L34D7
            pla
            sta STINDEX
            jsr L3568
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
L3566       inc STINDEX
L3568       jsr GETTOK
            bcc L3568
            tax
            lda OPRTAB-16,X
            bne L3568
            rts

X_BLOAD     lda #$00
            .byte $2C
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
            jsr L3607
            cmp #$FF
            bne L35F7
            iny
            bne L35F7
L359A       lda #<LOW_RTS
            ldy #>LOW_RTS
            sta INITAD
            sty INITAD+1
            jsr L3607
            cmp #$FF
            bne L35AF
            cpy #$FF
            beq L359A
L35AF       sta IOCB0+ICBAL,X
            tya
            sta IOCB0+ICBAH,X
            jsr L3607
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
            bmi L35F9
            jsr L3601
            lda IOCB1+ICSTA
            cmp #$03
            bne L359A
            ldx #$10
            lda #$0C
            sta IOCB0+ICCOM,X
            jsr CIOV
            bit BLOADFLAG
            bpl L35F1
            jsr L3604
L35F1       lda #$FE
            sta PORTB
LOW_RTS     rts
L35F7       lda #$01
L35F9       tay
L35FA       jsr DISROM
            tya
            jmp X_ERR
L3601       jmp (INITAD)
L3604       jmp (RUNAD)
L3607       lda #$07
            ldx #$10
            sta IOCB0+ICCOM,X
            lda #$00
            sta IOCB0+ICBLL,X
            sta IOCB0+ICBLH,X
            jsr CIOV
            bmi L35FA
            pha
            lda #$00
            sta IOCB0+ICBLL,X
            jsr CIOV
            bmi L35FA
            tay
            pla
            rts
;

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
L600A       stx L24F7+1
            sty L24F7+2
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
            lda #$FF
            sta PORTB
            jsr L6101
            lda #$00
            sta BOOT
            lda DOSINI
            ldy DOSINI+1
            sta JMPDOS+1
            sty JMPDOS+2
            lda #$80
            ldy #$20
            sta DOSINI
            sty DOSINI+1
            lda #$FE
            sta PORTB
            sta L00CA
            ldx #$01
            stx BASICF
            stx BOOT
            dex
            stx COLDST
            jsr LE604
            lda #$00
            sta L00A0
            sta L00A1
            jsr LC95F
            ldy #$1F
            ldx #$8A
            jsr L2586
            ldy #$1E
L6084       lda L60A7,Y
            sta (L0097),Y
            dey
            bpl L6084
            jsr LC9C5
            lda #$FF
            pha
            lda #$AE
            pha
            jsr L60C6
            dec PORTB
            lda #$00
            tay
L609E       sta LB000,Y
            dey
            bpl L609E
            jmp LF53A
L60A7       .byte $00,$00,$19,$07,$0D,$67,$14,$19
            .byte $25,$0F,$0D
            .byte 'D:AUTORUN.BAS'
            .byte $16,$01,$00,$06,$06,$16,$16
L60C6       lda #$FF
            sta PORTB
            lda #$C0
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
L6101       ldx #$10
            lda #$D6
            sta IOCB0+ICBAL,X
            lda #$00
            sta IOCB0+ICBAH,X
            sta IOCB0+ICBLH,X
            lda #$04
            sta IOCB0+ICBLL,X
            lda #$07
            sta IOCB0+ICCOM,X
            jsr CIOV
            bmi L6178
            lda #$7C
            sta L00DA
            sta IOCB0+ICBAL,X
            lda #$61
            sta L00DB
            sta IOCB0+ICBAH,X
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
            bmi L6179
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
            bmi L6101
L6178       rts
L6179       jmp (DOSVEC)
;
            ini INIT


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Start of code under ROM, at OS addresses
;
            org $C000

X_DEL       jsr X_DO
            jsr LC0CB
            jsr GETUINT
            sta L00A0
            sty L00A1
            jsr GETUINT
            jsr LC95F
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
LC032       ldx #$8A
            jsr L2620
            jmp LC013
LC03A       jsr LC126
            jmp LF1B5

X_DUMP      iny
            cpy NXTSTD
            bcs LC048
            jsr LC2BE
LC048       lda #$00
            sta L00B9
LC04C       jsr PUTEOL
            lda BRKKEY
            beq LC087
            lda L00B9
            jsr LD_VARF
            lda L009D
            cmp L0088
            lda L009E
            sbc L0089
            bcs LC089
            lda L00B9
            jsr LC06B
            inc L00B9
            bne LC04C
LC06B       jsr LF3B1
            jsr LF202
            lda L00D2
            cmp #$C0
            bcs LC095
            cmp #$80
            bcs LC0B3
            cmp #$40
            bcs LC0B3
            lda #$3D
            jsr PUTCHAR
            jmp LF959

LC087       dec BRKKEY
LC089       lda L00B5
            beq LC094
            jsr LC4F8
            lda #$00
            sta L00B5
LC094       rts
LC095       ldy #$4F
            lsr
            bcs LC0A4
            ldy #$5D
            lsr
            bcs LC0A4
            lda #$3F
            jmp PUTCHAR
LC0A4       tya
            jsr LF34B
            ldy #$00
            lda (FR0),Y
            tax
            iny
            lda (FR0),Y
            jmp PUT_AX
LC0B3       lda FR0+5
            pha
            lda FR0+4
            pha
            lda FR0+3
            ldx FR0+2
            jsr PUT_AX
            lda #$2C
            jsr PUTCHAR
            pla
            tax
            pla
            jmp PUT_AX
LC0CB       txa
            pha
            lda TOPRSTK
            pha
            lda TOPRSTK+1
            pha
            lda L00B2
            pha
            lda L00A0
            pha
            lda L00A1
            pha
LC0DC       jsr X_POP
            bcs LC110
            ldy L00A1
            bne LC0ED
            lda #$80
            sta L00A0
            lda #$C1
            sta L00A1
LC0ED       tay
            bmi LC0FE
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
            ldy #$13
            sta (TOPRSTK),Y
            ldy #$01
            lda (L00A0),Y
            ldy #$14
            sta (TOPRSTK),Y
            bcc LC0DC
LC110       pla
            sta L00A1
            pla
            sta L00A0
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
LC126       pha
            lda TOPRSTK
            pha
            lda TOPRSTK+1
            pha
            lda L00B2
            pha
            lda L00A0
            pha
            lda L00A1
            pha
            lda STMCUR
            pha
            lda STMCUR+1
            pha
            lda L00BE
            pha
            lda L00BF
            pha
            jsr LC182
            jsr LC9C5
LC148       jsr X_POP
            bcs LC171
            pha
            ldy L00A1
            iny
            beq LC158
            jsr SEARCHLINE
            bcc LC15E
LC158       lda #$00
            sta STMCUR
            sta STMCUR+1
LC15E       ldy #$01
            pla
            bpl LC165
            ldy #$13
LC165       lda STMCUR
            sta (TOPRSTK),Y
            iny
            lda STMCUR+1
            sta (TOPRSTK),Y
            jmp LC148
LC171       pla
            sta L00BF
            pla
            sta L00BE
            pla
            sta STMCUR+1
            pla
            sta STMCUR
            jmp LC110
            .byte $FF,$FF
LC182       lda L0086
            sta L00A0
            lda L0087
            sta L00A1
LC18A       lda L00A0
            cmp L0088
            lda L00A1
            sbc L0089
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
            inc L00A1
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
            jsr LE523
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
            jsr LE523
            sta ROWCRS
            rts

X_COLOR     jsr GETINT
            sta L00C8
            rts

X_FCOLOR    jsr GETINT
            sta FILDAT
            rts

X_FILLTO    lda #$12
            .byte $2C
X_DRAWTO    lda #$11
            pha
            jsr X_POSITION
            lda L00C8
            sta ATACHR
            ldx #$60
            lda #$0C
            sta IOCB0+ICAX1,X
            lda #$00
            sta IOCB0+ICAX2,X
            pla
            jmp LC5FE

X_GRAPHICS  ldx #$06
            stx L00C1
            jsr LC4F8
            jsr GETINT
            ldx #<L230D
            ldy #>L230D
            stx INBUFF
            sty INBUFF+1
            ldx #$06
            and #$F0
            eor #$1C
            tay
            lda FR0
            jsr LC3B4
            jmp LC4B9

X_PLOT      jsr X_POSITION
            ldy L00C8
            ldx #$60
            jmp LC29C

LC27E       ldx L00B4
            bne LC287
            lda L00C2
            jsr PUTCHAR
LC287       ldx L00B4
            lda #$05
            jsr LC2AD
            jsr LC502
            jmp LC4B9
PUTEOL      lda #CR
PUTCHAR     ldx L00B5
LC298       tay
            jsr LC2AF
LC29C       lda IOCB0+ICAX1,X
            sta ICAX1Z
            lda IOCB0+ICAX2,X
            sta ICAX2Z
            jsr L24DE
LC2A9       tya
            jmp LC4BF
LC2AD       sta L00C0
LC2AF       stx L00C1
            jmp LDDVX

X_ENTER     lda #$04
            jsr ELADVC
            sta L00B4
            jmp LE67E

LC2BE       lda #$08
            jsr ELADVC
            sta L00B5
            rts

ELADVC      ldy #$07
OPEN_Y_CHN  sty L00C1
            pha
            jsr LDDVX
            jsr IO_CLOSE
            ldy #$03
            sty L00C0
            pla
            ldy #$00
            jsr DO_CIO_STR
            lda #$07
            rts
LC2DE       lda #$FF
            .byte $2C
X_LOAD      lda #$00
            pha
            lda #$04
            jsr ELADVC
            pla
LC2EA       pha
            lda #$07
            sta L00C0
            sta L00CA
            jsr LDDVX
            ldy #$0E
            jsr LC504
            jsr LC4B9
            lda L0580
            ora L0581
            bne LC33C
            ldx #$8C
LC306       clc
            lda LOMEM
            adc L0500,X
            tay
            lda LOMEM+1
            adc L0501,X
            cmp MEMTOP+1
            bcc LC321
            bne LC31E
            cpy MEMTOP
            bcc LC321
LC31E       jmp ERR_19
LC321       sta NGFLAG,X
            sty $00,X
            dex
            dex
            cpx #$82
            bcs LC306
            jsr LC36E
            jsr X_CLR
            lda #$00
            sta L00CA
            pla
            beq LC339
            rts
LC339       jmp LE66B
LC33C       lda #$00
            sta L00CA
            jmp ERR_21
X_SAVE      lda #$08
            jsr ELADVC
LC348       lda #$0B
            sta L00C0
            ldx #$80
LC34E       sec
            lda $00,X
            sbc LOMEM
            sta L0500,X
            inx
            lda $00,X
            sbc LOMEM+1
            sta L0500,X
            inx
            cpx #$8E
            bcc LC34E
            jsr LDDVX
            ldy #$0E
            jsr LC504
            jsr LC4B9
LC36E       jsr LDDVX
            lda L0082
            sta INBUFF
            lda L0083
            sta INBUFF+1
            ldy L058D
            dey
            tya
            ldy L058C
            jsr LC506
            jsr LC4B9
            jmp LC4F8
X_CSAVE     lda #$08
            jsr LC39C
            jmp LC348
X_CLOAD     lda #$04
            jsr LC39C
            lda #$00
            jmp LC2EA
LC39C       pha
            ldx #<L2310
            stx INBUFF
            ldx #>L2310
            stx INBUFF+1
            ldx #$07
            pla
            tay
            lda #$80
            jsr LC3B4
            jsr LC4B9
            lda #$07
            rts
LC3B4       pha
            lda #$03
            jsr LC2AD
            pla
            sta IOCB0+ICAX2,X
            tya
            sta IOCB0+ICAX1,X
            jsr LC50D
            jmp T_INTLBF
X_XIO       jsr GETINT
            .byte $2C
X_OPEN      lda #$03
            sta L00C0
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
            bcs LC400
            jsr EXEXPR
LC3E9       jsr SETSEOL
            jsr LDDVX
            pla
            sta IOCB0+ICAX2,X
            pla
            sta IOCB0+ICAX1,X
            jsr LC502
            jsr RSTSEOL
            jmp LC4B9
LC400       lda #<IO_DIRSPEC
            ldx #>IO_DIRSPEC
            ldy #$05
            jsr LDA71
            jmp LC3E9
X_STATUS    jsr GETIOCHAN
            lda #$0D
            jsr LC51A
            tya
            jmp LC520
X_NOTE      lda #$26
            jsr LC551
            lda IOCB0+ICAX3,X
            ldy IOCB0+ICAX4,X
            jsr LC522
            jsr LDDVX
            lda IOCB0+ICAX5,X
            jmp LC520
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
            lda #$25
            sta L00C0
            jmp LC556
X_PUT       jsr LC49C
LC457       jsr GETINT
            ldx L00C1
            jsr LC298
            ldy STINDEX
            iny
            cpy NXTSTD
            bcc LC457
            rts
X_GET       lda (STMCUR),Y
            cmp #$1C
            beq LC47B
LC46D       jsr LC60D
            jsr LC520
            ldy STINDEX
            iny
            cpy NXTSTD
            bcc LC46D
            rts
LC47B       jsr GETIOCHAN
LC47E       jsr LDDVX
LC481       jsr LC604
            tax
            tya
            jsr LC4BF
            txa
            jsr LC520
            ldy STINDEX
            iny
            cpy NXTSTD
            bcc LC47E
RTS94       rts
X_LOCATE    jsr X_POSITION
            ldx #$60
            bne LC481
LC49C       lda (STMCUR),Y
            cmp #$1C
            beq GETIOCHAN
            lda #$00
            beq LC4A9
GETIOCHAN   jsr LDD78
LC4A9       sta L00C1

LDDVX       lda L00C1
            asl
            asl
            asl
            asl
            tax
            bpl RTS94
            lda #$14
            jmp ERROR

LC4B9       jsr LDDVX
            lda IOCB0+ICSTA,X
LC4BF       bpl RTS94
            ldy #$00
            sty DSPFLG
            cmp #$80
            bne LC4D3
            sty BRKKEY
            ldx L00CA
            beq RTS94
            jmp LE65D
LC4D3       ldy L00C1
            cmp #$88
            beq LC4E8
LC4D9       sta L00B9
            cpy #$07
            bne LC4E2
            jsr LC4F8
LC4E2       jsr LF5D1
            jmp LF8DE
LC4E8       cpy #$07
            bne LC4D9
            ldx #$5D
            cpx L00C2
            bne LC4D9
            jsr LC4F8
            jmp LE66E
LC4F8       jsr LDDVX
            beq RTS94

IO_CLOSE    lda #$0C
            jmp LC51A

LC502       ldy #$FF
LC504       lda #$00
LC506       sta IOCB0+ICBLH,X
            tya
            sta IOCB0+ICBLL,X
LC50D       lda INBUFF+1
            ldy INBUFF
            sta IOCB0+ICBAH,X
            tya
            sta IOCB0+ICBAL,X
LC518       lda L00C0
LC51A       sta IOCB0+ICCOM,X
            jmp B_CIOV
LC520       ldy #$00
LC522       pha
            tya
            pha
            jsr EXEXPR
            pla
            sta FR0+1
            pla
            sta FR0
            jsr T_IFP
            jmp LE5C0
LC534       lda #$00
            ldx #$07
LC538       sta AUDF1,X
            dex
            bpl LC538
            ldy #$07
            sty L00C1
LC542       jsr LC4F8
            dec L00C1
            bne LC542
            rts

X_CLOSE     iny
            cpy NXTSTD
            bcs LC534
            lda #$0C
LC551       sta L00C0
            jsr GETIOCHAN
LC556       jsr LC518
            jmp LC4B9

LC55C       ldx #$06
LC55E       stx CIX
            lda PROMPT,X
            jsr PUTCHAR
            ldx CIX
            dex
            bpl LC55E
            rts

PROMPT      .byte CR, 'YDAER', CR

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
            jmp T_INTLBF

X_DIR       lda #$06
            jsr ELADVC
LC5A5       ldx #$70
            jsr LC604
            bmi LC5B3
            ldx #$00
            jsr LC298
            bpl LC5A5
LC5B3       tya
            pha
            ldx #$70
            jsr IO_CLOSE
            pla
            cmp #$88
            beq LC5C2
            jmp ERROR
LC5C2       rts

X_RENAME    lda #$20
            .byte $2C
X_LOCK      lda #$23
            .byte $2C
X_UNLOCK    lda #$24
            .byte $2C
X_DELETE    lda #$21
            sta L00C0
            lda #$07
            sta L00C1
            lda #$00
            tay
            jmp DO_CIO_STR

X_BPUT      lda #$0B
            .byte $2C
X_BGET      lda #$07
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
LC5FE       jsr LC51A
            jmp LC2A9
LC604       lda #$07
            sta L00C0
            ldy #$00
            jmp LC504
LC60D       jsr L24F4
            cpy #$80
            bcs LC615
            rts
LC615       jmp LC2A9
X_PPUT      lda #$0B
            .byte $2C
X_PGET      lda #$07
            sta L00C0
            jsr LC49C
LC622       jsr LE56B
            jsr LDDVX
            lda #$D4
            sta INBUFF
            lda #$00
            sta INBUFF+1
            ldy #$06
            jsr LC504
            jsr T_INTLBF
            jsr LC4B9
            lda L00C0
            cmp #$07
            bne LC644
            jsr LE5C0
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
X_ARRCOMMA  inc L00B0
X_RPAREN    ldy OPSTKX
            pla
            pla
            jmp EXOPOP
X_DIMLPAREN  lda #$40
            sta L00B1
X_ARRLPAREN  bit L00B1
            bpl LC69E
            lda ARSLVL
            sta L00AF
            dec ARSLVL
LC69E       lda L00B0
            tay
            beq LC6AA
            dec L00B0
            jsr X_POPINT
            bmi LC6C3
LC6AA       sty L0098
            sta L0097
            jsr X_POPINT
            bmi LC6C3
            sta L00F5
            sty L00F6
            jsr X_POPVAL
            bit L00B1
            bvc LC6C6
            lda #$00
            sta L00B1
            rts
LC6C3       jmp ERR_9
LC6C6       lsr L00D2
            bcc LC6C3
            lda L00F5
            cmp FR0+2
            lda L00F6
            sbc FR0+3
            bcs LC6C3
            lda L0097
            cmp FR0+4
            lda L0098
            sbc FR0+5
            bcs LC6C3
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
            adc L008C
            sta L00F5
            tya
            adc L008D
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
X_STRLPAREN lda L00B0
            beq LC7AD
            jsr LC80F
            sty L0098
            sta L0097
LC7AD       jsr LC80F
            sec
            sbc #$01
            sta L00F5
            tya
            sbc #$00
            sta L00F6
            jsr X_POPVAL
            lda L00B1
            bpl LC7CC
            ora L00B0
            sta L00B1
            ldy FR0+5
            lda FR0+4
            jmp LC7D0
LC7CC       lda FR0+2
            ldy FR0+3
LC7D0       ldx L00B0
            beq LC7E4
            dec L00B0
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
LC7F7       jsr LE4DF
            clc
            lda FR0
            adc L00F5
            sta FR0
            lda FR0+1
            adc L00F6
            sta FR0+1
            bit L00B1
            bpl LC80C
LC80B       rts
LC80C       jmp X_PUSHVAL
LC80F       jsr X_POPINT
            bne LC80B
            tax
            bne LC80B
LC817       lda #$05
            jmp ERROR
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
            sbc L008C
            sta L00F9
            txa
            sbc L008D
            sta L00FA
            jsr L265D
            lda L00D3
            jsr LD_VARF
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
            jmp LE5C0
X_DIM       ldy STINDEX
            cpy NXTSTD
            bcc LC8A7
            rts
LC8A7       jsr EXEXPR
            lsr L00D2
            bcs LC915
            sec
            rol L00D2
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
LC92C       ldx #$8E
            jsr L2588
            sec
            lda L0097
            sbc L008C
            sta FR0
            lda L0098
            sbc L008D
            sta FR0+1
            jsr LE5C0
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
LC95F       jsr LC9C5
SEARCHLINE  lda STMCUR
            sta L00BE
            lda STMCUR+1
            sta L00BF
            lda L00A1
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
            cmp L00A0
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
LC99D       lda #$C1
            .byte $2C
LC9A0       lda #$C2
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
LC9C5       lda L0099
            pha
            lda L009A
            pha
            lda #$00
            tay
LC9CE       sta (LOMEM),Y
            iny
            iny
            bne LC9CE
            lda L0089
            sta L009A
            lda L0088
LC9DA       sta L0099
            ldy #$04
            lda (L0099),Y
            cmp #$4F
            beq LC99D
            cmp #$5D
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
LCA0A       lda L0088
            sta L0099
            lda L0089
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
LCA35       lda #$1E
            jmp ERROR

LCA3A       lda (STMCUR),Y
            iny
            cpy NXTSTD
            bcs LCA5B
            cmp #$1C
            bne LCA5F
            inc STINDEX
            jsr GETTOK
            lda L00D2
            cmp #$C2
            bne LCA35
            ldy #$00
            lda (FR0),Y
            tax
            iny
            lda (FR0),Y
            tay
            txa
            rts
LCA5B       lda #$00
            tay
            rts
LCA5F       jmp GETINT

X_RESTORE   jsr LCA3A
            cpy #$00
            bmi ERR_3D
            sta L00B7
            sty L00B8
            lda #$00
            sta L00B6
            rts

ERR_3D      jmp ERR_3

X_READ      lda L00B7
            sta L00A0
            lda L00B8
            sta L00A1
            jsr SEARCHLINE
            lda STMCUR
            sta INBUFF
            lda STMCUR+1
            sta INBUFF+1
            lda L00BE
            sta STMCUR
            lda L00BF
            sta STMCUR+1
LCA90       ldy #$00
            lda (INBUFF),Y
            sta L00B7
            iny
            lda (INBUFF),Y
            sta L00B8
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
            bmi LCB06
            sec
            lda CIX
            adc INBUFF
            sta INBUFF
            lda #$00
            sta L00B6
            adc INBUFF+1
            sta INBUFF+1
            bcc LCA90
LCAD5       lda #$00
            sta L00F5
LCAD9       lda L00F5
            cmp L00B6
            bcs LCAF1
LCADF       inc CIX
            ldy CIX
            lda (INBUFF),Y
            cmp #CR
            beq LCABE
            cmp #$2C
            bne LCADF
            inc L00F5
            bne LCAD9
LCAF1       lda #$40
            sta L00A6
            inc CIX
            jmp LCB42
LCAFA       ldy CIX
            lda (INBUFF),Y
            cmp #$2C
            clc
            beq LCB05
            cmp #CR
LCB05       rts
LCB06       lda #$06
            jmp ERROR
X_INPUT     lda #$3F
            sta L00C2
            lda (STMCUR),Y
            cmp #$0F
            bne LCB27
            jsr LE486
            jsr LCBDD
            ldy STINDEX
            inc STINDEX
            lda (STMCUR),Y
            cmp #$12
            bne LCB27
            ror L00B4
LCB27       jsr GETTOK
            dec STINDEX
            bcc LCB33
            jsr LDD78
            sta L00B4
LCB33       jsr T_INTLBF
            jsr LC27E
            jsr LCB5B
            ldy #$00
            sty L00A6
            sty CIX
LCB42       jsr GETTOK
            inc STINDEX
            lda L00D2
            bmi LCB6E
            jsr T_AFP
            bcs LCB65
            jsr LCAFA
            bne LCB65
            jsr LE5C0
            jmp LCBAC
LCB5B       lda BRKKEY
            beq LCB60
            rts
LCB60       dec BRKKEY
            jmp LF5A4
LCB65       lda #$00
            sta L00B4
            lda #$08
            jmp ERROR
LCB6E       ldy #$00
            lda #$11
            sta OPSTK
            sty OPSTKX
            sty L00B0
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
            cmp #$2C
            bne LCB88
            bit L00A6
            bvc LCB88
LCB9B       ldy L00F5
            lda STINDEX
            pha
            txa
            ldx #$F3
            jsr LE48B
            pla
            sta STINDEX
            jsr LC81F
LCBAC       bit L00A6
            bvc LCBC1
            inc L00B6
            ldx STINDEX
            inx
            cpx NXTSTD
            bcs LCBC8
            jsr LCAFA
            bcc LCBD8
            jmp LCABE
LCBC1       ldx STINDEX
            inx
            cpx NXTSTD
            bcc LCBD0
LCBC8       jsr T_INTLBF
            lda #$00
            sta L00B4
            rts
LCBD0       jsr LCAFA
            bcc LCBD8
            jmp LCB33
LCBD8       inc CIX
            jmp LCB42
LCBDD       ldx #$00
            lda FR0
            sta IOCB0+ICBAL,X
            lda FR0+1
            sta IOCB0+ICBAH,X
            lda FR0+2
            sta IOCB0+ICBLL,X
            lda FR0+3
            sta IOCB0+ICBLH,X
            lda #$0B
            jmp LC5FE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Second part
;
            org $D800

X_MOVE      jsr GET3INT
            sta L00A2
            sty L00A3
            jmp L265D

X_NMOVE     jsr GET3INT
            sta L00A2
            sty L00A3
            jmp L25DE

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
            .byte $2C
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
            sta L00D2
            sta L00D3
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
LD9CD       jsr LEA68
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

LDA05       jsr T_INTLBF
            ldy #$00
            lda FR0+1
            beq LDA11
            jsr LDA13
LDA11       lda FR0
LDA13       pha
            lsr
            lsr
            lsr
            lsr
            jsr LDA1E
            pla
            and #$0F
LDA1E       ora #$30
            cmp #$3A
            bcc LDA26
            adc #$06
LDA26       sta (INBUFF),Y
            iny
            rts
X_HEXP      jsr X_POPINT
            jsr LDA05
            lda #$80
            bne LDA6F
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
            bne LDA6F
X_INKEYP    lda CH
            ldy #$00
            cmp #$C0
            bcs LDA6D
            ldx #$0E
LDA55       cmp LDC93,X
            beq LDA6D
            dex
            bpl LDA55
            jsr LC60D
            jmp LDA68
X_CHRP      jsr X_POPINT
            lda FR0
LDA68       sta L05C0
            ldy #$01
LDA6D       lda #$C0
LDA6F       ldx #$05
LDA71       stx FR0+1
            sta FR0
            sty FR0+2
            lda #$00
            sta FR0+3
            sta L00D3
            lda #$83
            sta L00D2
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
            jsr L2DB8
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
            jsr L2DB8
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
            bcs LDB37
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
            bpl LDB37
            tay
            beq LDB37
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
LDB37       jmp X_PUSHVAL
LDB3A       asl FR0
LDB3C       jsr T_ZFR0
            bcc LDB37
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

LDB82       jmp X_N0
LDB85       jmp X_N1

LDB88       lda FR1
            bpl LDB82
ERR_3E      jmp ERR_3

X_POW       jsr X_POPVAL2
            lda FR1
            beq LDB85
            lda FR0
            beq LDB88
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
            bne LDC1A
            lda FR1+2
            ora FR1+3
            ora FR1+4
            ora FR1+5
            bne LDC1A
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
            jsr L2EB5
            lsr L00FC
            bcs LDBF6
            jsr T_FLD1
LDBF6       jsr L2ED4
            lda L00FC
            beq LDC4D
            jsr LDPLYARG
LDC00       jsr T_FSQ
            bcs LDC14
            lsr L00FC
            bcc LDC00
            jsr L2EB5
            jsr L2F23
            jsr T_FMUL
            bcc LDBF6
LDC14       jmp ERR_11

ERR_3F      jmp ERR_3

LDC1A       lda FR1+5
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
            bcs LDC14
            jsr L2F59
            bcs LDC14
LDC4D       pla
            bpl LDC54
            ora FR0
            sta FR0
LDC54       jmp X_PUSHVAL
X_DEG       lda #$06
            .byte $2C
X_RAD       lda #$00
            sta L00FB
            rts
LDC5F       jsr X_POPINT
            sta FR1
            sty FR1+1
            jmp X_POPINT
X_BITAND    jsr LDC5F
            tya
            and FR1+1
            tay
            lda FR1
            and FR0
            jmp X_RET_AY
X_BITOR     jsr LDC5F
            tya
            ora FR1+1
            tay
            lda FR1
            ora FR0
            jmp X_RET_AY
X_EXOR      jsr LDC5F
            tya
            eor FR1+1
            tay
            lda FR1
            eor FR0
            jmp X_RET_AY

LDC93       .byte $9A,$98,$9D,$9B,$B3,$B5,$B0,$B2
            .byte $A6,$3C,$7C,$BC,$27,$67,$A7

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

X_ERR       lda L00C3
            jmp X_RET_A

X_ERL       lda L00BA
            ldy L00BB
            jmp X_RET_AY
LDCF0       inc L00C9
X_PRINT     lda L00C9
            beq LDCF0
            sta L00AF
            lda #$00
            sta L0094
LDCFC       ldy STINDEX
            lda (STMCUR),Y
            cmp #$12
            beq LDD50
            cmp #$16
            beq LDD82
            cmp #$14
            beq LDD82
            cmp #$15
            beq LDD7D
            cmp #$1C
            beq LDD6E
            jsr EXEXPR
            dec STINDEX
            ldx ARSLVL
            lda VARSTK0,X
            bmi LDD23
            jsr X_STRP
LDD23       jsr X_POPSTR
            ldx L00B5
            jsr LC2AF
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
            beq LDCFC
            lda #$0B
            jsr LC5FE
            jmp LDCFC
LDD50       ldy L0094
            iny
            cpy L00AF
            bcc LDD60
            clc
            lda L00C9
            adc L00AF
            sta L00AF
            bcc LDD50
LDD60       ldy L0094
            cpy L00AF
            bcs LDD7D
            jsr LF202
            inc L0094
            jmp LDD60
LDD6E       jsr LDD78
            sta L00B5
            dec STINDEX
            jmp LDCFC
LDD78       inc STINDEX
            jmp GETINT
LDD7D       inc STINDEX
            jmp LDCFC
LDD82       ldy STINDEX
            dey
            lda (STMCUR),Y
            cmp #$15
            beq LDD92
            cmp #$12
            beq LDD92
            jsr PUTEOL
LDD92       lda #$00
            sta L00B5
            rts
X_LPRINT    lda #$13
            sta INBUFF
            lda #$23
            sta INBUFF+1
            dec L00DB
            ldx #$07
            stx L00B5
            lda #$00
            ldy #$08
            jsr LC3B4
            jsr LC4B9
            jsr X_PRINT
            jmp LC4F8
X_UINSTR    lda #$5F
            .byte $2C
X_INSTR     lda #$FF
            sta L00DF
            ldy L00B0
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
LDE60       sta FR0+2
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
            lda #$01
LDE97       sta FR0+1
            ldx #$16
            lda #$00
LDE9D       sta FR0+2,X
            dex
            bpl LDE9D
            lda FR0+1
            sta FR1
            inx
            jsr LDE60
            lda FR0
            ldx #$02
            jsr LDE60
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
LDED5       jsr ADD_XPOS
            jsr ADD_Y_PLOT
            jsr ADD_XPOS
            jsr SUB_Y_PLOT
            jsr SUB_XPOS
            jsr ADD_Y_PLOT
            jsr SUB_XPOS
            jsr SUB_Y_PLOT
            bit FR1+2
            bmi LDF12
            inc FR1+1
            clc
            lda L00EB
            adc L00E6
            sta L00EB
            lda L00EA
            adc FR1+5
            sta L00EA
            bcc LDF04
            inc L00E9
LDF04       sec
            ldx #$02
LDF07       lda FR1+2,X
            sbc L00E9,X
            sta FR1+2,X
            dex
            bpl LDF07
            bmi LDED5
LDF12       lda FR1
            beq CLEAR_XYPOS
            dec FR1
            sec
            lda L00DC
            sbc L00E8
            sta L00DC
            lda L00DB
            sbc L00E7
            sta L00DB
            bcs LDF29
            dec L00DA
LDF29       clc
            ldx #$02
LDF2C       lda FR1+2,X
            adc L00DA,X
            sta FR1+2,X
            dex
            bpl LDF2C
            bmi LDED5
ADD_XPOS    clc
            lda L0099
            adc FR1
            sta COLCRS
            lda L009A
            adc #$00
            sta COLCRS+1
            rts

CLEAR_XYPOS  ldx #$00
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
            beq LDF77
LDF69       rts
SUB_Y_PLOT  sec
            lda L009B
            sbc FR1+1
            sta ROWCRS
            lda L009C
            sbc #$00
            bne LDF69
LDF77       ldy L00C8
            ldx #$60
            jsr L24DE
            cpy #$80
            bne LDF69
            jmp LC2A9

LDF85       sty L0096
            ldx #$00
            stx L00AF
LDF8B       sta L0095
            ldx CIX
            ldy #$00
            lda (L0095),Y
            beq LDFBC
LDF95       lda L0580,X
            and #$7F
            inx
            eor (L0095),Y
            bne LDFA2
            iny
            bne LDF95
LDFA2       asl
            beq LDFBA
            bcs LDFAD
LDFA7       iny
            lda (L0095),Y
            bpl LDFA7
LDFAC       sec
LDFAD       inc L00AF
            beq LDFBE
            tya
            adc L0095
            bcc LDF8B
            inc L0096
            bcs LDF8B
LDFBA       clc
            rts
LDFBC       sec
            rts
LDFBE       lda #$04
            jmp ERROR
STSEARCH    ldx #$00
            stx L00AF
            sty L0096
LDFC9       sta L0095
            ldx CIX
            ldy #$01
            lda (L0095),Y
            beq LDFBC
LDFD3       lda L0580,X
            and #$7F
            inx
            cmp #$2E
            beq LDFBA
            eor (L0095),Y
            bne LDFE4
            iny
            bne LDFD3
LDFE4       asl
            beq LDFBA
            bcs LDFEE
LDFE9       iny
            lda (L0095),Y
            bpl LDFE9
LDFEE       inc L00AF
LDFF0       sec
            tya
            adc L0095
            bcc LDFC9
            inc L0096
            bcs LDFC9

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Third part, after character map
;
            org $E400

EXEXPR      ldy #$00
            lda #$11
            sta OPSTK
            sty OPSTKX
            sty L00B0
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
            bmi LE4B1
            beq LE4AC
            cmp #$0F
            bcc LE460
            beq LE486
            rts
LE460       iny
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
            sta L00D2
            rts
LE486       iny
            lda (STMCUR),Y
            ldx #$8A
LE48B       sta FR0+2
            sta FR0+4
            iny
            tya
            clc
            adc $00,X
            sta FR0
            lda #$00
            sta FR0+3
            sta FR0+5
            adc NGFLAG,X
            sta FR0+1
            tya
            adc FR0+2
            tay
            lda #$83
            sta L00D2
            sty STINDEX
            clc
            rts
LE4AC       iny
            inc STINDEX
            lda (STMCUR),Y
LE4B1       eor #$80
LD_VARF     sta L00D3
            jsr VAR_PTR
            lda (L009D),Y
            sta L00D2
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
LE4DF       lda #$02
            bit L00D2
            bne LE4FA
            ora L00D2
            sta L00D2
            lsr
            bcc ERR_9
            clc
            lda FR0
            adc L008C
            sta FR0
            tay
            lda FR0+1
            adc L008D
            sta FR0+1
LE4FA       rts
GETUINT     jsr GETINT
            bpl LE4FA
            lda #$07
            jmp ERROR
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
LE523       jsr GETINT
            beq LE4FA
ERR_3       lda #$03
            .byte $2C
ERR_9       lda #$09
            .byte $2C
ERR_11      lda #$0B
            .byte $2C
ERR_10      lda #$0A
            jmp ERROR

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
            lda L00D3
            sta VARSTK1,Y
            lda L00D2
            sta VARSTK0,Y
            rts

LE56B       jsr EXEXPR
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
            sta L00D3
            lda VARSTK0,Y
            sta L00D2
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

LE5C0       lda L00D3
            jsr VAR_PTR
            lda L00D2
            sta (L009D),Y
            iny
            lda L00D3
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
VAR_PTR     asl
            rol
            rol
            rol
            tay
            ror
            and #$F8
            clc
            adc L0086
            sta L009D
            tya
            and #$07
            adc L0087
            sta L009E
            ldy #$00
            rts
LE604       lda #$00
            sta MEOLFLG
            sta L00CA
            lda MEMLO
            ldy MEMLO+1
            sta LOMEM
            sty LOMEM+1
            iny
            sta L0082
            sty L0083
            sta L0084
            sty L0085
            clc
            adc #$01
            bcc LE623
            iny
LE623       sta L0086
            sty L0087
            sta L0088
            sty L0089
            sta STMCUR
            sty STMCUR+1
            clc
            adc #$03
            bcc LE635
            iny
LE635       sta L008C
            sty L008D
            sta L008E
            sty L008F
            sta TOPRSTK
            sty TOPRSTK+1
            sta APPMHI
            sty APPMHI+1
            lda #$00
            tay
            sta (L0084),Y
            sta (STMCUR),Y
            iny
            lda #$80
            sta (STMCUR),Y
            iny
            lda #$03
            sta (STMCUR),Y
            lda #$0A
            sta L00C9
            jmp LFF66
LE65D       ldx #$FF
            txs
            cld
            lda L00CA
            beq LE668
X_NEW       jsr LE604
LE668       jsr LF6E7
LE66B       jsr LC534
LE66E       jsr LF5D1
            lda MEOLFLG
            beq LE678
            jsr RSTSEOL
LE678       jsr LC55C
LE67B       jsr LC0CB
LE67E       lda L00CA
            bne X_NEW
            ldx #$FF
            txs
            cld
            jsr T_INTLBF
            lda #$5D
            sta L00C2
            jsr LC287
            lda BRKKEY
            bne LE698
            dec BRKKEY
            bne LE67E
LE698       ldy #$00
            sty CIX
            sty LLNGTH
            sty L0094
            sty L00A6
            sty L00B3
            sty L00B0
            sty L00B1
            lda L0084
            sta L00AD
            lda L0085
            sta L00AE
            jsr UCASEBUF
            jsr LE7FB
            jsr LE8F7
            lda FR0+1
            bpl LE6BF
            sta L00A6
LE6BF       jsr UCASEBUF
            sty STINDEX
            lda (INBUFF),Y
            cmp #CR
            bne LE6D1
            bit L00A6
            bmi LE67E
            jmp LE7E0
LE6D1       lda L0094
            sta NXTSTD
            jsr LE8F7
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
            sta L0095
            lda #>SNT_END
            sta L0096
            lda #$15
            ldx L00DA
STFOUND     stx CIX
            jsr LE8F7
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
LE741       jsr LE8F7
LE744       ldy CIX
            lda (INBUFF),Y
            inc CIX
            cmp #CR
            bne LE741
            jsr LE8F7
LE751       lda L0094
            ldy NXTSTD
            sta VARSTK0,Y
            ldy CIX
            dey
            lda (INBUFF),Y
            cmp #CR
            beq LE764
            jmp LE6D1
LE764       ldy #$02
            lda L0094
            sta VARSTK0,Y
            jsr LC95F
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
            ldx #$8A
            jsr L2586
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
LE79A       ldx #$8A
            jsr L2620
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
            ldx #$88
            jsr L2620
            sec
            lda L0084
            sbc L00AD
            tay
            lda L0085
            sbc L00AE
            ldx #$84
            jsr L2622
            bit L00A6
            bpl LE7D2
            jsr LF231
            jmp LE67E
LE7D2       jsr PRINTLINE
LE7D5       jmp LE67E
LE7D8       bpl LE7D5
            jsr LC126
            jmp LFFAF
LE7E0       jsr LC95F
            bcs LE7D5
            ldy #$02
            lda (STMCUR),Y
            tay
            clc
            adc STMCUR
            sta STMCUR
            bcc LE7F3
            inc STMCUR+1
LE7F3       ldx #$8A
            jsr L2620
            jmp LE67E
LE7FB       jsr T_AFP
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
LE813       sty L00A1
            sta L00A0
            jsr LE8F7
            lda L00A1
            sta FR0+1
            jmp LE8F7

LE821       ldy #$00
            sty OPSTKX
            lda (L0095),Y
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
            jsr LE874
            bcc LE843
            jmp LE8BC
LE874       pha
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
LE8E5       rts
LE8E6       cmp #$0F
            bne LE92B
            inc L009D
            bne LE8F0
            inc L009E
LE8F0       ldx #$00
            lda (L009D,X)
            clc
            dec L0094
LE8F7       ldy L0094
            sta VARSTK0,Y
            inc L0094
            bne LE8E5
ERR_14      lda #$0E
            jmp ERROR


            ; Exit after parsing "THEN", skip to parse next statement
LEIF        ldx #$FF
            txs
            lda L0094
            ldy NXTSTD
            sta VARSTK0,Y
            jmp LE6D1

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
LE92B       jsr UCASEBUF
            cpy L00B3
            beq LE946
            sty L00B3
            ldy #>OPNTAB
            lda #<OPNTAB
            jsr LDF85
            bcs LE969
            stx L00B2
            clc
            lda L00AF
            adc #$10
            sta L00B0
LE946       ldy #$00
            lda (L009D),Y
            cmp L00B0
            beq LE960
            cmp #$44
            bne LE95C
            lda L00B0
            cmp #$56
            bcs LE95C
            cmp #$44
            bcs LE95E
LE95C       sec
            rts
LE95E       lda L00B0
LE960       jsr LE8F7
            ldx L00B2
            stx CIX
            clc
            rts
LE969       lda #$00
            sta L00B0
            sec
            rts

            ; Check label variable name
LLVARN      lda #$C0
            bne GETVARN

            ; Check numeric variable name
LNVARN      lda #$00
            beq GETVARN

            ; Check string variable name
LSTVARN     lda #$80
GETVARN     sta L00D2
            jsr UCASEBUF
            sty TVSCIX
            jsr LEA53
            bcs LE9AD
            jsr LE92B
            lda L00B0
            beq LE994
            ldy L00B2
            lda (INBUFF),Y
            cmp #$30
            bcc LE9AD
LE994       inc CIX
            jsr LEA53
            bcc LE994
            cmp #$30
            bcc LE9A3
            cmp #$3A
            bcc LE994
LE9A3       cmp #$24
            beq LE9AF
            bit L00D2
            bpl LE9B8
            bvs LE9C5
LE9AD       sec
            rts
LE9AF       bit L00D2
            bpl LE9AD
            bvs LE9AD
            iny
            bne LE9C5
LE9B8       lda (INBUFF),Y
            cmp #$28
            bne LE9C5
            iny
            lda #$40
            ora L00D2
            sta L00D2
LE9C5       lda TVSCIX
            sta CIX
            sty TVSCIX
            ldy L0083
            lda L0082
            jsr LDF85
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
            ldx #$84
            jsr L2586
            lda L00AF
            sta L00D3
            ldy CIX
            dey
            ldx TVSCIX
            dex
            lda L0580,X
            ora #$80
LE9FA       sta (L0097),Y
            dex
            lda L0580,X
            dey
            bpl LE9FA
            ldy #$08
            ldx #$88
            jsr L2586
            inc L00B1
            jsr T_ZFR0
            ldy #$07
LEA11       lda L00D2,Y
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
            eor L00D2
            tay
            stx L009E
            pla
            sta L009D
            cpy #$80
            pla
            tay
            bcs LE9D8
            bit L00D2
            bvc LEA3D
            bmi LEA3D
            dec TVSCIX
LEA3D       lda TVSCIX
            sta CIX
            lda L00AF
            bpl LEA4C
            lda #$00
            jsr LE8F7
            lda L00AF
LEA4C       eor #$80
            jsr LE8F7
LEA51       clc
            rts
LEA53       ldy CIX
            lda (INBUFF),Y
LEA57       cmp #$5F
            beq LEA51
            cmp #$41
            bcc LEA66
            cmp #$5B
            rts
LEA62       ldy TVSCIX
            sty CIX
LEA66       sec
            rts
LEA68       ldy CIX
            lda (INBUFF),Y
            sec
            sbc #$30
            bcc LEA66
            cmp #$0A
            bcc LEA7F
            cmp #$11
            bcc LEA66
            sbc #$07
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
            cmp #$24
            beq LEAA2
            jsr T_AFP
            bcc LEAC0
            bcs LEA62
LEAA2       inc CIX
            jsr UCASEBUF
            jsr T_ZFR0
            jsr LEA68
            bcs LEA62
LEAAF       jsr LEA68
            bcs LEABA
            lda FR0+1
            and #$F0
            beq LEAAF
LEABA       jsr T_IFP
            lda #$0D
            .byte $2C
LEAC0       lda #$0E
            jsr LE8F7
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
            jsr LE8F7
            lda L0094
            sta EXSVOP
LEAEC       jsr LE8F7
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
            ; SCOMP : '<=' (as CSLE) | '<>' (as CSNE) ... etc
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
LOPR        jsr LE92B
            lda L00B0
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

X_LIST      jsr X_DO
            ldy #$00
            sty L00A0
            sty L00A1
            sty L00B9
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
            lda L00D2
            bpl LF14F
            jsr LC2BE
            jmp LF135

LF14F       jsr GETUINT
            sty L00A1
            sta L00A0
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
            jsr LC4F8
            lda #$00
            sta L00B5
LF1B2       sta DSPFLG
LF1B5       jsr X_POP
            jmp POP_RETURN
LF1BB       stx ARSLVL
            sta L0096
            sty L0095
LF1C1       ldy ARSLVL
            lda L00AF
            beq LF1D7
            dec L00AF
LF1C9       lda (L0095),Y
            bmi LF1D0
            iny
            bne LF1C9
LF1D0       iny
            jsr LF1D7
            jmp LF1C1
LF1D7       clc
            tya
            adc L0095
            sta L0095
            bcc LF1E1
            inc L0096
LF1E1       rts
LF1E2       ldy #$FF
            sty L00AF
LF1E6       inc L00AF
            ldy L00AF
            lda (L0095),Y
            pha
            cmp #CR
            beq LF1F5
            and #$7F
            beq LF1F8
LF1F5       jsr PUTCHAR
LF1F8       pla
            bpl LF1E6
            rts
LF1FC       jsr LF202
LF1FF       jsr LF1E2
LF202       lda #$20
            jmp PUTCHAR

PRINTLINE   ldy #$00
            lda (STMCUR),Y
            tax
            iny
            lda (STMCUR),Y
            jsr PUT_AX
            ldx F_LIST
            beq LF228
            ldx L00B9
            ldy #$04
            lda (STMCUR),Y
            jsr CHKELOOP
            beq LF226
            cmp #$40
            bne LF228
LF226       dex
            dex
LF228       stx FR0
LF22A       jsr LF202
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
LF249       jsr LF33A
            cmp #TOK_INVLET ; list an invisible "LET"
            beq LF282
            cmp #TOK_LREM   ; list a "--"
            beq LF26B
            jsr LF346
            jsr LF33A
            cmp #TOK_ERROR
            beq LF262
            cmp #TOK_DATA+1 ; First statements are "REM" and "DATA"
            bcs LF282
LF262       jsr LF338
            jsr PUTCHAR
            jmp LF262
LF26B       ldy #$1E
            lda F_LIST
            bne LF274
            ldy #$02
LF274       sty FR0
LF276       lda #'-'
            jsr PUTCHAR
            dec FR0
            bne LF276
            jmp PUTEOL
LF282       jsr LF338
            bne LF28B
            jsr LF338
            .byte $2C
LF28B       bpl LF29C
            eor #$80
            jsr LF3B1
            cmp #$A8
            bne LF282
            jsr LF338
            jmp LF282
LF29C       cmp #$0F
            beq LF2CE
            bcs LF2F7
            pha
            jsr LE460
            dec STINDEX
            pla
            cmp #$0D
            bne LF2BF
            lda #$24
            jsr PUTCHAR
            jsr T_FPI
            jsr LDA05
            ora #$80
            sta L057F,Y
            bne LF2C2
LF2BF       jsr T_FASC
LF2C2       jsr LF95C
            jmp LF282
LF2C8       jsr LF1E2
            jmp LF282
LF2CE       jsr LF338
            sta L00AF
            lda #'"'
            jsr PUTCHAR
            lda L00AF
            beq LF2EF
LF2DC       jsr LF338
            cmp #'"'
            bne LF2E8
            jsr PUTCHAR
            lda #'"'
LF2E8       jsr PUTCHAR
            dec L00AF
            bne LF2DC
LF2EF       lda #'"'
            jsr PUTCHAR
            jmp LF282
LF2F7       sec
            sbc #$10
            sta L00AF
            ldx #$00
            lda #>OPNTAB
            ldy #<OPNTAB
            jsr LF1BB
            jsr LF33A
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
            lda (L0095),Y
            and #$7F
            jsr LEA57
            bcs LF2C8
LF32F       jsr LF202
LF332       jsr LF1FF
            jmp LF282
LF338       inc STINDEX
LF33A       ldy STINDEX
            cpy NXTSTD
            bcs LF343
            lda (STMCUR),Y
            rts
LF343       pla
            pla
            rts
LF346       pha
            jsr LF359
            pla
LF34B       sta L00AF
            ldx #$01
            lda #>SNTAB
            ldy #<SNTAB
            jsr LF1BB
            jmp LF1FF
LF359       cmp #TOK_FOR
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
LF376       dec L00B9
            dec L00B9
            bpl LF382
LINDENT     inc L00B9
            inc L00B9
            bmi LF376
LF382       rts
LF383       lda STINDEX
            pha
            jsr L3566
            pla
            sta STINDEX
            cpx #$1B
            bne LINDENT
            rts
F_LIST      .byte $01

X_FL        lda (STMCUR),Y
            eor #$26
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

LF3B1       sta L00AF
            ldx #$00
            lda L0083
            ldy L0082
            jsr LF1BB
            jmp LF1E2

X_FOR       sty L00B3
            lda (STMCUR),Y
            bne LF3C8
            iny
            lda (STMCUR),Y
LF3C8       eor #$80
            sta L00C7
            jsr EXEXPR
            ldx TOPRSTK
            stx L00C4
            ldx TOPRSTK+1
            stx L00C5
LF3D7       jsr X_POP
            bcs LF3E8
            bne LF3E8
            ldy #$0C
            lda (TOPRSTK),Y
            cmp L00C7
            bne LF3D7
            beq LF3F0
LF3E8       lda L00C4
            sta TOPRSTK
            lda L00C5
            sta TOPRSTK+1
LF3F0       lda #$0D
            jsr LF654
            jsr LE56B
            ldy #$00
            jsr LF680
            jsr T_FLD1
            ldx STINDEX
            inx
            cpx NXTSTD
            bcs LF40A
            jsr LE56B
LF40A       ldy #$06
            jsr LF680
            lda F_FOR
            bne LF440
LF414       lda L00C7
            ldy #$0C
            sta (L00C4),Y
            lda #$00
            beq LF423

X_DO        lsr
            ldy STINDEX
            sty L00B3
LF423       pha
            lda #$04
            jsr LF654
            pla
            ldy #$00
            sta (L00C4),Y
            lda STMCUR
            iny
            sta (L00C4),Y
            lda STMCUR+1
            iny
            sta (L00C4),Y
            ldx L00B3
            dex
            txa
            iny
            sta (L00C4),Y
LF43F       rts
LF440       lda TOPRSTK
            pha
            lda TOPRSTK+1
            pha
            lda L00C4
            sta TOPRSTK
            lda L00C5
            sta TOPRSTK+1
            lda FR0
            pha
            lda L00C7
            jsr LD_VARF
            pla
            jsr LF4E5
            bcc LF464
            pla
            sta TOPRSTK+1
            pla
            sta TOPRSTK
            bcs LF414
LF464       pla
            pla
            lda #$08
            ldx #$09
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
            jmp ERROR
LF482       lda L00BE
            sta STMCUR
            lda L00BF
            sta STMCUR+1
            rts
X_NEXT      lda (STMCUR),Y
            bne LF492
            iny
            lda (STMCUR),Y
LF492       eor #$80
            sta L00C7
LF496       jsr X_POP
            bcs ERR_13
            bne ERR_13
            ldy #$0C
            lda (TOPRSTK),Y
            cmp L00C7
            bne LF496
            ldy #$06
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
            jsr LD_VARF
            jsr T_FADD
            bcs ERR_11B
            jsr LE5C0
            pla
            jsr LF4E5
            bcc LF518
            lda #$11
            jsr LF524
            lda #$08
            jmp POP_RETURN
ERR_11B     jmp ERR_11
LF4E5       sta L00EC
            ldy #$00
            lda (TOPRSTK),Y
            cmp FR0
            bne LF519
            iny
            lda (TOPRSTK),Y
            cmp FR0+1
            bne LF512
            iny
            lda (TOPRSTK),Y
            cmp FR0+2
            bne LF512
            iny
            lda (TOPRSTK),Y
            cmp FR0+3
            bne LF512
            iny
            lda (TOPRSTK),Y
            cmp FR0+4
            bne LF512
            iny
            lda (TOPRSTK),Y
            cmp FR0+5
            beq LF518
LF512       ror
            eor L00EC
            eor FR0
            asl
LF518       rts
LF519       ora FR0
            eor L00EC
            bpl LF518
            ror
            eor #$80
            asl
            rts
LF524       clc
            adc TOPRSTK
            sta TOPRSTK
            sta APPMHI
            bcc LF531
            inc TOPRSTK+1
            inc APPMHI+1
LF531       rts

X_RUN       iny
            cpy NXTSTD
            bcs LF53A
            jsr LC2DE
LF53A       lda L0088
            sta STMCUR
            lda L0089
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
            bmi LF56D
            jsr LF6E7
X_CLR       jsr LF6AF
            jsr LF69E
            lda #$00
            sta L00B7
            sta L00B8
            sta L00B6
            rts

X_END       jsr LF5C4
LF56D       jmp LE66B

X_IF        jsr EXEXPR
            ldx ARSLVL
            lda ARGSTK1,X
            beq IF_FALSE
            ldx STINDEX
            inx
            cpx NXTSTD
            bcs X_ENDIF
            jmp X_GOTO
IF_FALSE    ldy STINDEX
            dey
            lda (STMCUR),Y
            cmp #$1B
            beq IF_SKP_EOL
X_ELSE      lda #$07
            ldx #$41
            ldy #$40
            jmp SKIP_ELSE
IF_SKP_EOL  lda LLNGTH
            sta NXTSTD
X_ENDIF     rts
X_FB        lda (STMCUR),Y
            eor #$26
            sta F_BRK
            rts
F_BRK       .byte $00
LF5A4       lda #$80
            sta BRKKEY
            ldy F_BRK
            beq X_STOP
            jmp ERROR
X_STOP      jsr LF5C4
            jsr PUTEOL
            lda #<STOPPED
            sta L0095
            lda #>STOPPED
            sta L0096
            jsr LF1E2
            jmp LF92E
LF5C4       ldy #$01
            lda (STMCUR),Y
            bmi LF5D1
            sta L00BB
            dey
            lda (STMCUR),Y
            sta L00BA
LF5D1       lda #$00
            sta L00B4
            sta L00B5
            rts
STOPPED     .cb 'STOPPED '

X_CONT      ldy #$01
            lda (STMCUR),Y
            bpl LF5D1
            lda L00BA
            sta L00A0
            lda L00BB
            sta L00A1
            jsr SEARCHLINE
            ldy #$02
            lda (STMCUR),Y
            sta LLNGTH
            pla
            pla
            jmp LFFD7

X_TRAP      jsr LCA3A
            sta L00BC
            sty L00BD
            rts

X_ON        sty L00B3
            jsr LE56B
            jsr T_FPI
            bcs LF62A
            lda FR0+1
            bne LF62A
            lda FR0
            beq LF62A
            sta L00B9
            ldy STINDEX
            dey
            lda (STMCUR),Y
            pha
LF61E       dec L00B9
            beq LF62B
            jsr L3568
            cpx #$12
            beq LF61E
            pla
LF62A       rts
LF62B       pla
            cmp #$62
            beq LF649
            cmp #$6A
            beq LF651
            pha
            jsr GETUINT
            pla
            cmp #$17
            beq LF642
            lda #$1E
            jsr LF423
LF642       lda FR0
            ldy FR0+1
            jmp GTO_LINE
LF649       lda #$51
            jsr LF423
            jmp LF885
LF651       jmp X_GO_S
LF654       sta L00A4
            clc
            lda TOPRSTK
            sta L00C4
            adc L00A4
            tay
            lda TOPRSTK+1
            sta L00C5
            adc #$00
            cmp MEMTOP+1
            bcc LF672
            bne LF67B
            cpy MEMTOP
            bcc LF672
            bne LF67B
LF672       sta TOPRSTK+1
            sta APPMHI+1
            sty TOPRSTK
            sty APPMHI
            rts
LF67B       lda #$02
            jmp ERROR
LF680       lda FR0
            sta (L00C4),Y
            iny
            lda FR0+1
            sta (L00C4),Y
            iny
            lda FR0+2
            sta (L00C4),Y
            iny
            lda FR0+3
            sta (L00C4),Y
            iny
            lda FR0+4
            sta (L00C4),Y
            iny
            lda FR0+5
            sta (L00C4),Y
            rts
LF69E       lda L008C
            sta L008E
            sta TOPRSTK
            sta APPMHI
            lda L008D
            sta L008F
            sta TOPRSTK+1
            sta APPMHI+1
            rts
LF6AF       ldx L0086
            stx L00F5
            ldy L0087
            sty L00F6
LF6B7       ldx L00F5
            cpx L0088
            lda L00F6
            sbc L0089
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
LF6E4       jmp LC9C5
LF6E7       ldy #$00
            sty L00BA
            sty L00BB
            sty L00B9
            sty L00FB
            sty L00B6
            sty L00B7
            sty L00B8
            dey
            sty L00BD
            sty BRKKEY
            jmp LC534

X_FF        lda (STMCUR),Y
            eor #$26
            sta F_FOR
            rts

F_FOR       .byte $00

SKIP_STMT   ldy #$FF
SKIP_ELSE   stx LF72F+1
            sta LF733+1
            sty LF737+1
            lda #$00
            sta FR0+3
            lda STMCUR
            sta L00BE
            lda STMCUR+1
            sta L00BF
LF71F       ldy NXTSTD
            cpy LLNGTH
            bcs LF762
            lda (STMCUR),Y
            sta NXTSTD
            iny
            lda (STMCUR),Y
            iny
            sty STINDEX
LF72F       cmp #$00
            beq LF740
LF733       cmp #$00
            beq LF749
LF737       cmp #$00
            bne LF71F
            lda FR0+3
            bne LF71F
LF73F       rts
LF740       lda FR0+3
            beq LF73F
            dec FR0+3
            jmp LF71F
LF749       cmp #$07
            bne LF756
            ldy NXTSTD
            dey
            lda (STMCUR),Y
            cmp #$1B
            beq LF71F
LF756       inc FR0+3
            bne LF71F
LF75A       jsr LF482
ERR_22      lda #$16
            jmp ERROR
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
            jmp LF71F
X_WHILE     jsr X_DO
            jsr EXEXPR
            ldx ARSLVL
            lda ARGSTK1,X
            bne LF7B8
            jsr X_POP
            lda #$3E
            ldx #$3F
            jmp SKIP_STMT

X_UNTIL     jsr EXEXPR
            jsr X_POP
            bcs ERR_23
            cmp #$3C
            bne ERR_22
            ldx ARSLVL
            ldy ARGSTK1,X
            bne LF7B8
            lda #$04
            jsr LF524
            lda #$3C
            jmp POP_RETURN
LF7B8       rts

X_WEND      jsr X_POP
            bcs ERR_24
            cmp #$3E
            bne ERR_22
            jsr POP_RETURN
            ldy L00B2
            dey
            sty NXTSTD
            rts

ERR_23      lda #$17
            .byte $2C
ERR_24      lda #$18
            jmp ERROR

X_POP       lda L008F
            cmp TOPRSTK+1
            bcc LF7DF
            lda L008E
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
            sta L00A1
            dey
            lda (TOPRSTK),Y
            sta L00A0
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
            cmp #$0C
            beq POP_RETURN
            cmp #$1E
            beq POP_RETURN
            cmp #$50
            bne X_RETURN
            beq ERR_16

POP_RETURN  ldy L00B2
            cmp (L00A0),Y
            bne ERR_15
            lda L00A1
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
            .byte $2C
ERR_16      lda #$10
            .byte $2C
ERR_26      lda #$1A
            jmp ERROR

X_EXIT      jsr X_POP
            bcs ERR_26
            bne LF85B
            lda #$08
LF85B       tax
            inx
            jmp SKIP_STMT

LF860       lda #$1E
            bne POP_RETURN

X_ENDPROC   jsr X_POP
            bcs ERR_28
            cmp #$50
            beq POP_RETURN
            cmp #$51
            beq LF860
            cmp #$1E
            beq ERR_28
            cmp #$0C
            bne X_ENDPROC
LF879       sec
            sbc #$A4
            .byte $2C
ERR_28      lda #$1C
            jmp ERROR
X_EXEC      jsr X_DO
LF885       ldx #$C1
LF887       ldy STINDEX
            lda (STMCUR),Y
            bne LF890
            iny
            lda (STMCUR),Y
LF890       eor #$80
            jsr VAR_PTR
            txa
            cmp (L009D),Y
            bne LF879
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
X_GO_S      ldx #$C2
            bne LF887
ERR_27      lda #$1B
            .byte $2C
ERR_25      lda #$19
            jmp ERROR
X_LOOP      jsr X_POP
            bcs ERR_25
            cmp #$45
            bne ERR_22B
            lda #$04
            jsr LF524
            lda #$45
            jmp POP_RETURN
ERR_22B     jmp ERR_22
ERR_21      lda #$15
            .byte $2C
ERR_19      lda #$13
            .byte $2C
ERR_18      lda #$12
            .byte $2C
X_ERROR     lda #$11
ERROR       sta L00B9
LF8DE       lda #$00
            cld
            sta DSPFLG
            jsr LF5C4
            ldy L00BD
            bmi LF8FC
            lda L00BC
            ldx #$80
            stx L00BD
            ldx L00B9
            stx L00C3
            ldx #$00
            stx L00B9
            jmp GTO_LINE
LF8FC       lda L00B9
            cmp #$80
            bne LF905
            jmp X_STOP
LF905       jsr PUTEOL
            lda #$37
            jsr LF346
            ldx L00B9
            lda #$00
            jsr PUT_AX
            lda L00B9
            cmp #$1F
            bcc LF91C
            sbc #$62
LF91C       sta L00AF
            cmp #$4C
            bcs LF92E
            ldx #$00
            lda #>ERRTAB
            ldy #<ERRTAB
            jsr LF1BB
            jsr LF1FC
LF92E       ldy #$01
            lda (STMCUR),Y
            bmi LF949
            lda #<ERRTAB
            ldy #>ERRTAB
            jsr LF960
            ldy #$01
            lda (STMCUR),Y
            sta FR0+1
            dey
            lda (STMCUR),Y
            sta FR0
            jsr LF956
LF949       jsr PUTEOL
            jsr LFF66
            jmp LE67B
PUT_AX      sta FR0+1
            stx FR0
LF956       jsr T_IFP
LF959       jsr T_FASC
LF95C       lda INBUFF
            ldy INBUFF+1
LF960       sta L0095
            sty L0096
            jmp LF1E2

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
            sta L00D2
            sta L00D3
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
            jsr LFB30
            lda #$60
            jsr LFB30
            lda #$60
            jsr LFB30
            ldy #$06
            lda #$80
            jmp LDA6F
LFB30       pha
            jsr L2DB8
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
            jsr LFB58
            txa
            and #$0F
LFB58       ora #$30
            cmp #$3A
            bcc LFB60
            adc #$06
LFB60       ldy CIX
            sta L0580,Y
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
            jsr LFBC4
            cmp #$18
            bcs LFBBE
            sta FR1
            jsr LFC13
            jsr LFBC4
            cmp #$3C
            bcs LFBBE
            jsr LFBDE
            jsr LFC13
            jsr LFBC4
            cmp #$3C
            bcs LFBBE
            jsr LFBDE
            jsr LFBF2
            jsr LFBEC
            lda FR1
            ldy FR1+1
            ldx FR1+2
LFBB1       sta RTCLOK+2
            sty RTCLOK+1
            stx RTCLOK
            cmp RTCLOK+2
            bne LFBB1
            jmp RSTSEOL
LFBBE       jsr RSTSEOL
            jmp ERR_18
LFBC4       jsr T_GETDIGIT
            inc CIX
            bcs LFBBE
            asl
            sta FR1+3
            asl
            asl
            adc FR1+3
            sta FR1+3
            jsr T_GETDIGIT
            inc CIX
            bcs LFBBE
            adc FR1+3
            rts
LFBDE       clc
            adc FR1
            sta FR1
            bcc LFBEB
            inc FR1+1
            bne LFBEB
            inc FR1+2
LFBEB       rts
LFBEC       asl FR1
            rol FR1+1
            rol FR1+2
LFBF2       ldy FR1+2
            lda FR1
            ldx FR1+1
            asl FR1
            rol FR1+1
            rol FR1+2
            asl FR1
            rol FR1+1
            rol FR1+2
            adc FR1
            sta FR1
            txa
            adc FR1+1
            sta FR1+1
            tya
            adc FR1+2
            sta FR1+2
            rts
LFC13       jsr LFBEC
            ldy FR1+2
            lda FR1
            ldx FR1+1
            asl FR1
            rol FR1+1
            rol FR1+2
            adc FR1
            sta FR1
            txa
            adc FR1+1
            sta FR1+1
            tya
            adc FR1+2
            asl FR1
            rol FR1+1
            rol
            sta FR1+2
            rts
LFC36       rts

X_TEXT      jsr GET2INT
            sta L0099
            bne LFC36
            jsr EXEXPR
            ldx ARSLVL
            lda VARSTK0,X
            bmi LFC4B
            jsr X_STRP
LFC4B       jsr X_POPSTR
LFC4E       lda FR0+2
            ora FR0+3
            beq LFC36
            ldy #$00
            sty L00DB
            sty L00DC
            lda (FR0),Y
            bpl LFC60
            dec L00DB
LFC60       jsr LFCD0
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
            bcs LFC36
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
            and L05C0,X
            bcc LFC93
            ora L05C8,X
LFC93       sta (L00DE),Y
            dec L00DD
            beq LFCA0
            jsr LFF0B
            cpy FR1+1
            bcc LFC87
LFCA0       jsr LFEE0
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
LFCCC       rti
            jsr FKDEF
LFCD0       tay
            asl
            asl
            rol
            rol
            and #$03
            tax
            tya
            eor LFCCC,X
            rts

LFCDD       .byte $18,$18,$0C,$18,$30,$30,$60,$60
            .byte $C0,$C0,$C0,$C0,$18,$0C,$C0,$C0
LFCED       .byte $28,$14,$14,$0A,$0A,$14,$14,$28
            .byte $28,$28,$28,$28,$28,$28,$14,$28
LFCFD       .byte $00,$00,$00,$02,$03,$02,$03,$02
            .byte $03,$01,$01,$01,$00,$00,$03,$02
LFD0D       .byte $00,$01,$03,$07
LFD11       .byte $00,$F0,$FC
LFD14       .byte $FE,$04,$02,$01
LFD18       sec
            rts

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
            lda LFCDD,X
            sta FR1
            cmp L0099
            beq LFD18
            bcc LFD18
            ldy LFCFD,X
            sty FR1+2
            lda LFD11,Y
            sta L05C0
            lda LFCED,X
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
            and LFD0D,Y
            sta L00ED
LFD7F       lsr FR1+4
            ror FR1+3
            dey
            bne LFD7F
LFD86       lda FR1+4
            bne LFD18
            lda FR1+3
            cmp FR1+1
            bcs LFD18
            ldx FR1+2
            bne LFD9E
            lda L00C8
            jsr LFCD0
            sta L05C8
            clc
            rts
LFD9E       ldy LFD0D,X
            sty FR1+4
            lda LFD14,X
            sta L00EE
            lda L00C8
            ora L05C0
            eor L05C0
LFDB0       sta L05C8,Y
            ldx L00EE
LFDB5       asl
            dex
            bne LFDB5
            dey
            bpl LFDB0
            ldy FR1+4
            lda L05C0
LFDC1       sta L05C0,Y
            ldx L00EE
LFDC6       sec
            rol
            dex
            bne LFDC6
            dey
            bpl LFDC1
            clc
LFDCF       rts

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
LFDF2       clc
            lda L00A2
            adc #$03
            sta L00A2
            bcc LFDFD
            inc L00A3
LFDFD       cmp L00E7
            lda L00A3
            sbc L00E8
            bcc LFE08
            jmp LF67B
LFE08       ldx L00ED
            ldy FR1+3
            jsr LFF26
            beq LFE14
            jmp LFEBA
LFE14       jsr LFF1B
LFE17       jsr LFF14
            tya
            bmi LFE28
            jsr LFF26
            bne LFE28
            jsr LFF1B
            jmp LFE17
LFE28       jsr LFF0B
            tya
            ldy #$00
            sta (L00A2),Y
            txa
            asl
            asl
            asl
            iny
            sta (L00A2),Y
            ldy FR1+3
            ldx L00ED
LFE3B       jsr LFF0B
            cpy FR1+1
            bcs LFE4D
            jsr LFF26
            bne LFE4D
            jsr LFF1B
            jmp LFE3B
LFE4D       jsr LFF14
            tya
            ldy #$02
            sta (L00A2),Y
            txa
            dey
            ora (L00A2),Y
            sta (L00A2),Y
            ldy L0099
            iny
            cpy FR1
            bcs LFE85
            jsr LFEDE
            jsr LFEFA
LFE68       ldy #$01
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
            jmp LFDF2
LFE82       jsr LFEEC
LFE85       ldy L0099
            dey
            cpy FR1
            bcs LFEAC
            jsr LFEEC
            jsr LFEFA
LFE92       ldy #$01
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
LFEA9       jsr LFEDE
LFEAC       ldy #$01
            lda (L00A2),Y
            and #$07
            tax
            iny
            lda (L00A2),Y
            tay
            jsr LFF0B
LFEBA       jsr LFF0B
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
            beq LFEEB
LFED6       ldy #$00
            lda (L00A2),Y
            bpl LFE92
            bmi LFE68
LFEDE       inc L0099
LFEE0       clc
            lda L00DE
            adc FR1+1
            sta L00DE
            bcc LFEEB
            inc L00DF
LFEEB       rts
LFEEC       dec L0099
            sec
            lda L00DE
            sbc FR1+1
            sta L00DE
            bcs LFEF9
            dec L00DF
LFEF9       rts
LFEFA       ldy #$00
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
LFF0B       cpx FR1+4
            inx
            bcc LFF13
            ldx #$00
            iny
LFF13       rts
LFF14       dex
            bpl LFF1A
            ldx FR1+4
            dey
LFF1A       rts
LFF1B       lda (L00DE),Y
            and L05C0,X
            ora L05C8,X
            sta (L00DE),Y
            rts
LFF26       lda (L00DE),Y
            ora L05C0,X
            eor L05C0,X
            beq LFF34
            lda L05C8
            rts
LFF34       lda L05C8
            beq LFF3C
            lda #$00
            rts
LFF3C       lda #$01
            rts
X_CLS       jsr CLEAR_XYPOS
            lda DSPFLG
            pha
            stx DSPFLG
            jsr LC49C
            ldy #$7D
            jsr LC29C
            pla
            sta DSPFLG
            jmp LC2A9
X_TRACE     lda (STMCUR),Y
            cmp #$26       ; STOP
            beq LFF66
            lda #$4C       ; JMP DO_TRACE
            ldx #<DO_TRACE
            ldy #>DO_TRACE
            bne LFF6C
LFF66       lda #$A0       ; LDY #02 / LDA (),Y
            ldx #$02
            ldy #$B1
LFF6C       sta LFFAF      ; Patch instruction
            stx LFFAF+1
            sty LFFAF+2
            rts
DO_TRACE    lda #$5B
            jsr PUTCHAR
            ldy #$00
            lda (STMCUR),Y
            tax
            iny
            lda (STMCUR),Y
            jsr PUT_AX
            lda #$5D
            jsr PUTCHAR
            ldy #$02
            lda (STMCUR),Y
            jmp LFFB3
LFF92       jsr LF482
            lda #$0C
            jmp ERROR
X_GOSUB     jsr X_DO
X_GOTO      jsr GETUINT
GTO_LINE    sta L00A0
            sty L00A1
            jsr SEARCHLINE
            bcs LFF92
            pla
            pla
            lda BRKKEY
            beq LFFCD
LFFAF       ldy #$02
            lda (STMCUR),Y
LFFB3       sta LLNGTH
            iny
LFFB6       cpy LLNGTH
            bcs LFFD7
            lda (STMCUR),Y
            sta NXTSTD
            iny
            lda (STMCUR),Y
            iny
            sty STINDEX
            jsr LFFD0
            ldy NXTSTD
            lda BRKKEY
            bne LFFB6
LFFCD       jmp LF5A4
LFFD0       asl
            sta LFFD4+1
LFFD4       jmp (STMT_X_TAB)
LFFD7       ldy #$01
            lda (STMCUR),Y
            bmi LFFEF
            clc
            lda LLNGTH
            adc STMCUR
            sta STMCUR
            bcc LFFE8
            inc STMCUR+1
LFFE8       lda (STMCUR),Y
            bpl LFFAF
            jmp X_END
LFFEF       jmp LE678
;

; vi:syntax=mads
