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

        ; Load and run file: RUN "..."
X_LOAD_RUN  lda #$FF
            .byte $2C   ; Skip 2 bytes

        ; LOAD file
X_LOAD  .proc
            lda #$00
            pha
            lda #$04    ; INPUT mode
            jsr ELADVC
            pla
DO_LOAD     pha
            lda #ICGETCHR
            sta IOCMD
            sta LOADFLG
            jsr LDDVX
            ldy #$0E
            jsr CIOV_LEN_Y
            jsr IOTEST
            lda LBUFF
            ora LBUFF+1
            bne LDFER
            ldx #STARP
LD1         clc
            lda LOMEM
            adc LBUFF-$80,X
            tay
            lda LOMEM+1
            adc LBUFF-$80+1,X
            cmp MEMTOP+1
            bcc LC321
            bne LC31E
            cpy MEMTOP
            bcc LC321
LC31E       jmp ERR_19
LC321       sta $01,X
            sty $00,X
            dex
            dex
            cpx #VNTP
            bcs LD1
            jsr X_SAVE.LSBLK   ; LOAD user area
            jsr X_CLR
            lda #$00
            sta LOADFLG
            pla
            beq J_SNX1  ; LD4 in BASIC sources
            rts
J_SNX1      jmp SNX1

LDFER       lda #$00
            sta LOADFLG
            jmp ERR_21
        .endp

; vi:syntax=mads
