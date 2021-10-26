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

        ; Move 6 bytes to runtime stack
MV6RS   .proc
            lda FR0
            sta (TEMPA),Y
            iny
            lda FR0+1
            sta (TEMPA),Y
            iny
            lda FR0+2
            sta (TEMPA),Y
            iny
            lda FR0+3
            sta (TEMPA),Y
            iny
            lda FR0+4
            sta (TEMPA),Y
            iny
            lda FR0+5
            sta (TEMPA),Y
            rts
        .endp

; vi:syntax=mads
