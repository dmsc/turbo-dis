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

; vi:syntax=mads
