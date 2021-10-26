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

            ; EXEC and GO# statements
X_EXEC  .proc
            jsr X_GS
DO_EXEC     ldx #EVLABEL + EVL_EXEC
GO_LABEL    ldy STINDEX
            lda (STMCUR),Y
            bne LF890
            iny
            lda (STMCUR),Y
LF890       eor #$80
            jsr VAR_PTR
            txa
            cmp (WVVTPT),Y
            bne ERR_LABEL
            ldy #$03
            lda (WVVTPT),Y
            sta STMCUR+1
            dey
            lda (WVVTPT),Y
            sta STMCUR
            lda (STMCUR),Y
            sta LLNGTH
            iny
            lda (STMCUR),Y
            sta NXTSTD
            rts
        .endp

X_GO_S  .proc
            ldx #EVLABEL + EVL_GOS
            bne X_EXEC.GO_LABEL ; Jump always
        .endp

; vi:syntax=mads
