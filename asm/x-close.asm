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

; Close all IO channels
CLSALL  .proc
            lda #$00
            ldx #$07
LC538       sta AUDF1,X
            dex
            bpl LC538
            ldy #$07
            sty IODVC
LC542       jsr CLSYSD
            dec IODVC
            bne LC542
            rts
        .endp

X_CLOSE     iny
            cpy NXTSTD
            bcs CLSALL
            lda #ICCLOSE
; General device I/O call
GDVCIO      sta IOCMD
            jsr GETIOCHAN
GDIO1       jsr CIOV_IOCMD
            jmp IOTEST

; vi:syntax=mads
