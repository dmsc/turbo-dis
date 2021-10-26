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

; Test if the entire FOR loop must be skipped
FOR_TSTSKIP .proc

            lda TOPRSTK
            pha
            lda TOPRSTK+1
            pha
            lda TEMPA
            sta TOPRSTK
            lda TEMPA+1
            sta TOPRSTK+1
            lda FR0
            pha
            lda L00C7
            jsr GETVAR
            pla
            jsr FOR_CMPLIM
            bcc LF464
            pla
            sta TOPRSTK+1
            pla
            sta TOPRSTK
            bcs X_FOR.PUSH
LF464       pla
            pla
            lda #TOK_FOR
            ldx #TOK_NEXT
            jsr SKIP_STMT
            lda (STMCUR),Y
            bne LF474
            iny
            lda (STMCUR),Y
LF474       eor #$80
            eor L00C7
            beq X_GS.RET
            jmp SKIP_ELSE.SKP_ERR
        .endp

; vi:syntax=mads
