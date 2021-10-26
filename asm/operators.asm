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

; vi:syntax=mads
