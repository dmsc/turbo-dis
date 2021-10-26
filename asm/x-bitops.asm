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

POP2INT     jsr X_POPINT
            sta FR1
            sty FR1+1
            jmp X_POPINT

X_BITAND    jsr POP2INT
            tya
            and FR1+1
            tay
            lda FR1
            and FR0
            jmp X_RET_AY

X_BITOR     jsr POP2INT
            tya
            ora FR1+1
            tay
            lda FR1
            ora FR0
            jmp X_RET_AY

X_EXOR      jsr POP2INT
            tya
            eor FR1+1
            tay
            lda FR1
            eor FR0
            jmp X_RET_AY

; vi:syntax=mads
