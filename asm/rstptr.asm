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

RSTPTR  .proc
            lda STARP
            sta RUNSTK
            sta TOPRSTK
            sta APPMHI
            lda STARP+1
            sta RUNSTK+1
            sta TOPRSTK+1
            sta APPMHI+1
            rts
        .endp

; vi:syntax=mads
