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

; Search string #($AF) in table at AY, skipping the first X bytes on each string.
; Returns string address at SCRADR
STR_TABN .proc
            stx SRCSKP          ; LSCAN in BASIC sources
            sta SCRADR+1
            sty SCRADR
LSC0        ldy SRCSKP
            lda STENUM
            beq LSINC
            dec STENUM
LSC1        lda (SCRADR),Y
            bmi LSC2
            iny
            bne LSC1
LSC2        iny
            jsr LSINC
            jmp LSC0
LSINC       clc
            tya
            adc SCRADR
            sta SCRADR
            bcc @+
            inc SCRADR+1
@           rts
        .endp

; vi:syntax=mads
