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

ERR_21      lda #$15
            .byte $2C   ; Skip 2 bytes
ERR_19      lda #$13
            .byte $2C   ; Skip 2 bytes
ERR_18      lda #$12
            .byte $2C   ; Skip 2 bytes
X_ERROR     lda #$11
SERROR      ; Set error number and handle
            sta ERRNUM

ERROR   .proc
            lda #$00
            cld
            sta DSPFLG
            jsr SAVSTOPLN
            ldy TRAPLN+1
            bmi ERR_NOTRAP
            lda TRAPLN
            ldx #$80
            stx TRAPLN+1
            ldx ERRNUM
            stx ERRSAVE
            ldx #$00
            stx ERRNUM
            jmp GTO_LINE

ERR_NOTRAP  lda ERRNUM          ; ERRM1 in BASIC sources
            cmp #$80
            bne ERR_PRINT
            jmp X_STOP
ERR_PRINT   jsr PUTEOL
            lda #TOK_ERROR
            jsr IPRINTSTMT
            ldx ERRNUM
            lda #$00
            jsr PUT_AX
            lda ERRNUM
            cmp #$1F            ; Last TBXL error is 30 ($1E)
            bcc @+
            sbc #$62            ; I/O error, subtract the gap
@           sta SCANT
            cmp #$4C            ; We know 76 errors in the table
            bcs PLNUM
            ldx #$00
            lda #>ERRTAB
            ldy #<ERRTAB
            jsr STR_TABN
            jsr P_SPCSTR        ; Print SPC + string + SPC
PLNUM       ldy #$01            ; ERRM2 in BASIC sources
            lda (STMCUR),Y
            bmi ERR_NOLN
            lda #<ERRTAB
            ldy #>ERRTAB
            jsr P_STRB_AY
            ldy #$01
            lda (STMCUR),Y
            sta FR0+1
            dey
            lda (STMCUR),Y
            sta FR0
            jsr PRINUM
ERR_NOLN    jsr PUTEOL          ; ERRDONE in BASIC sources
            jsr X_TRACE.TRACE_OFF
            jmp SYN_START

        .endp

; vi:syntax=mads
