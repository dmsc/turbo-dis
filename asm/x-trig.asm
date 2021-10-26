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

X_SIN       jsr X_POPVAL
            jsr T_FSIN
            jmp X_PUSH_ERR3

X_COS       jsr X_POPVAL
            jsr T_FCOS
            jmp X_PUSH_ERR3

X_ATN       jsr X_POPVAL
            jsr T_FATN
            jmp X_PUSH_ERR3

X_LOG       jsr X_POPVAL
            jsr T_FLOG
            jmp X_PUSH_ERR3

X_CLOG      jsr X_POPVAL
            jsr T_FCLOG
            jmp X_PUSH_ERR3

X_EXP       jsr X_POPVAL
            jsr T_FEXP
            jmp X_PUSH_ERR3

X_SQR       jsr X_POPVAL
            jsr T_FSQRT
            jmp X_PUSH_ERR3

; vi:syntax=mads
