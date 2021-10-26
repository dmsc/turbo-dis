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

SRCONT      jsr UCASEBUF
            cpy SVONTX  ; Check if we already parsed here
            beq @+      ; Yes, skip
            sty SVONTX
            ldy #>OPNTAB
            lda #<OPNTAB
            jsr OVSEARCH
            bcs SONF
            stx SVONTL
            clc
            lda STENUM
            adc #$10
            sta SVONTC
@           ldy #$00
            lda (CPC),Y
            cmp SVONTC
            beq SONT2
            cmp #CATN
            bne SONTF
            lda SVONTC
            cmp #CDPEEK+1
            bcs SONTF
            cmp #CATN
            bcs SONTS
SONTF       sec
            rts
        ; Store code
SONTS       lda SVONTC
SONT2       jsr SETCODE
            ldx SVONTL
            stx CIX
            clc
            rts
        ; Search operator failed
SONF        lda #$00
            sta SVONTC
            sec
            rts

; vi:syntax=mads
