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

X_ON    .proc
            sty L00B3
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
            jsr GETPINT
            pla
            cmp #CGTO
            beq LF642
            lda #TOK_ON
            jsr X_GS.GS1
LF642       lda FR0
            ldy FR0+1
            jmp GTO_LINE
LF649       lda #TOK_ENDPROC ; Used to signal "ON * EXEC"
            jsr X_GS.GS1
            jmp X_EXEC.DO_EXEC
LF651       jmp X_GO_S
        .endp

; vi:syntax=mads
