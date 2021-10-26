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

X_GRAPHICS  ldx #$06
            stx IODVC   ; Use IO Channel #6
            jsr CLSYSD  ; Close device
            jsr GETINT
            ldx #<DEV_S_
            ldy #>DEV_S_
            stx INBUFF
            sty INBUFF+1
            ldx #$06
            and #$F0
            eor #$1C    ; Get AUX1 from BASIC mode
            tay
            lda FR0     ; And AUX2
            jsr CIO_OPEN
            jmp IOTEST

; vi:syntax=mads
