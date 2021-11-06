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

            ; PAINT (flood fill)
            ; NOTE:
            ;   Fills complete horizontal lines, storing a list of pixel spans in
            ;   a buffer indexed by PNTSTK, initialized to the top of the return
            ;   stack, up to MEMTOP.
            ;   Each span is stored in 3 bytes, as expanded column:
            ;     0: left byte ($00 to $7F), bit 7 = direction (up/down)
            ;     1: bit 3-5: left pos
            ;        but 0-2: right pos
            ;     2: right byte ($00 to $7F)
            ;

X_PAINT .proc

PNTSTK = MVLNG  ; Use MVLNG as Paint Stack Pointer
STKEND = $E7    ; Use $E7/$E8 as Stack End Pointer
POSY = MVFA     ; Use MVFA as current Y coordinate
POSX = MVTA     ; Use MVTA as X coordinate

            jsr GET2INT
            sta POSY
            bne PP_RTS
            jsr PREPLOT
            bcs PP_RTS
            lda TOPRSTK
            sta PNTSTK
            lda TOPRSTK+1
            sta PNTSTK+1
            lda MEMTOP
            sbc #$06
            sta STKEND
            lda MEMTOP+1
            sbc #$00
            sta STKEND+1
            ; Paint next span
PAINT_NXT   clc
            lda PNTSTK
            adc #$03
            sta PNTSTK
            bcc @+
            inc PNTSTK+1
@           cmp STKEND
            lda PNTSTK+1
            sbc STKEND+1
            bcc @+
            jmp ERR_2   ; Not enough memory for the next span
@           ldx L00ED
            ldy FR1+3
            jsr PLOT_GET
            beq @+
            jmp PAINT_ESPN
            ; Plot all possible points to the left
@           jsr PLOT_SET
PLOT_LNXT   jsr PLOT_DCOL
            tya
            bmi PLOT_LEND
            jsr PLOT_GET
            bne PLOT_LEND
            jsr PLOT_SET
            jmp PLOT_LNXT
            ; Store last point to the left
PLOT_LEND   jsr PLOT_ICOL
            tya
            ldy #$00
            sta (PNTSTK),Y
            txa
            asl
            asl
            asl
            iny
            sta (PNTSTK),Y
            ; Plot all possible points to the right
            ldy FR1+3
            ldx L00ED
PLOT_RNXT   jsr PLOT_ICOL
            cpy FR1+1
            bcs PLOT_REND
            jsr PLOT_GET
            bne PLOT_REND
            jsr PLOT_SET
            jmp PLOT_RNXT
            ; Store last point to the right
PLOT_REND   jsr PLOT_DCOL
            tya
            ldy #$02
            sta (PNTSTK),Y
            txa
            dey
            ora (PNTSTK),Y
            sta (PNTSTK),Y
            ; Test pixels in the next row (from current span)
            ldy POSY
            iny
            cpy FR1
            bcs LFE85
            jsr PLOT_IROW
            ; Start from left span coordinate
            jsr PAINT_GETL
PAINT_SPDN  ; Check if we have more pixels in the span to test DOWN
            ldy #$01
            lda (PNTSTK),Y
            and #$07
            cmp L00ED
            iny
            lda (PNTSTK),Y
            sbc FR1+3
            bcc LFE82
            ldy #$00
            lda (PNTSTK),Y
            ora #$80
LFE7D       sta (PNTSTK),Y
            jmp PAINT_NXT
LFE82       jsr PLOT_DROW
            ; Test pixels in prev row (from current span)
LFE85       ldy POSY
            dey
            cpy FR1
            bcs LFEAC
            jsr PLOT_DROW
            ; Start from left span coordinate
            jsr PAINT_GETL
PAINT_SPUP  ; Check if we have more pixels in the span to test UP
            ldy #$01
            lda (PNTSTK),Y
            and #$07
            cmp L00ED
            iny
            lda (PNTSTK),Y
            sbc FR1+3
            bcc @+
            ldy #$00
            lda (PNTSTK),Y
            and #$7F
            bpl LFE7D
@           jsr PLOT_IROW
LFEAC       ldy #$01
            lda (PNTSTK),Y
            and #$07
            tax
            iny
            lda (PNTSTK),Y
            tay
            // Ensure that we are outside span, we tested all
            jsr PLOT_ICOL
            ; End current span, continue from next pixel on old span
PAINT_ESPN  jsr PLOT_ICOL
            stx L00ED
            sty FR1+3
            sec
            lda PNTSTK
            sbc #$03
            sta PNTSTK
            bcs @+
            dec PNTSTK+1
@           cmp TOPRSTK
            bne @+
            lda PNTSTK+1
            cmp TOPRSTK+1
            beq RTS_
@           ldy #$00
            lda (PNTSTK),Y
            bpl PAINT_SPUP
            bmi PAINT_SPDN

            ; Increment plot row
PLOT_IROW   inc POSY
INC_ROW     clc         ; Used from TEXT statement
            lda L00DE
            adc FR1+1
            sta L00DE
            bcc RTS_
            inc L00DF
RTS_        rts         ; Used as general RTS

            ; Decrement plot row
PLOT_DROW   dec POSY
            sec
            lda L00DE
            sbc FR1+1
            sta L00DE
            bcs @+
            dec L00DF
@           rts

            ; Read left pixel from span list
PAINT_GETL  ldy #$00
            lda (X_PAINT.PNTSTK),Y
            and #$7F
            sta FR1+3
            iny
            lda (X_PAINT.PNTSTK),Y
            lsr
            lsr
            lsr
            sta L00ED
            rts

            ; Increment plot column
PLOT_ICOL   cpx FR1+4
            inx
            bcc @+
            ldx #$00
            iny
@           rts

            ; Decrement plot column
PLOT_DCOL   dex
            bpl @+
            ldx FR1+4
            dey
@           rts

            ; Plots a pixel at current coordinates
PLOT_SET    lda (L00DE),Y
            and PLOT_MASK,X
            ora PLOT_PIX,X
            sta (L00DE),Y
            rts

            ; Get pixel value at current coordinates
PLOT_GET    lda (L00DE),Y
            ora PLOT_MASK,X
            eor PLOT_MASK,X
            beq @+
            lda PLOT_PIX
            rts
@           lda PLOT_PIX
            beq @+
            lda #$00
            rts
@           lda #$01
            rts
        .endp

; vi:syntax=mads
