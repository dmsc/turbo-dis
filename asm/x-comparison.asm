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

X_LTE       jsr X_CMP
            bcc X_N1
            beq X_N1
            bcs X_N0

X_NEQU      jsr X_CMP
            beq X_N0
            bne X_N1

X_LT        jsr X_CMP
            bcc X_N1
            bcs X_N0

X_GT        jsr X_CMP
            bcc X_N0
            beq X_N0
            bcs X_N1

X_GTE       jsr X_CMP
            bcc X_N0
            bcs X_N1

X_EQU       jsr X_CMP
            beq X_N1
            bne X_N0

; vi:syntax=mads
