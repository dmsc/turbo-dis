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

X_TRACE .proc
            lda (STMCUR),Y
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
            jmp EXECNL.CONT

        .endp

; vi:syntax=mads
