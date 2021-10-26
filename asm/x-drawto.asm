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

X_FILLTO    lda #$12
            .byte $2C   ; Skip 2 bytes
X_DRAWTO    lda #$11
            pha
            jsr X_POSITION
            lda COLOR
            sta ATACHR
            ldx #$60
            lda #$0C
            sta IOCB0+ICAX1,X
            lda #$00
            sta IOCB0+ICAX2,X
            pla
            jmp CIOV_COME

; vi:syntax=mads
