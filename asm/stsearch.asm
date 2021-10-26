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

            ; Search statement table
STSEARCH .proc
            ldx #$00
            stx STENUM
            sty SCRADR+1
LDFC9       sta SCRADR
            ldx CIX
            ldy #$01
            lda (SCRADR),Y
            beq SRCNF
LDFD3       lda LBUFF,X
            and #$7F
            inx
            cmp #$2E
            beq SRCFND  ; Found
            eor (SCRADR),Y
            bne LDFE4
            iny
            bne LDFD3
LDFE4       asl
            beq SRCFND  ; Found
            bcs LDFEE
LDFE9       iny
            lda (SCRADR),Y
            bpl LDFE9
LDFEE       inc STENUM
            sec
            tya
            adc SCRADR
            bcc LDFC9
            inc SCRADR+1
            bcs LDFC9
        .endp

; vi:syntax=mads
