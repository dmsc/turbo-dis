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

        ; Pop CPC from syntax stack, discarding state
POP_SYN     ldx OPSTKX
            bne POP1_SYN
            rts
POP1_SYN    lda SPC,X
            sta CPC
            lda SPC+1,X
            sta CPC+1
            dex
            dex
            dex
            dex
            stx OPSTKX
            bcs FAIL
            jmp NEXT


; vi:syntax=mads
