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

; Calls PUTCHAR from IO channel X
PDUM_ROM .proc
            inc PORTB   ; 10
            jsr PDUM
            dec PORTB
            rts

; Calls PUTCHAR from IO channel X
PDUM        lda IOCB0+ICPTH,X   ; 12
            pha
            lda IOCB0+ICPTL,X
            pha
            tya
            ldy #$5C
            rts
        .endp

; vi:syntax=mads
