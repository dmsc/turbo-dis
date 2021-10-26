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

X_FADD      jsr X_POPVAL2
            jsr T_FADD
            jmp X_PUSH_ERR11

X_FSUB      jsr X_POPVAL2
            jsr T_FSUB
            jmp X_PUSH_ERR11

X_FMUL      jsr X_POPVAL2
            jsr T_FMUL
            jmp X_PUSH_ERR11

X_FDIV      jsr X_POPVAL2
            jsr T_FDIV
            jmp X_PUSH_ERR11

X_FNEG  .proc
            ldx ARSLVL
            lda ARGSTK0,X
            beq FNEG_ISZ
            eor #$80
            sta ARGSTK0,X
FNEG_ISZ    rts
        .endp

; vi:syntax=mads
