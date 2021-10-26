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
LDE66       asl L00E6,X
            rol FR1+5,X
            rol FR0+2
            bcc LDE79
            clc
            lda L00E6,X
            adc FR0+3
            sta L00E6,X
            bcc LDE79
            inc FR1+5,X
LDE79       dey
            bne LDE66
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
            bcs LDE92
            jsr GETINT
            bne ERR_3G
LDE92       pla
            bne LDE97
            lda #$01    ; Don't allow radius_X = 0
LDE97       sta FR0+1
            ; Here we have the following variables:
            ;   $99/$9A         : Center_X
            ;   $9B/$9C         : Center_Y
            ;   $D4 (FR0)       : Radius_Y
            ;   $D5 (FR0+1)     : Radius_X
            ;   $D6 (FR0+2)     : temporary variable 1
            ;   $D7 (FR0+3)     : temporary variable 2
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
LDE9D       sta FR0+2,X
            dex
            bpl LDE9D
            ; Gets (radius_X)^2 -> $E6/$E5 and radius_X -> $E0 (X)
            lda FR0+1
            sta FR1
            inx
            jsr ASQUARE
            ; Gets (radius_Y)^2 -> $E8/$E7
            lda FR0
            ldx #$02
            jsr ASQUARE
            ; Multiplies (radius_Y^2) * (radius_X) -> $DC/$DB/$DA
            lda FR0+1
            sta FR0+2
            ldy #$08
LDEB7       asl L00DC
            rol L00DB
            rol L00DA
            asl FR0+2
            bcc LDED2
            clc
            lda L00DC
            adc L00E8
            sta L00DC
            lda L00DB
            adc L00E7
            sta L00DB
            bcc LDED2
            inc L00DA
LDED2       dey
            bne LDEB7
            ; Plots 4 points in the circle
LDED5       jsr ADD_XPOS
            jsr ADD_Y_PLOT      ; center + (+x,+y)
            jsr ADD_XPOS
            jsr SUB_Y_PLOT      ; center + (+x,-y)
            jsr SUB_XPOS
            jsr ADD_Y_PLOT      ; center + (-x,+y)
            jsr SUB_XPOS
            jsr SUB_Y_PLOT      ; center + (-x,-y)
            ; Test error
            bit FR1+2
            bmi LDF12
            ; Error Positive, increment Y
            inc FR1+1           ; Y = Y + 1
            clc                 ; Add_X = Add_X + Radius_X ^ 2
            lda L00EB
            adc L00E6
            sta L00EB
            lda L00EA
            adc FR1+5
            sta L00EA
            bcc LDF04
            inc L00E9
LDF04       sec                 ; Error = Error - Add_X
            ldx #$02
LDF07       lda FR1+2,X
            sbc L00E9,X
            sta FR1+2,X
            dex
            bpl LDF07
            bmi LDED5           ; Loop again

            ; Error Negative, decrement X
LDF12       lda FR1
            beq CLEAR_XYPOS
            dec FR1             ; X = X - 1
            sec                 ; Add_Y = Add_Y - Radius_Y ^2
            lda L00DC
            sbc L00E8
            sta L00DC
            lda L00DB
            sbc L00E7
            sta L00DB
            bcs LDF29
            dec L00DA
LDF29       clc                 ; Error = Error + Add_Y
            ldx #$02
LDF2C       lda FR1+2,X
            adc L00DA,X
            sta FR1+2,X
            dex
            bpl LDF2C
            bmi LDED5           ; Loop Again

ADD_XPOS    clc
            lda L0099
            adc FR1
            sta COLCRS
            lda L009A
            adc #$00
            sta COLCRS+1
            rts

CLEAR_XYPOS ldx #$00
            stx ROWCRS
            stx COLCRS
            stx COLCRS+1
            rts

SUB_XPOS    sec
            lda L0099
            sbc FR1
            sta COLCRS
            lda L009A
            sbc #$00
            sta COLCRS+1
            rts
ADD_Y_PLOT  clc
            lda L009B
            adc FR1+1
            sta ROWCRS
            lda L009C
            adc #$00
            beq CIRC_PLOT
LDF69       rts
SUB_Y_PLOT  sec
            lda L009B
            sbc FR1+1
            sta ROWCRS
            lda L009C
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
