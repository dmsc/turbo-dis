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

ERR_13      lda #$0D
            jmp SERROR

            ; Restore line number
RESCUR      lda SAVCUR
            sta STMCUR
            lda SAVCUR+1
            sta STMCUR+1
            rts

X_NEXT  .proc
            lda (STMCUR),Y
            bne @+
            iny
            lda (STMCUR),Y
@           eor #$80
            sta L00C7
XNEXTVAR    jsr X_POP
            bcs ERR_13
            bne ERR_13
            ldy #$0C
            lda (TOPRSTK),Y
            cmp L00C7           ; Test if NEXT var#
            bne XNEXTVAR
            ldy #$06            ; FSTEP in basic sources, get STEP into FR1
            lda (TOPRSTK),Y
            pha
            sta FR1
            iny
            lda (TOPRSTK),Y
            sta FR1+1
            iny
            lda (TOPRSTK),Y
            sta FR1+2
            iny
            lda (TOPRSTK),Y
            sta FR1+3
            iny
            lda (TOPRSTK),Y
            sta FR1+4
            iny
            lda (TOPRSTK),Y
            sta FR1+5
            lda L00C7
            jsr GETVAR
            jsr T_FADD
            bcs ERR_11B
            jsr RTNVAR
            pla
            jsr FOR_CMPLIM
            bcc FOR_CMPLIM.RTS_18
            lda #$11
            jsr RCONT
            lda #TOK_FOR
            jmp RETURN

ERR_11B     jmp ERR_11
        .endp

; vi:syntax=mads
