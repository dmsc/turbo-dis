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

X_TIME  .proc
            lda RTCLOK+2
            ldy RTCLOK+1
            ldx RTCLOK
            cmp RTCLOK+2
            bne X_TIME
            pha
            stx FR0+1
            sty FR0
            jsr T_IFP
            ldx #$05
@           lda FP_256,X
            sta FR1,X
            dex
            bpl @-
            jsr T_FMUL
            jsr T_FMOVE
            pla
            sta FR0
            lda #$00
            sta FR0+1
            jsr T_IFP
            jsr T_FADD
            lda #$00
            sta VTYPE
            sta VNUM
            jmp X_PUSHVAL
        .endp

; vi:syntax=mads
