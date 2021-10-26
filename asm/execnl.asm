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

; Execute new line
; NOTE: you can't change the first two instructions without changing
;       TRACE_ON / TRACE_OFF, because the first 3 bytes are overwritten
;       with a JMP to DO_TRACE.
EXECNL  .proc
            ldy #$02
            lda (STMCUR),Y
; Continue execution after trace
CONT        sta LLNGTH
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
GO_CHK_BRK  jmp CHK_BRK

EXE_STMT    asl
            sta JUMP_STMT+1
JUMP_STMT   jmp (STMT_X_TAB)
        .endp

; Execute next line, or return to parsing if not more lines
NEXT_LINE .proc
            ldy #$01
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
        .endp

; vi:syntax=mads
