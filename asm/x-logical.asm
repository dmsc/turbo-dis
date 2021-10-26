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

X_AND       dec ARSLVL
            ldx ARSLVL
            dec ARSLVL
            lda ARGSTK0,X
            and ARGSTK0+1,X
            asl
            beq X_N0
            bne X_N1

X_OR        dec ARSLVL
            ldx ARSLVL
            dec ARSLVL
            lda ARGSTK0,X
            ora ARGSTK0+1,X
            asl
            beq X_N0
            bne X_N1

X_NOT       ldx ARSLVL
            dec ARSLVL
            lda ARGSTK0,X
            beq X_N1

; vi:syntax=mads
