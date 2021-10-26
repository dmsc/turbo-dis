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

        ; Push state into syntax stack
PUSH    .proc
            ldx OPSTKX
            inx
            inx
            inx
            inx
            beq ERR_14B
            stx OPSTKX
            lda CIX
            sta SIX,X
            lda COX
            sta SOX,X
            lda CPC
            sta SPC,X
            lda CPC+1
            sta SPC+1,X
            pla
            sta CPC
            pla
            sta CPC+1
            jmp NEXT
ERR_14B     jmp ERR_14
        .endp

; vi:syntax=mads
