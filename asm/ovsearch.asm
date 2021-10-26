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

            ; Search operand or variable name
OVSEARCH .proc
            sty SCRADR+1
            ldx #$00
            stx STENUM
LDF8B       sta SCRADR
            ldx CIX
            ldy #$00
            lda (SCRADR),Y
            beq SRCNF   ; Not found
LDF95       lda LBUFF,X
            and #$7F
            inx
            eor (SCRADR),Y
            bne LDFA2
            iny
            bne LDF95
LDFA2       asl
            beq SRCFND  ; Found
            bcs LDFAD
LDFA7       iny
            lda (SCRADR),Y
            bpl LDFA7
SRCNXT      sec
LDFAD       inc STENUM
            beq ERR_04
            tya
            adc SCRADR
            bcc LDF8B
            inc SCRADR+1
            bcs LDF8B
        .endp

SRCFND      clc ; Found
            rts
SRCNF       sec ; Not found
            rts
ERR_04      lda #$04
            jmp SERROR

; vi:syntax=mads
