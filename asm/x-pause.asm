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

X_PAUSE .proc
            jsr GETINT
LDCA5       lda RTCLOK+2
LDCA7       ldy BRKKEY
            beq LDCBC
            cmp RTCLOK+2
            beq LDCA7
            lda FR0
            bne LDCB7
            dec FR0+1
            bmi LDCBC
LDCB7       dec FR0
            jmp LDCA5
LDCBC       rts
        .endp

; vi:syntax=mads
