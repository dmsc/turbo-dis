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

; Save current position to return-stack
X_DO = X_GS
X_REPEAT = X_GS

X_GS    .proc
            lsr
            ldy STINDEX
            sty L00B3
GS1         pha
            lda #$04    ; Expand by 4 bytes
            jsr REXPAND
            pla
            ldy #$00
            sta (TEMPA),Y
            lda STMCUR
            iny
            sta (TEMPA),Y
            lda STMCUR+1
            iny
            sta (TEMPA),Y
            ldx L00B3
            dex
            txa
            iny
            sta (TEMPA),Y
RET         rts
        .endp

; vi:syntax=mads
