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

        ; Set EOL at end of string, to pass to CIO
SETSEOL     jsr X_POPSTR
            lda FR0
            sta INBUFF
            lda FR0+1
            sta INBUFF+1
            ldy FR0+2
            ldx FR0+3
            beq SETSEOL1
            ldy #$FF
SETSEOL1    lda (INBUFF),Y
            sta INDEX2
            sty INDEX2+1
            lda #CR
            sta (INBUFF),Y
            sta MEOLFLG
            rts

        ; Restore original end of string
RSTSEOL     ldy INDEX2+1
            lda INDEX2
            sta (INBUFF),Y
            lda #$00
            sta MEOLFLG
            jmp T_LDBUFA

; vi:syntax=mads
