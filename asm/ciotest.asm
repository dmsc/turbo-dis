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

; Check CIO return for errors
IOTEST      jsr LDDVX
            lda IOCB0+ICSTA,X
; Check CIO error number from return
CIOERR_A .proc
            bpl X_GET.RTS94
            ldy #$00
            sty DSPFLG
            cmp #$80
            bne SIO1
            sty BRKKEY
            ldx LOADFLG
            beq X_GET.RTS94
            jmp COLDSTART

SIO1        ldy IODVC
            cmp #$88
            beq SIO4
SIO2        sta ERRNUM
            cpy #$07
            bne SIO3
            jsr CLSYSD
SIO3        jsr SETDZ
            jmp ERROR

SIO4        cpy #$07
            bne SIO2
            ldx #EPCHAR
            cpx PROMPT
            bne SIO2
            jsr CLSYSD
            jmp SNX2
        .endp

; vi:syntax=mads
