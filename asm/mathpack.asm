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

FP_ZERO     clc
            jmp T_ZFR0

RET_CLC     clc
            rts

RET_SEC     sec
            rts

T_FSQ       jsr T_FMOVE

T_FMUL      lda FR0
            beq RET_CLC
            lda FR1
            beq FP_ZERO
            eor FR0
            and #$80
            sta L00EE
            lda FR1
            and #$7F
            sta FR1
            lda FR0
            and #$7F
            sec
            sbc #$40
            sec
            adc FR1
            bmi RET_SEC
            ora L00EE
            tay
            jsr EXPAND_POW2
            sta FR0+6
            sta FR0+7
            sta FR0+8
            sta FR0+9
            sta FR0+10
            sta FR0+11
            sty FR0

            ; Macro to multiply by a pair of digits
.macro @MUL_PAIR digit
            ldy #$07
loop        lsr FR1+:digit
            bcc skip_add
            clc
            lda FR0+5+:digit
            adc FPTMP5,Y
            sta FR0+5+:digit
            lda FR0+4+:digit
            adc FPTMP4,Y
            sta FR0+4+:digit
            lda FR0+3+:digit
            adc FPTMP3,Y
            sta FR0+3+:digit
            lda FR0+2+:digit
            adc FPTMP2,Y
            sta FR0+2+:digit
            lda FR0+1+:digit
            adc FPTMP1,Y
            sta FR0+1+:digit
            lda FR0+:digit
            adc FPTMP0,Y
            sta FR0+:digit
            dey
            bpl loop
            bmi end_loop

skip_add    beq end_loop
            dey
            bpl loop
end_loop
.endm

            ; Expands the macro five times (10 digits)
            @MUL_PAIR 5
            @MUL_PAIR 4
            @MUL_PAIR 3
            @MUL_PAIR 2
            @MUL_PAIR 1

L27F9       jmp NORMDIVMUL
L27FC       clc
            rts
L27FE       sec
            rts

T_FDIV      lda FR1
            beq L27FE
            lda FR0
            beq L27FC
            eor FR1
            and #$80
            sta L00EE
            lda FR1
            and #$7F
            sta FR1
            lda FR0
            and #$7F
            sec
            sbc FR1
            clc
            adc #$40
            bmi L27FE
            ora L00EE
            tay
            jsr EXPAND_POW2
            sta FR1+6
            sta FR1+7
            sta FR1+8
            sta FR1+9
            sta FR1+10
            sta FR1
            sta FR0+6
            sty FR0

            ; Performs division of two digits
.macro @DIV_PAIR digit
            ldy #$00
div_loop    lda FR1+:digit
            cmp FPTMP0,Y
            bne div_neq
            lda FR1+1+:digit
            cmp FPTMP1,Y
            bne div_neq
            lda FR1+2+:digit
            cmp FPTMP2,Y
            bne div_neq
            lda FR1+3+:digit
            cmp FPTMP3,Y
            bne div_neq
            lda FR1+4+:digit
            cmp FPTMP4,Y
            bne div_neq
            lda FR1+5+:digit
            cmp FPTMP5,Y
            bne div_neq
            ldx #:digit
            jmp FDIVSKP0
div_neq     bcc skip_sub
            lda FR1+5+:digit
            sbc FPTMP5,Y
            sta FR1+5+:digit
            lda FR1+4+:digit
            sbc FPTMP4,Y
            sta FR1+4+:digit
            lda FR1+3+:digit
            sbc FPTMP3,Y
            sta FR1+3+:digit
            lda FR1+2+:digit
            sbc FPTMP2,Y
            sta FR1+2+:digit
            lda FR1+1+:digit
            sbc FPTMP1,Y
            sta FR1+1+:digit
            lda FR1+:digit
            sbc FPTMP0,Y
            sta FR1+:digit
skip_sub    rol FR0+1+:digit
            iny
            cpy #$08
            bne div_loop
.endm
            ; Call the division for all digits
            @DIV_PAIR 0
            @DIV_PAIR 1
            @DIV_PAIR 2
            @DIV_PAIR 3
            @DIV_PAIR 4

            lda FR0+1
            bne FDIVEND

            @DIV_PAIR 5

FDIVEND     jmp NORMDIVMUL

FDIVSKP0    rol FR0+1,X ; Skip if remainder is 0 at end of FDIV
            iny
            cpy #$08
            bne FDIVSKP0
            beq FDIVEND

EXPAND_POW2 sed
            ; First part: FPTMP*+7 = FR1
            ;             FMTMP*+6 = FR1 * 2
            clc
    .rept 5, 5-#
            lda FR1+:1
            sta FPTMP:1+7
            adc FR1+:1
            sta FPTMP:1+6
    .endr
            lda #$00
            sta FPTMP0+7
            adc #$00
            sta FPTMP0+6
            ; Second part: FPTMP*+5 = FR1 * 4
            ;              FPTMP*+4 = FR1 * 8
            ldx #$02
@   .rept 6, 5-#
            lda FPTMP:1+4,X
            adc FPTMP:1+4,X
            sta FPTMP:1+3,X
    .endr
            dex
            bne @-
            ; Third part: FPTMP*+3 = FR1 * 8 + FR1 * 2 = FR1 * 10
    .rept 6, 5-#
            lda FPTMP:1+6
            adc FPTMP:1+4
            sta FPTMP:1+3
    .endr
            ; Foruth part: FPTMP*+2 = FR1 * 20
            ;              FPTMP*+1 = FR1 * 40
            ;              FPTMP*   = FR1 * 80
            ldx #$02
@   .rept 6, 5-#
            lda FPTMP:1+1,X
            adc FPTMP:1+1,X
            sta FPTMP:1,X
    .endr
            dex
            bpl @-

            ; Move FR0 to FR1
    .rept 5
            lda FR0+1+#
            sta FR1+1+#
    .endr

T_ZFR0      lda #$00
            sta FR0
            sta FR0+1
            sta FR0+2
            sta FR0+3
            sta FR0+4
            sta FR0+5
            rts

; Initializes INBUFF to $0580
T_LDBUFA    lda #>LBUFF
            sta INBUFF+1
            lda #<LBUFF
            sta INBUFF
            rts

T_SKPSPC    inc PORTB
            jsr SKPSPC
            dec PORTB
            rts

T_FASC      inc PORTB
            jsr FASC
            dec PORTB
            rts

T_AFP       inc PORTB
            jsr AFP
            dec PORTB
            rts

T_GETDIGIT  ldy CIX
            lda (INBUFF),Y
            sec
            sbc #$30
            cmp #$0A
            rts

            ; Adds a power-of-two in BCD to the number in A,Y,FR0+1 if the C is set.
.macro @ADD_BIT num
            bcc skip
            adc #<:num
  .if :num < $4FF
    :>:num  iny
    .if :num > $4F
            bcc skip
            iny
    .endif
  .else
            tax
            tya
            adc #>:num
            tay
    .if :num > $FFFF
            lda FR0+1
            adc #^:num
            sta FR0+1
            txa
    .elseif :num > $4FFF
            txa
            bcc skip
            inc FR0+1
    .else
            txa
    .endif
  .endif
skip
.endm

T_IFP       ldy FR0
            lda FR0+1
            sta ZTEMP4
            jsr T_ZFR0
            sed
            tya
            beq IFP_BYTE2       ; First byte is 0, skip
            ; First get the lowest 3 bits directly
            lsr
            lsr
            lsr
            lsr
            sta ZTEMP4+1
            tya
            and #$07
            ldy #$00
            ; Test each remaining bit and add the BCD equivalent if set
            @ADD_BIT $00007
            lsr ZTEMP4+1
            @ADD_BIT $00015
            lsr ZTEMP4+1
            @ADD_BIT $00031
            lsr ZTEMP4+1
            @ADD_BIT $00063
            lsr ZTEMP4+1
            @ADD_BIT $00127
IFP_BYTE2   ldx ZTEMP4
            beq IFP_END         ; If second byte is 0, we are done
            lsr ZTEMP4
            @ADD_BIT $00255
            lsr ZTEMP4
            @ADD_BIT $00511
            lsr ZTEMP4
            @ADD_BIT $01023
            lsr ZTEMP4
            @ADD_BIT $02047
            lsr ZTEMP4
            @ADD_BIT $04095
            lsr ZTEMP4
            @ADD_BIT $08191
            lsr ZTEMP4
            @ADD_BIT $16383
            lsr ZTEMP4
            @ADD_BIT $32767
IFP_END     sty FR0+2
            sta FR0+3
            lda #$42
            sta FR0
            jmp NORMALIZE

RET_CLC2    clc
            rts

T_FSUB      lda FR1
            eor #$80
            sta FR1

T_FADD      lda FR1
            and #$7F
            beq RET_CLC2
            sta ZTEMP4
            lda FR0
            and #$7F
            sec
            sbc ZTEMP4
            bcs ADD_NOSWAP
            ; If negative result, swap operands and retry
    .rept 6
            lda FR0+#
            ldy FR1+#
            sta FR1+#
            sty FR0+#
    .endr
            jmp T_FADD
ADD_NOSWAP  tay
            beq FADD_OK
            ; Exponents differ, move right smaller operand before adding
            dey
            beq FADD_M1
            dey
            beq FADD_M2
            dey
            beq FADD_M3
            dey
            bne RET_CLC2
            ; Move by 4
            lda FR1+1
            sta FR1+5
            sty FR1+4
            sty FR1+3
            sty FR1+2
            jmp FADD_MOK
            ; Move by 3
FADD_M3     lda FR1+2
            sta FR1+5
            lda FR1+1
            sta FR1+4
            sty FR1+3
            sty FR1+2
            jmp FADD_MOK
            ; Move by 2
FADD_M2     lda FR1+3
            sta FR1+5
            lda FR1+2
            sta FR1+4
            lda FR1+1
            sta FR1+3
            sty FR1+2
            jmp FADD_MOK
            ; Move by 1
FADD_M1     lda FR1+4
            sta FR1+5
            lda FR1+3
            sta FR1+4
            lda FR1+2
            sta FR1+3
            lda FR1+1
            sta FR1+2
FADD_MOK    sty FR1+1
            ; Check if we need ADD or SUB
FADD_OK     sed
            lda FR0
            eor FR1
            bmi DO_SUB
            clc
    .rept 5, 5-#
            lda FR0+:1
            adc FR1+:1
            sta FR0+:1
    .endr
            bcc @+
            lda FR0+4
            sta FR0+5
            lda FR0+3
            sta FR0+4
            lda FR0+2
            sta FR0+3
            lda FR0+1
            sta FR0+2
            lda #$01
            sta FR0+1
            inc FR0
@           jmp NORMALIZE

DO_SUB      sec
    .rept 5, 5-#
            lda FR0+:1
            sbc FR1+:1
            sta FR0+:1
    .endr
            bcs NORMALIZE
            ; SUB was negative, negate number
            lda FR0
            eor #$80
            sta FR0
            sec
    .rept 5, 5-#
            tya
            sbc FR0+:1
            sta FR0+:1
    .endr
            jmp NORMALIZE

NORMDIVMUL  ldx FR0+6
            bne @+

NORMALIZE   ldx #$00
@           cld
            ldy FR0
            beq NORM_SET0
            lda FR0+1
            bne NORM_MOK
            dey
            lda FR0+2
            bne NORM_M1
            dey
            lda FR0+3
            bne NORM_M2
            dey
            lda FR0+4
            bne NORM_M3
            dey
            lda FR0+5
            bne NORM_M4
            dey
            txa
            beq NORM_SET0
            ; Move by 5
            sta FR0+1
            bne NORM_MOK
            ; Move by 4
NORM_M4     sta FR0+1
            stx FR0+2
            lda #$00
            sta FR0+5
            sta FR0+4
            sta FR0+3
            beq NORM_MOK
            ; Move by 3
NORM_M3     sta FR0+1
            lda FR0+5
            sta FR0+2
            stx FR0+3
            lda #$00
            sta FR0+5
            sta FR0+4
            beq NORM_MOK
            ; Move by 2
NORM_M2     sta FR0+1
            lda FR0+4
            sta FR0+2
            lda FR0+5
            sta FR0+3
            stx FR0+4
            lda #$00
            sta FR0+5
            beq NORM_MOK
            ; Move by 1
NORM_M1     sta FR0+1
            lda FR0+3
            sta FR0+2
            lda FR0+4
            sta FR0+3
            lda FR0+5
            sta FR0+4
            stx FR0+5
NORM_MOK    sty FR0
            tya
            and #$7F
            cmp #$71    ; Check overflow
            bcs NORM_OV
            cmp #$0F    ; Check underflow
            bcs NORM_OK
NORM_SET0   jsr T_ZFR0
NORM_OK     clc
NORM_OV     rts

T_PLYEVL    stx FLPTR
            sty FLPTR+1
            sta L00EF
            jsr FMOVPLYARG
            jsr T_FLD1P
            dec L00EF
PLY_LOOP    jsr T_FMUL
            bcs PLY_END
            lda FLPTR
            adc #$06
            sta FLPTR
            bcc @+
            inc FLPTR+1
@           jsr T_FLD1P
            jsr T_FADD
            bcs PLY_END
            dec L00EF
            beq PLY_END
    .rept 6
            lda PLYARG+#
            sta FR1+#
    .endr
            jmp PLY_LOOP
PLY_END     rts

T_FLD1P     ldy #$05
            lda (FLPTR),Y
            sta FR1+5
            dey
            lda (FLPTR),Y
            sta FR1+4
            dey
            lda (FLPTR),Y
            sta FR1+3
            dey
            lda (FLPTR),Y
            sta FR1+2
            dey
            lda (FLPTR),Y
            sta FR1+1
            dey
            lda (FLPTR),Y
            sta FR1
            rts

            ; Move FR0 to FR1
T_FMOVE .rept 6
            lda FR0+#
            sta FR1+#
        .endr
            rts

            ; Move FR0 to PLYARG
FMOVPLYARG .rept 6
            lda FR0+#
            sta PLYARG+#
           .endr
            rts

            ; Move FR0 to FPSCR
FMOVSCR .rept 6
            lda FR0+#
            sta FPSCR+#
        .endr
            rts

            ; Load FR0 from PLYARG
LDPLYARG    ldx #$00
            jmp LD_PLY_X

            ; Load FR0 from FPSCR
LDFPSCR     ldx #$06
            jmp LD_PLY_X

            ; Load FR0 from FPSCR1
LDFPSCR1    ldx #$0C
LD_PLY_X  .rept 6
            lda PLYARG+#,X
            sta FR0+#
          .endr
            rts

            ; Load FR1 from FPSCR1
LD1FPSCR1   ldx #$0C
            jmp LD1_PLY_X

            ; Load FR1 from FPSCR
LD1FPSCR    ldx #$06
LD1_PLY_X .rept 6
            lda PLYARG+#,X
            sta FR1+#
          .endr
L2F43       rts

            ; Calculate FR0 = EXP(FR0)
            ; $DDC0 in original mathpack
T_FEXP      ldx #$05
            inc PORTB
L2F49       lda LOG10E,X
            sta FR1,X
            dex
            bpl L2F49
            dec PORTB
            jsr T_FMUL
            bcs L2F43

            ; Calculate FR0 = EXP10(FR0)
            ; $DDCC in original mathpack
T_EXP10     lda #$00
            sta L00F1
            lda FR0
            sta L00F0
            and #$7F
            sta FR0
            cmp #$40
            bcc L2F87
            bne L2F43
            lda FR0+1
            and #$F0
            lsr
            sta L00F1
            lsr
            lsr
            adc L00F1
            sta L00F1
            lda FR0+1
            and #$0F
            adc L00F1
            sta L00F1
            lda #$00
            sta FR0+1
            jsr NORMALIZE
L2F87       lda #$0A
            ldx #<P10COF
            ldy #>P10COF
            inc PORTB
            jsr T_PLYEVL
            dec PORTB
            jsr T_FSQ
            lda L00F1
            beq L2FAC
            lsr
            clc
            adc FR0
            bmi L2FB9
            sta FR0
            lsr L00F1
            bcc L2FAC
            jsr FMUL10
L2FAC       asl L00F0
            bcc L2FBA
            jsr T_FMOVE
            jsr T_FLD1
            jmp T_FDIV
L2FB9       sec
L2FBA       rts

T_FLD1      lda #$40
            sta FR0
            ldy #$01
            sty FR0+1
            dey
            sty FR0+2
            sty FR0+3
            sty FR0+4
            sty FR0+5
            rts

            ; Compute FR0 = (FR0 - C) / (FR1 + C)
            ; with C in [X:Y]
            ; $DE95 in original mathpack
REDRNG      stx FLPTR
            sty FLPTR+1
            jsr FMOVPLYARG
            jsr T_FLD1P
            jsr T_FADD
            jsr FMOVSCR
            jsr LDPLYARG
            jsr T_FLD1P
            jsr T_FSUB
            jsr LD1FPSCR
            jmp T_FDIV
RTS_SEC3    sec
            rts

            ; Compute FR0 = LN(FR0)
            ; $DECD in orignal mathpack
T_FLOG      lda #$05
            bne L2FF4

            ; Compute FR0 = LOG_10(FR0)
            ; $DED1 in orignal mathpack
T_FCLOG     lda #$00
L2FF4       sta L00F0
            lda FR0
            bmi RTS_SEC3
            beq RTS_SEC3
            asl
            eor #$80
            sta L00F1
            lda #$40
            sta FR0
            lda FR0+1
            and #$F0
            beq L3010
            inc L00F1
            jsr FDIV10
L3010       ldx #<SQR10
            ldy #>SQR10
            inc PORTB
            jsr REDRNG
            jsr FMOVSCR
            jsr T_FSQ
            lda #$0A
            ldx #<LGCOEF
            ldy #>LGCOEF
            jsr T_PLYEVL
            dec PORTB
            jsr LD1FPSCR
            jsr T_FMUL
            lda #$3F
            sta FR1
            lda #$50
            sta FR1+1
            lda #$00
            sta FR1+2
            sta FR1+3
            sta FR1+4
            sta FR1+5
            jsr T_FADD
            jsr T_FMOVE
            lda L00F1
            bpl L3053
            clc
            eor #$FF
            adc #$01
L3053       sta FR0
            lda #$00
            sta FR0+1
            jsr T_IFP
            lda L00F1
            and #$80
            ora FR0
            sta FR0
            jsr T_FADD
            ldx L00F0
            beq RTS_CLC
            inc PORTB
L306E       lda LOG10E,X
            sta FR1,X
            dex
            bpl L306E
            dec PORTB
            jmp T_FDIV
RTS_CLC     clc
            rts
RTS_SEC2    sec
            rts

T_FSIN      lda #$04    ; Positive SIN
            bit FR0
            bpl SINCOS
            lda #$02    ; Negative SIN
            bne SINCOS

T_FCOS      lda #$01    ; Positive/Negative COS

SINCOS      sta L00F0
            ; Get absolute value of FR0
            lda FR0
            and #$7F
            sta FR0
            ; And divide by 90° or PI/2
            ldx DEGFLAG
            lda F_PI2,X
            sta FR1
            lda F_PI2+1,X
            sta FR1+1
            lda F_PI2+2,X
            sta FR1+2
            lda F_PI2+3,X
            sta FR1+3
            lda F_PI2+4,X
            sta FR1+4
            lda F_PI2+5,X
            sta FR1+5
            jsr T_FDIV
            bcs RTS_SEC2
            ; Extract integer/fractional parts
            lda FR0
            and #$7F
            sec
            sbc #$40
            bmi L30E6   ; Less than 1.0, already have fractional part
            cmp #$04
            bpl RTS_SEC2        ; More than 100000000, error
            tax
            lda FR0+1,X         ; Get lower two digits
            sta L00F1           ; Calculate (10*A+B) MOD 4 == ((A MOD 2)*2 + B) MOD 4
            and #$10
            beq L30D1
            lda #$02
L30D1       clc
            adc L00F1
            and #$03            ; We now have te quadrant
            adc L00F0           ; Add starting quadrant from the start
            sta L00F0
            stx L00F1
            lda #$00
L30DE       sta FR0+1,X         ; Set integer part to 0
            dex
            bpl L30DE
            jsr NORMALIZE       ; And normalize FP number

L30E6       lsr L00F0           ; Check odd quadrants, and compute FR0 = (1-FR0)
            bcc L30F3
            jsr T_FMOVE
            jsr T_FLD1
            jsr T_FSUB

L30F3       jsr FMOVSCR         ; Store FR0 into FPSCR
            jsr T_FSQ           ; And get FR0^2
            bcs RTS_SEC2
            lda #$06
            ldx #<SCOEF
            ldy #>SCOEF
            jsr T_PLYEVL        ; Evaluate polynomial in X^2
            jsr LD1FPSCR
            jsr T_FMUL          ; Multiply by original X
            lsr L00F0           ; Check quadrant to negate result
            bcc L3117
            clc
            lda FR0
            beq L3117
            eor #$80
            sta FR0
L3117       rts

SCOEF       .fl -3.551499391e-6
            .fl 1.60442752e-4
            .fl -4.6817543551e-3
            .byte $3F,$07,$96,$92,$62,$39 ; .fl 7.96926239e-2 ; MADS error
            .fl -6.459640867e-1
F_PI2       .fl 1.570796324  ; used in RAD mode
            .fl 90           ; used in DEG mode
F_1DEG      .byte $3f, $01, $74, $53, $29, $25 ; = PI / 180
            ;.fl 0.01745329251994 ; can't make mads produce the last digit!!!
T_FATN      lda #$00
            sta L00F0
            sta L00F1
            lda FR0
            and #$7F
            cmp #$40
            bmi L3171
            lda FR0
            and #$80
            sta L00F0
            inc L00F1
            lda #$7F
            and FR0
            sta FR0
            ldx #<FP9S
            ldy #>FP9S
            inc PORTB
            jsr REDRNG
            dec PORTB
L3171       jsr FMOVSCR
            jsr T_FSQ
            bcs L31C0
            lda #$0B
            ldx #<ATNCOEF
            ldy #>ATNCOEF
            inc PORTB
            jsr T_PLYEVL
            dec PORTB
            bcs L31C0
            jsr LD1FPSCR
            jsr T_FMUL
            bcs L31C0
            lda L00F1
            beq L31AF
            ldx #$05
            inc PORTB
L319B       lda FP_PI4,X
            sta FR1,X
            dex
            bpl L319B
            dec PORTB
            jsr T_FADD
            lda L00F0
            ora FR0
            sta FR0
L31AF       lda DEGFLAG
            beq L31C0
            ldx #$05
L31B5       lda F_1DEG,X
            sta FR1,X
            dex
            bpl L31B5
            jsr T_FDIV
L31C0       rts

SQRT_NEG    sec
            rts
SQRT_0      clc
            rts

T_FSQRT     lda #$00
            sta L00F1
            lda FR0
            bmi SQRT_NEG
            beq SQRT_0
            cmp #$3F    ; 0.01 < X < 1 , don't need adjustment at end
            beq @+
            clc
            adc #$01
            sta L00F1
@           lda #$06
            sta L00EF
            lda #$3F
            sta FR0
            jsr FMOVSCR ; Store original X
            jsr T_FMOVE ; Get starting iteration value
            jsr T_FLD1
            inc FR0+1
            jsr T_FSUB
            jsr LD1FPSCR
            jsr T_FMUL
            ; Iteration loop: Z' = Z + (Z / X - Z)/2
SQRT_LP   .rept 6
            lda FR0+#
            sta FPSCR1+#
          .endr
            jsr T_FMOVE
            jsr LDFPSCR
            jsr T_FDIV
            jsr LD1FPSCR1
            jsr T_FSUB
            jsr FPHALF
            lda FR0
            beq SQRT_SKIP       ; We are already adding 0, skip rest of iterations
            jsr LD1FPSCR1
            jsr T_FADD
            dec L00EF
            bpl SQRT_LP
            bmi SQRT_END

SQRT_SKIP   jsr LDFPSCR1
SQRT_END    lda L00F1
            beq SQRT_OK
            lsr
            clc
            adc FR0
            sbc #$1F
            sta FR0
            lsr L00F1
            bcc SQRT_OK
            jsr FMUL10
SQRT_OK     clc
            rts

L324C       jmp T_ZFR0

FPHALF      lda FR0
            and #$7F
            cmp #$0F
            bcc L324C
            jsr T_FMOVE
            sed
            ldx #$00
            ldy #$04
            clc
L3260       lda FR0+5
            adc FR1+5
            sta FR0+5
            lda FR0+4
            adc FR1+4
            sta FR0+4
            lda FR0+3
            adc FR1+3
            sta FR0+3
            lda FR0+2
            adc FR1+2
            sta FR0+2
            lda FR0+1
            adc FR1+1
            sta FR0+1
            txa
            adc #$00
            tax
            dey
            bne L3260
            cld
            txa
            beq FDIV10
            lda FR0+4
            sta FR0+5
            lda FR0+3
            sta FR0+4
            lda FR0+2
            sta FR0+3
            lda FR0+1
            sta FR0+2
            stx FR0+1
FMUL10      lda FR0+1
            cmp #$10
            bcc L32D2
            inc FR0     ; Multiply by 100, then divide by 10
FDIV10      lda FR0+1
            cmp #$10
            bcc L32D0
            lsr
            ror FR0+2
            ror FR0+3
            ror FR0+4
            ror FR0+5
            lsr
            ror FR0+2
            ror FR0+3
            ror FR0+4
            ror FR0+5
            lsr
            ror FR0+2
            ror FR0+3
            ror FR0+4
            ror FR0+5
            lsr
            ror FR0+2
            ror FR0+3
            ror FR0+4
            ror FR0+5
            sta FR0+1
            rts
L32D0       dec FR0     ; Divide by 100, then multiply by 10
L32D2       lda #$00
            asl FR0+5
            rol FR0+4
            rol FR0+3
            rol FR0+2
            rol FR0+1
            rol
            asl FR0+5
            rol FR0+4
            rol FR0+3
            rol FR0+2
            rol FR0+1
            rol
            asl FR0+5
            rol FR0+4
            rol FR0+3
            rol FR0+2
            rol FR0+1
            rol
            asl FR0+5
            rol FR0+4
            rol FR0+3
            rol FR0+2
            rol FR0+1
            rol
            rts
L3301       cmp #$FF
            bcc L3307
            cpy #$50
L3307       txa
            adc #$00
            sta FR0
            rts
L330D       tya
            and #$F0
            lsr
            sta FR0
            lsr
            lsr
            adc FR0
            sta FR0
            tya
            and #$0F
            ldx FR0+2
            cpx #$50
            adc FR0
            sta FR0
            rts
T_FPI       ldx #$00
            ldy FR0+1
            lda FR0
            stx FR0+1
            sec
            sbc #$40
            bcc L3301
            beq L330D
            cmp #$02
            beq L337D
            bcs L337C
            lda FR0+2
            and #$F0
            lsr
            sta FR0
            lsr
            lsr
            adc FR0
            sta FR0
            lda FR0+2
            and #$0F
            ldx FR0+3
            cpx #$50
            adc FR0
            sta FR0
L3353       tya
            and #$0F
            tax
            lda X100L,X
            adc FR0
            sta FR0
            lda X100H,X
            adc FR0+1
            sta FR0+1
            tya
            and #$F0
            beq L337C
            lsr
            lsr
            lsr
            tax
            lda FR0
            adc X1000-2,X
            sta FR0
            lda FR0+1
            adc X1000-1,X
            sta FR0+1
L337C       rts
L337D       cpy #$07
            bcs L337C
            lda FR0+3
            and #$F0
            lsr
            sta FR0
            lsr
            lsr
            adc FR0
            sta FR0
            lda FR0+3
            and #$0F
            ldx FR0+4
            cpx #$50
            adc FR0
            sta FR0
            lda X10000L,Y
            adc FR0
            sta FR0
            lda X10000H,Y
            adc FR0+1
            sta FR0+1
            ldy FR0+2
            bne L3353
            rts
X10000L     .byte <0,<10000,<20000,<30000,<40000,<50000,<60000
X10000H     .byte >0,>10000,>20000,>30000,>40000,>50000,>60000
X1000       .word 1000,2000,3000,4000,5000,6000,7000,8000,9000
X100L       .byte <0,<100,<200,<300,<400,<500,<600,<700,<800,<900
X100H       .byte >0,>100,>200,>300,>400,>500,>600,>700,>800,>900

; vi:syntax=mads
