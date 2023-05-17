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

SYNERR      ldy TVSCIX
            sty CIX
CHKFAIL     sec
            rts

GET_HEXDIG .proc
            ldy CIX
            lda (INBUFF),Y
.if .def tb_fixes
            eor #'0'            ; Use EOR, does not need the SEC
            cmp #10
            bcc HEXDIGOK
            ora #$20            ; Allow lower-case characters in "DEC" function.
            sbc #'A'^'0'        ; Bring A..F to 0..6
            cmp #6
            bcs CHKFAIL
            adc #10
.else
            sec
            sbc #'0'
            bcc CHKFAIL ; Not really needed.
            cmp #10
            bcc HEXDIGOK
            cmp #'A'-'0'
            bcc CHKFAIL
            sbc #'A'-'0' - 10
            cmp #$10
            bcs CHKFAIL
.endif
HEXDIGOK
            ldy #$04
@           asl FR0
            rol FR0+1
            dey
            bne @-
            ora FR0
            sta FR0
            inc CIX
            clc
            rts
        .endp

            ; Read a numeric constant
LTNCON  .proc
            jsr UCASEBUF
            sty TVSCIX
            lda (INBUFF),Y
            cmp #'$'
            beq @+
            jsr T_AFP
            bcc FOK
            bcs SYNERR

@           inc CIX
            jsr UCASEBUF
            jsr T_ZFR0
            jsr GET_HEXDIG
            bcs SYNERR
@           jsr GET_HEXDIG
            bcs NOHEXD
            lda FR0+1
            and #$F0
            beq @-
NOHEXD      jsr T_IFP
            lda #$0D
            .byte $2C   ; Skip 2 bytes
FOK         lda #$0E
            jsr SETCODE
            ldy COX
            ldx #$00
@           lda FR0,X
            sta OUTBUFF,Y
            iny
            inx
            cpx #$06
            bcc @-
            sty COX
            clc
            rts
        .endp

; vi:syntax=mads
