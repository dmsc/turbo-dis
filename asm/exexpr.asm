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

X_LET   = EXEXPR

EXOPOP   = EXEXPR.EXOPOP
EGT_NUM  = GETTOK.EGT_NUM
EGT_STRC = GETTOK.EGT_STRC
GETVAR   = GETTOK.GETVAR
RISC     = GETTOK.RISC


        ; Execute Expression, pushing the result to the operand stack

EXEXPR  .proc
            ldy #$00
            lda #$11
            sta OPSTK
            sty OPSTKX
            sty COMCNT
            sty ARSLVL
            sty L00B1
EXNXT       jsr GETTOK
            bcs EXOPER
            jsr X_PUSHVAL
            jmp EXNXT
EXOPER      sta EXSVOP
            tax
            lda OPRTAB-16,X
            sta EXSVPR
EXPTST      ldy OPSTKX
            ldx OPSTK,Y
            lda OPLTAB-16,X
            cmp EXSVPR
            bcc EOPUSH
            tax
            beq EXEND
EXOPOP      lda OPSTK,Y
            dec OPSTKX
            jsr EXOP
            jmp EXPTST
EOPUSH      lda EXSVOP
            iny
            sta OPSTK,Y
            sty OPSTKX
            jmp EXNXT
EXEND       rts
EXOP        asl
            sta EXJUMP+1
EXJUMP      jmp (OPETAB-11)

        .endp


GETTOK  .proc
            ldy STINDEX
            inc STINDEX
            lda (STMCUR),Y
            bmi EGTVAR
            beq EGTVARH
            cmp #$0F
            bcc EGT_NUM
            beq EGT_STRC
            rts

EGT_NUM     iny ; :EGNC In Atari Basic
            lda (STMCUR),Y
            sta FR0
            iny
            lda (STMCUR),Y
            sta FR0+1
            iny
            lda (STMCUR),Y
            sta FR0+2
            iny
            lda (STMCUR),Y
            sta FR0+3
            iny
            lda (STMCUR),Y
            sta FR0+4
            iny
            lda (STMCUR),Y
            sta FR0+5
            iny
            sty STINDEX
            lda #$00
            sta VTYPE
            rts

EGT_STRC    iny         ; EGSC in Atari Basic
            lda (STMCUR),Y
            ldx #STMCUR
RISC        sta FR0+2
            sta FR0+4
            iny
            tya
            clc
            adc $00,X
            sta FR0
            lda #$00
            sta FR0+3
            sta FR0+5
            adc $01,X
            sta FR0+1
            tya
            adc FR0+2
            tay
            lda #EVSTR + EVSDTA + EVDIM
            sta VTYPE
            sty STINDEX
            clc
            rts

EGTVARH     iny
            inc STINDEX
            lda (STMCUR),Y
EGTVAR      eor #$80

GETVAR      sta VNUM
            jsr VAR_PTR
            lda (WVVTPT),Y
            sta VTYPE
            ldy #$02
            lda (WVVTPT),Y
            sta FR0
            iny
            lda (WVVTPT),Y
            sta FR0+1
            iny
            lda (WVVTPT),Y
            sta FR0+2
            iny
            lda (WVVTPT),Y
            sta FR0+3
            iny
            lda (WVVTPT),Y
            sta FR0+4
            iny
            lda (WVVTPT),Y
            sta FR0+5
            rts

        .endp

; vi:syntax=mads
