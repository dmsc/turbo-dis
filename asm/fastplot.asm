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

        .local

            ; Graphics modes constants
            ;
GR_ROWS     .byte $18,$18,$0C,$18,$30,$30,$60,$60
            .byte $C0,$C0,$C0,$C0,$18,$0C,$C0,$C0
GR_STRIDE   .byte $28,$14,$14,$0A,$0A,$14,$14,$28
            .byte $28,$28,$28,$28,$28,$28,$14,$28
GR_COLRS    .byte $00,$00,$00,$02,$03,$02,$03,$02
            .byte $03,$01,$01,$01,$00,$00,$03,$02
GR_PPBYTE   .byte $00,$01,$03,$07
GR_MASK     .byte $00,$F0,$FC,$FE
GR_BPP      .byte $04,$02,$01

RTS_SEC     sec
            rts

            ; Fill tables for fast PLOT
            ;
            ; INPUT:
            ;   MVFA  : plot row
            ;   MVTA  : plot column (lo)
            ;   MVTA+1:             (hi)
            ;   COLOR : color to use (OS variable)
            ;   DINDEX: current graphics mode (OS variable)
            ;
            ; OUTPUT:
            ;   carry    : set on error
            ;   PLOT_PIX : table of bytes to plot the pixel (OR-ed to the screen)
            ;   PLOT_MASK: table of masks to plot (AND-ed to the screen)
            ;   L00DE    : pointer to screen byte at start of row
            ;   FR1+3    : byte to plot in the line
            ;   L00ED    : index into PLOT_PIX/PLOT_MASK table for current point
            ;
.def :PREPLOT
PREPLOT     lda DINDEX
            and #$0F
            tax
            lda #$00
            sta L00DF
            lda MVFA
            asl
            rol L00DF
            asl
            rol L00DF
            adc MVFA
            bcc @+
            inc L00DF
@           asl
            sta L00DE
            rol L00DF
            lda GR_ROWS,X
            sta FR1
            cmp MVFA
            beq RTS_SEC
            bcc RTS_SEC
            ldy GR_COLRS,X
            sty FR1+2
            lda GR_MASK,Y
            sta PLOT_MASK
            lda GR_STRIDE,X
            sta FR1+1
            lsr
            lsr
            lsr
            lsr
            tax
            beq PP_SKIP
@           asl L00DE
            rol L00DF
            dex
            bne @-
PP_SKIP     clc
            lda L00DE
            adc SAVMSC
            sta L00DE
            lda L00DF
            adc SAVMSC+1
            sta L00DF
            lda MVTA+1
            sta FR1+4
            lda MVTA
            sta FR1+3
            ldy FR1+2
            sty L00ED
            beq PP_SKIP2
            and GR_PPBYTE,Y
            sta L00ED
@           lsr FR1+4
            ror FR1+3
            dey
            bne @-
PP_SKIP2    lda FR1+4
            bne RTS_SEC
            lda FR1+3
            cmp FR1+1
            bcs RTS_SEC
            ldx FR1+2
            bne PP_NTEXT
            ; Text modes, convert to screen code
            lda COLOR
            jsr ATA2SCR
            sta PLOT_PIX
            clc
            rts

            ; Graphics mode, get masks
PP_NTEXT    ldy GR_PPBYTE,X
            sty FR1+4
            lda GR_BPP-1,X
            sta L00EE
            lda COLOR
            ora PLOT_MASK
            eor PLOT_MASK
PP_PIXLOOP  sta PLOT_PIX,Y
            ldx L00EE
@           asl
            dex
            bne @-
            dey
            bpl PP_PIXLOOP
            ldy FR1+4
            lda PLOT_MASK
PP_MSKLOOP  sta PLOT_MASK,Y
            ldx L00EE
@           sec
            rol
            dex
            bne @-
            dey
            bpl PP_MSKLOOP
            clc
        .endl
PP_RTS      rts ; Used outside as jump target!

; vi:syntax=mads
