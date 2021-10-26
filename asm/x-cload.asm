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

X_CSAVE .proc
            lda #$08    ; OUTPUT mode
            jsr X_CLOAD.DEV_C_OPEN
            jmp X_SAVE.DO_SAVE
        .endp

X_CLOAD .proc
            lda #$04
            jsr DEV_C_OPEN
            lda #$00
            jmp X_LOAD.DO_LOAD

DEV_C_OPEN  pha
            ldx #<DEV_C_
            stx INBUFF
            ldx #>DEV_C_
            stx INBUFF+1
            ldx #$07
            pla
            tay
            lda #$80
            jsr CIO_OPEN
            jsr IOTEST
            lda #$07
            rts
        .endp

; vi:syntax=mads
