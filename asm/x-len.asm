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

X_LEN       jsr X_POPSTR
            lda FR0+2
            ldy FR0+3
X_RET_AY    sta FR0
            sty FR0+1
X_RET_INT   jsr T_IFP
X_RET_FP    lda #$00
            sta VTYPE
            sta VNUM
            jmp X_PUSHVAL

; vi:syntax=mads
