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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Loader for the RAM under ROM parts and initialization, this will be
; erased on first run
;
            org TBXL_ROMLOADER

INIT        ldx KEYBDV+4
            ldy KEYBDV+5
            inx
            bne L600A
            iny
L600A       stx JSR_GETKEY+1
            sty JSR_GETKEY+2
            lda #$00
            sta NMIEN
            sei
            lda #$FE
            sta PORTB
            lda #<NMI_PROC
            sta NMI_VEC
            lda #>NMI_PROC
            sta NMI_VEC+1
            lda #<IRQ_PROC
            sta IRQ_VEC
            lda #>IRQ_PROC
            sta IRQ_VEC+1
            lda #>$CC00
            jsr ROM2RAM
            lda #>$E000
            jsr ROM2RAM
            lda #$40
            sta NMIEN
            cli
            ; Activate ROM and load rest of file
            lda #$FF
            sta PORTB
            jsr LOAD_BLOCK

.if .not .def tb_fixes
            ; We don't need to set BOOT to 0 here, as we will set it again bellow
            lda #$00
            sta BOOT
.endif
            lda DOSINI
            ldy DOSINI+1
            sta JMPDOS+1
            sty JMPDOS+2
            lda #<RESET_V
            ldy #>RESET_V
            sta DOSINI
            sty DOSINI+1
            lda #$FE
            sta PORTB
            sta LOADFLG
            ldx #$01
            stx BASICF
.if .not .def tb_fixes
            stx BOOT
.else
            ; FIX: properly handle BOOT flag, as it is a bit-field.
            txa
            ora BOOT
            sta BOOT
.endif
            dex
            stx COLDST
            jsr INIT_MEM
            lda #$00
            sta TSLNUM
            sta TSLNUM+1
            jsr SRCHLN_NC

            ; Insert startup program, open "E:" and run
            ldy #ARUN_LEN
            ldx #STMCUR
            jsr EXPLOW
            ldy #ARUN_LEN-1
L6084       lda ARUN_PROG,Y
            sta (L0097),Y
            dey
            bpl L6084
            jsr GEN_LNHASH
            lda #>(EXECNL-1)
            pha
            lda #<(EXECNL-1)
            pha
            jsr OPEN_EDITR
            dec PORTB
            lda #$00
            tay
L609E       sta LB000,Y
            dey
            bpl L609E
            jmp RUN_NOFILE

ARUN_PROG
            ; This is:
            ;  0 TRAP %1 : RUN "D:AUTORUN.BAS"
            ;  1 NEW
            .word 0
            .byte $19,$07,TOK_TRAP,CN1,CEOS
            .byte $19, TOK_RUN,$0F,$0D,'D:AUTORUN.BAS', CCR
            .word 1
            .byte $06,$06,TOK_NEW,CCR
ARUN_LEN    = * - ARUN_PROG

OPEN_EDITR  lda #$FF
            sta PORTB
            lda #>$C000
            sta RAMTOP
            lsr
            sta APPMHI+1
            lda EDITRV+1
            pha
            lda EDITRV
            pha
            rts

ROM2RAM     sta FR0+1
            ldy #$00
            sty FR0
            ldx #$04
L60E3       lda #$FF
            sta PORTB
L60E8       lda (FR0),Y
            sta VARSTK0,Y
            iny
            bne L60E8
            dec PORTB
L60F3       lda VARSTK0,Y
            sta (FR0),Y
            iny
            bne L60F3
            inc FR0+1
            dex
            bne L60E3
            rts

            ; Load 4 bytes (block header) from file
            ;  FR0+2/FR0+3 : START_ADDR
            ;  FR0+4/FR0+5 : END_ADDR
LOAD_BLOCK  ldx #$10
            lda #(FR0+2)
            sta IOCB0+ICBAL,X
            lda #$00
            sta IOCB0+ICBAH,X
            sta IOCB0+ICBLH,X
            lda #$04
            sta IOCB0+ICBLL,X
            lda #$07
            sta IOCB0+ICCOM,X
            jsr CIOV
            bmi LOAD_END

            ; Load block data to buffer
            lda #<LOAD_BUFFER
            sta L00DA
            sta IOCB0+ICBAL,X
            lda #>LOAD_BUFFER
            sta L00DB
            sta IOCB0+ICBAH,X
            ; Calculate length: LEN = END-START+1
            lda FR0+4
            sbc FR0+2
            sta L00DC
            lda FR0+5
            sbc FR0+3
            sta L00DD
            inc L00DC
            bne L613F
            inc L00DD
L613F       lda L00DC
            sta IOCB0+ICBLL,X
            lda L00DD
            sta IOCB0+ICBLH,X
            jsr CIOV
            bmi LOAD_ERROR

            ; Now, copy block to real location in RAM under ROM
            dec PORTB
            ldy #$00
            ldx L00DD
            beq L6165
L6157       lda (L00DA),Y
            sta (FR0+2),Y
            iny
            bne L6157
            inc FR0+3
            inc L00DB
            dex
            bne L6157
L6165       ldx L00DC
            beq L6171
L6169       lda (L00DA),Y
            sta (FR0+2),Y
            iny
            dex
            bne L6169
L6171       lda #$FF
            sta PORTB
            bmi LOAD_BLOCK

.if .not .def tb_lowmem
LOAD_END    rts
.endif

LOAD_ERROR  jmp (DOSVEC)


; vi:syntax=mads
