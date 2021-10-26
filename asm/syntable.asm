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

; vi:syntax=mads
