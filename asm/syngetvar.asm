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

            ; Check label variable name
LLVARN      lda #$C0
            bne GETVARN

            ; Check numeric variable name
LNVARN      lda #$00            ; TNVAR in BASIC source
            beq GETVARN

            ; Check string variable name
LSTVARN     lda #EVSTR          ; TSVAR in BASIC source
GETVARN .proc
            sta VTYPE           ; TVAR  in BASIC source
            jsr UCASEBUF
            sty TVSCIX
            jsr CHK_NAMECHR
            bcs TVFAIL
            jsr SRCONT
            lda SVONTC
            beq TV1
            ldy SVONTL
            lda (INBUFF),Y
            cmp #'0'
            bcc TVFAIL
TV1         inc CIX
            jsr CHK_NAMECHR
            bcc TV1
            cmp #'0'
            bcc @+
            cmp #'9'+1
            bcc TV1
@           cmp #'$'
            beq TVSTR
            bit VTYPE
            bpl TVOK
            bvs TVOK2
TVFAIL      sec
            rts
TVSTR       bit VTYPE
            bpl TVFAIL
            bvs TVFAIL
            iny
            bne TVOK2
TVOK        lda (INBUFF),Y
            cmp #'('
            bne TVOK2
            iny
            lda #EVARRAY
            ora VTYPE
            sta VTYPE
TVOK2       lda TVSCIX
            sta CIX
            sty TVSCIX
            ldy VNTP+1
            lda VNTP
            jsr OVSEARCH
TVRS        bcs TVS0
            cpx TVSCIX
            beq TVSUC
LE9D8       jsr OVSEARCH.SRCNXT
            jmp TVRS
TVS0        sec                 ; New variable, store
            lda TVSCIX
            sbc CIX
            sta CIX
            tay
            ldx #VNTD
            jsr EXPLOW
            lda STENUM
            sta VNUM
            ldy CIX
            dey
            ldx TVSCIX
            dex
            lda LBUFF,X
            ora #$80
TVS1        sta (INDEX2),Y
            dex
            lda LBUFF,X
            dey
            bpl TVS1
            ldy #$08    ; Expand VVT by 8 bytes
            ldx #STMTAB
            jsr EXPLOW
            inc ADFLAG
            jsr T_ZFR0
            ldy #$07
TVS2        lda VTYPE,Y
            sta (INDEX2),Y
            dey
            bpl TVS2
TVSUC       tya                 ; Test Variable Syntax U C
            pha
            lda CPC             ; Save CPC, it is the same as WVVTPT
            pha
            ldx CPC+1
            lda STENUM
            jsr VAR_PTR
            lda (WVVTPT),Y
            eor VTYPE
            tay
            stx CPC+1           ; Restore CPC
            pla
            sta CPC
            cpy #$80
            pla
            tay
            bcs LE9D8
            bit VTYPE
            bvc TVNP
            bmi TVNP
            dec TVSCIX
TVNP        lda TVSCIX          ; Test Variable No Paren
            sta CIX
            lda STENUM
            bpl @+              ; Variable > 127
            lda #$00
            jsr SETCODE
            lda STENUM
@           eor #$80
            jsr SETCODE
ROK         clc
            rts
        .endp


CHK_NAMECHR ldy CIX
            lda (INBUFF),Y
IS_NAMECHR  cmp #'_'
            beq GETVARN.ROK
            cmp #'A'
            bcc CHKFAIL
            cmp #'Z'+1
            rts

; vi:syntax=mads
