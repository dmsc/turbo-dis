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

            ; Print decimal numbers:
            ;
            ; Print number in AX
PUT_AX      sta FR0+1
            stx FR0
            ; Print integer in FR0, PRINUM in Atari BASIC
PRINUM      jsr T_IFP
            ; Print floating-point number
PUT_FP      jsr T_FASC
            ; Print string in INBUFF
PUT_INBUF   lda INBUFF
            ldy INBUFF+1
            ; Print string in AY
P_STRB_AY   sta SCRADR
            sty SCRADR+1
            jmp LPRTOKEN

; vi:syntax=mads
