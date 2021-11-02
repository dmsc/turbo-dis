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

.if .def tb_lowmem

LOAD_END
; Patch TIME between PAL and NTSC
        icl "asm/time-ntsc.asm"
; Relocation support:
        icl "asm/relocate.asm"
.endif

LOAD_BUFFER = *

            ini INIT


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Start of code under ROM, at OS addresses
;
            org $C000
TB_SEGMENT_5

            icl "asm/x-del.asm"
            icl "asm/x-dump.asm"

            icl "asm/fix-rstk.asm"

            icl "asm/x-setcolor.asm"
            icl "asm/x-dsound.asm"
            icl "asm/x-position.asm"

            icl "asm/x-color.asm"
            icl "asm/x-fcolor.asm"

            icl "asm/x-drawto.asm"
            icl "asm/x-graphics.asm"
            icl "asm/x-plot.asm"

            icl "asm/getline.asm"
            icl "asm/putchar.asm"
            icl "asm/gloadciox.asm"

            icl "asm/x-enter.asm"
            icl "asm/flist.asm"
            icl "asm/altopen.asm"

            icl "asm/x-load.asm"
            icl "asm/x-save.asm"
            icl "asm/x-cload.asm"
            icl "asm/cio-open.asm"
            icl "asm/x-xio.asm"
            icl "asm/x-status.asm"
            icl "asm/x-note.asm"
            icl "asm/x-point.asm"

            icl "asm/x-put.asm"
            icl "asm/x-get.asm"

            icl "asm/x-locate.asm"

            icl "asm/giochan.asm"
            icl "asm/ciotest.asm"
            icl "asm/ciocall.asm"
            icl "asm/iosetvar.asm"
            icl "asm/x-close.asm"

            icl "asm/ready.asm"

            icl "asm/setseol.asm"
            icl "asm/x-dir.asm"
            icl "asm/x-fileops.asm"
            icl "asm/x-bputget.asm"
            icl "asm/cio-getchar.asm"
            icl "asm/x-getkey.asm"

            ; %PUT, %GET
            icl "asm/x-pputget.asm"
            icl "asm/x-fpassign.asm"

            ; Array parenthesis and comma
            icl "asm/x-arrparen.asm"
            ; String parenthesis and comma
            icl "asm/x-strparen.asm"
            icl "asm/x-strassign.asm"
            icl "asm/x-dim.asm"

            icl "asm/searchln.asm"

            icl "asm/hashlnum.asm"
            icl "asm/getlabel.asm"

            icl "asm/x-restore.asm"
            icl "asm/x-read.asm"
            icl "asm/x-input.asm"


        @SEGMENT_SIZE TB_SEGMENT_5 $CC00
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Second part, after international character set
;
            org $D800
TB_SEGMENT_6

            icl "asm/x-move.asm"
            icl "asm/x-fpop.asm"
            icl "asm/x-comparison.asm"
            icl "asm/x-logical.asm"

            ; Constants (%0 to %3) and SGN()
            icl "asm/x-constant.asm"

            ; Comparisons
            icl "asm/x-fpcomp.asm"
            icl "asm/x-strcmp.asm"

            ; Misc functions
            icl "asm/x-len.asm"
            icl "asm/x-peek.asm"
            icl "asm/x-fre.asm"
            icl "asm/x-val.asm"
            icl "asm/x-asc.asm"
            icl "asm/x-dec.asm"
            icl "asm/x-adr.asm"

            ; PADDLE / STICK / PTRIG / STRIG
            icl "asm/x-sticks.asm"

            icl "asm/x-hexstr.asm"
            icl "asm/x-str.asm"

            icl "asm/x-inkey.asm"
            icl "asm/x-chr.asm"

            ; RND, RND() and RAND()
            icl "asm/x-random.asm"

            icl "asm/x-abs.asm"
            icl "asm/x-frac.asm"
            icl "asm/x-int.asm"

            ; Trig and exp functions
            icl "asm/x-trig.asm"
            icl "asm/x-pow.asm"
            icl "asm/x-degrad.asm"

            icl "asm/x-bitops.asm"
            icl "asm/inkey-tab.asm"
            icl "asm/x-pause.asm"
            icl "asm/x-mod.asm"
            icl "asm/x-errl.asm"
            icl "asm/x-print.asm"
            icl "asm/x-lprint.asm"
            icl "asm/x-instr.asm"
            icl "asm/x-circle.asm"

            ; Operand, variable and statement searching, used in parser.
            icl "asm/ovsearch.asm"
            icl "asm/stsearch.asm"

        @SEGMENT_SIZE TB_SEGMENT_6 $E000
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Third part, after character map
;
            org $E400
TB_SEGMENT_7

            icl "asm/exexpr.asm"

            icl "asm/getstr.asm"
            icl "asm/getint.asm"
            icl "asm/pushval.asm"
            icl "asm/popval.asm"
            icl "asm/rtnvar.asm"
            icl "asm/initmem.asm"
            icl "asm/syntax.asm"
            icl "asm/getlnum.asm"
            icl "asm/synent.asm"
            icl "asm/synpush.asm"
            icl "asm/synpop.asm"
            icl "asm/synfail.asm"
            icl "asm/synsetcode.asm"

            icl "asm/s-eif.asm"
            icl "asm/s-erem.asm"

            icl "asm/synsrcont.asm"
            icl "asm/syngetvar.asm"

            icl "asm/s-numconst.asm"
            icl "asm/s-stconst.asm"
            icl "asm/s-label.asm"
            icl "asm/ucasebuf.asm"

            ; Statement and operators tables
            icl "asm/statements.asm"
            icl "asm/operators.asm"
            ; Syntax tables
            icl "asm/syntable.asm"
            icl "asm/s-oper.asm"

            icl "asm/x-list.asm"
            icl "asm/popreturn.asm"

            icl "asm/scantab.asm"
            icl "asm/prtstr.asm"
            icl "asm/prtline.asm"
            icl "asm/prtvar.asm"

            icl "asm/x-for1.asm"
            icl "asm/x-gsdo.asm"  ; DO, REPEAT and "GS": save position before GOSUB
            icl "asm/x-for2.asm"
            icl "asm/x-next.asm"
            icl "asm/x-for3.asm"

            icl "asm/rcont.asm"
            icl "asm/x-run.asm"

            ; CLR and END
            icl "asm/x-clr.asm"
            ; IF/THEN, IF/ELSE/ENDIF
            icl "asm/x-ifthen.asm"

            ; "*B" and break key checking
            icl "asm/x-break.asm"

            icl "asm/x-stop.asm"
            icl "asm/x-cont.asm"
            icl "asm/x-trap.asm"
            icl "asm/x-on.asm"

            icl "asm/rexpand.asm"
            icl "asm/mv6rs.asm"
            icl "asm/rstptr.asm"
            icl "asm/zvar.asm"
            icl "asm/runinit.asm"

            icl "asm/x-ff.asm"
            icl "asm/skipstmt.asm"
            icl "asm/x-while.asm"
            icl "asm/x-until.asm"
            icl "asm/x-wend.asm"
            icl "asm/x-pop.asm"
            icl "asm/x-return.asm"
            icl "asm/x-exit.asm"
            icl "asm/x-endproc.asm"
            icl "asm/x-exec.asm"
            icl "asm/x-loop.asm"

            ; TRAP and break on errors
            icl "asm/errors.asm"

            icl "asm/prtnum.asm"

            ; Table of error names
            icl "asm/errortab.asm"

            ; TIME, TIME$ and TIME$= statements
            icl "asm/x-time.asm"
            icl "asm/x-timestr.asm"
            icl "asm/x-timeset.asm"

            ; TEXT statement
            icl "asm/x-text.asm"

            ; Fast plot support
            icl "asm/fastplot.asm"

            ; PAINT (flood fill)
            icl "asm/x-paint.asm"

            ; Execution control statements
            icl "asm/x-cls.asm"
            icl "asm/x-trace.asm"
            icl "asm/x-gosub.asm"

            ; Main execution loop
            icl "asm/execnl.asm"
;
        @SEGMENT_SIZE TB_SEGMENT_7 $FFFA

; vi:syntax=mads
