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

X_IF    .proc
            jsr EXEXPR
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

.def :X_ELSE
            lda #TOK_IF
            ldx #TOK_ENDIF
            ldy #TOK_ELSE
            jmp SKIP_ELSE
IF_SKP_EOL  lda LLNGTH
            sta NXTSTD

.def :X_ENDIF
            rts
        .endp

; vi:syntax=mads
