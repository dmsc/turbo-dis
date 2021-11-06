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

            ; Calculate A*A, store in $E5+X and $E6+X (FR1+5+X, FR1+6+X)
ASQUARE .proc
            sta FR0+2
            sta FR0+3
            ldy #$08
MLOOP       asl FR1+6,X
            rol FR1+5,X
            rol FR0+2
            bcc @+
            clc
            lda FR1+6,X
            adc FR0+3
            sta FR1+6,X
            bcc @+
            inc FR1+5,X
@           dey
            bne MLOOP
            rts
        .endp

ERR_3G      jmp ERR_3

X_CIRCLE .proc
            jsr GET3INT
            bne ERR_3G
            pha
            ldy STINDEX
            iny
            cpy NXTSTD
            bcs @+
            jsr GETINT  ; Read ellipse Y radius
            bne ERR_3G
@           pla
            bne LDE97
            lda #$01    ; Don't allow radius_X = 0
LDE97       sta FR0+1
            ; Here we have the following variables:
CX = MVFA
CY = MVTA
RY = FR0
RX = FR0+1
            ;   $99 (MVFA)      : Center_X (2 bytes)
            ;   $9B (MVTA)      : Center_Y (2 bytes)
            ;   $D4 (FR0)       : Radius_Y
            ;   $D5 (FR0+1)     : Radius_X
            ;   $D6 (FR0+2)     : temporary variable 1
            ;   $D7 (FR0+3)     : temporary variable 2
TEMP = $D6
PX  = $E0
PY  = $E1
ERR = $E2
RX2 = $E5
RY2 = $E7
ADX = $E9
ADY = $DA
            ;   $DC/$DB/$DA     : Add_Y = Radius_Y^2 * X, starts = Radius_Y^2 * Radius_X)
            ;   $E0 (FR1)       : X, starts = Radius_X
            ;   $E1 (FR1+1)     : Y, starts = 0
            ;   $E4/$E3/$E2     : Error, starts at 0
            ;   $E6/$E5         : Radius_X^2
            ;   $E8/$E7         : Radius_Y^2
            ;   $EB/$EA/$E9     : Add_X = Radius_X^2 * Y, starts = 0
            ;
            ; Clear all variables to 0
            ldx #$16
            lda #$00
LDE9D       sta TEMP,X
            dex
            bpl LDE9D
            ; Gets (radius_X)^2 -> $E6/$E5 and radius_X -> $E0 (X)
            lda RX
            sta FR1
            inx
            jsr ASQUARE
            ; Gets (radius_Y)^2 -> $E8/$E7
            lda RY
            ldx #$02
            jsr ASQUARE
            ; Multiplies (radius_Y^2) * (radius_X) -> $DC/$DB/$DA
            lda RX
            sta TEMP
            ldy #$08
MUL1        asl ADY+2
            rol ADY+1
            rol ADY
            asl TEMP
            bcc @+
            clc
            lda ADY+2
            adc RY2+1
            sta ADY+2
            lda ADY+1
            adc RY2
            sta ADY+1
            bcc @+
            inc ADY
@           dey
            bne MUL1
            ; Plots 4 points in the circle
PLOT        jsr ADD_XPOS
            jsr ADD_Y_PLOT      ; center + (+x,+y)
            jsr ADD_XPOS
            jsr SUB_Y_PLOT      ; center + (+x,-y)
            jsr SUB_XPOS
            jsr ADD_Y_PLOT      ; center + (-x,+y)
            jsr SUB_XPOS
            jsr SUB_Y_PLOT      ; center + (-x,-y)
            ; Test error
            bit ERR
            bmi LDF12
            ; Error Positive, increment Y
            inc PY              ; Y = Y + 1
            clc                 ; Add_X = Add_X + Radius_X ^ 2
            lda ADX+2
            adc RX2+1
            sta ADX+2
            lda ADX+1
            adc RX2
            sta ADX+1
            bcc LDF04
            inc ADX
LDF04       sec                 ; Error = Error - Add_X
            ldx #$02
LDF07       lda ERR,X
            sbc ADX,X
            sta ERR,X
            dex
            bpl LDF07
            bmi PLOT            ; Loop again

            ; Error Negative, decrement X
LDF12       lda FR1
            beq CLEAR_XYPOS
            dec FR1             ; X = X - 1
            sec                 ; Add_Y = Add_Y - Radius_Y ^2
            lda ADY+2
            sbc RY2+1
            sta ADY+2
            lda ADY+1
            sbc RY2
            sta ADY+1
            bcs LDF29
            dec ADY
LDF29       clc                 ; Error = Error + Add_Y
            ldx #$02
LDF2C       lda ERR,X
            adc ADY,X
            sta ERR,X
            dex
            bpl LDF2C
            bmi PLOT            ; Loop Again

ADD_XPOS    clc
            lda CX
            adc PX
            sta COLCRS
            lda CX+1
            adc #$00
            sta COLCRS+1
            rts

CLEAR_XYPOS ldx #$00
            stx ROWCRS
            stx COLCRS
            stx COLCRS+1
            rts

SUB_XPOS    sec
            lda CX
            sbc PX
            sta COLCRS
            lda CX+1
            sbc #$00
            sta COLCRS+1
            rts
ADD_Y_PLOT  clc
            lda CY
            adc PY
            sta ROWCRS
            lda CY+1
            adc #$00
            beq CIRC_PLOT
LDF69       rts
SUB_Y_PLOT  sec
            lda CY
            sbc PY
            sta ROWCRS
            lda CY+1
            sbc #$00
            bne LDF69
CIRC_PLOT   ldy COLOR
            ldx #$60
            jsr PDUM_ROM
            cpy #$80    ; Check for BREAK key
            bne LDF69
            jmp CIOERR_Y
        .endp

; vi:syntax=mads
