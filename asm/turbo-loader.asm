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

; The character map of the loader - used to avoid screen flicker while loading
RAM_CHMAP   = $5C00
; The loader address - will be overwritten by the main code
TBXL_LOADER = $2100

;
; Start of loader
;
.if .not .def tb_fixes
            ; Adjust MEMLO
            ; This is not needed with new version, as the MEMLO value
            ; is always hard-coded in the binary, so by not changing it
            ; we have a smaller binary.
            org MEMLO
            .word TOP_LOWMEM
.endif

            ; Load character definitions for chars 64-95
            org RAM_CHMAP + $200
            .byte $00,$18,$18,$FF,$3C,$3C,$66,$42
            .byte $00,$00,$00,$06,$66,$7E,$76,$66
            .byte $00,$00,$18,$3C,$66,$7E,$66,$66
            .byte $00,$3E,$73,$33,$3E,$30,$30,$78
            .byte $00,$7C,$37,$33,$3E,$30,$30,$78
            .byte $00,$00,$60,$63,$36,$3C,$39,$63
            .byte $00,$01,$01,$0F,$03,$03,$F6,$E4
            .byte $00,$80,$80,$F0,$C0,$C0,$60,$20
            .byte $00,$01,$03,$06,$06,$06,$03,$01
            .byte $00,$E1,$33,$06,$06,$06,$33,$E1
            .byte $00,$C7,$63,$33,$36,$36,$66,$CE
            .byte $00,$0E,$9C,$9C,$F6,$66,$66,$67
            .byte $00,$7E,$33,$33,$3E,$30,$30,$78
            .byte $00,$67,$66,$66,$66,$66,$66,$3C
            .byte $00,$FF,$31,$31,$31,$31,$31,$7B
            .byte $00,$FB,$81,$81,$F1,$81,$81,$FB
            .byte $00,$F8,$8C,$8C,$F8,$B0,$98,$CC
;
            org TBXL_LOADER
;
SPLASHSCR   ldx #$00
COPYCHR     lda ROM_CHMAP,X
            sta RAM_CHMAP,X
            lda ROM_CHMAP+$100,X
            sta RAM_CHMAP+$100,X
            lda ROM_CHMAP+$300,X
            sta RAM_CHMAP+$300,X
            inx
            bne COPYCHR
            lda #$10
            sta COLOR2
            lda #>RAM_CHMAP
            sta COLOR1
            sta CRSINH
            sta CHBAS
            lda #<LOAD_MSG
            sta IOCB0+ICBAL
            lda #>LOAD_MSG
            sta IOCB0+ICBAH
            lda #(END_LOAD_MSG - LOAD_MSG)
            sta IOCB0+ICBLL
            stx IOCB0+ICBLH
            lda #$0B
            sta IOCB0+ICCOM
            jsr CIOV
            stx CRSINH
            rts

LOAD_MSG    .byte $7d, CR
            .byte $7f, $7f, $20, $00, $01, $02, $03, $04, $05, $06, $07, CR
            .byte $7f, $7f, $08, $09, $0A, $0B, $0C, $0D, $0E, $0F, $10, CR
            .byte CR
.if .not .def tb_fixes
            .byte $7f, '    TURBO-BASIC XL 1.5', CR
.else
    .if .def tb_lowmem
            .byte $7f, '   TURBO-BASIC XL 1.5-R', CR
    .else
            .byte $7f, '   TURBO-BASIC XL 1.5-F', CR
    .endif
.endif
            .byte $7f, ' (c) 1985 Frank Ostrowski', CR
.if .def tb_fixes
            .byte CR
            .byte '   Fixes and relocatable by DMSC', CR
            .byte $7F, $7F, '2021.11.06'
.endif
            .byte CR
END_LOAD_MSG

;           Run our splash screen
            INI SPLASHSCR

; vi:syntax=mads
