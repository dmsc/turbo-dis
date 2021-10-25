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

; Non executable statements, all point here
X_REM    = CIOV_RTS
X_DATA   = CIOV_RTS
X_LREM   = CIOV_RTS
X_LABEL  = CIOV_RTS
X_LPAREN = CIOV_RTS
X_UPLUS  = CIOV_RTS
X_ONEXEC = CIOV_RTS
X_ONGOS  = CIOV_RTS

; vi:syntax=mads
