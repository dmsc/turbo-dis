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

; Gets a LABEL or line number
GT_LBLNUM .proc
            lda (STMCUR),Y
            iny
            cpy NXTSTD
            bcs LNZERO
            cmp #CPND
            bne GETINT_
            inc STINDEX
            jsr GETTOK
            lda VTYPE
            cmp #EVLABEL + EVL_GOS
            bne ERR_30
            ldy #$00
            lda (FR0),Y
            tax
            iny
            lda (FR0),Y
            tay
            txa
            rts

LNZERO      lda #$00
            tay
            rts

GETINT_     jmp GETINT
        .endp

; vi:syntax=mads
