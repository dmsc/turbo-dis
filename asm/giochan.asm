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

        ; Get I/O channel, or assume 0 if not present
CHKIOCHAN   lda (STMCUR),Y
            cmp #CPND
            beq GETIOCHAN
            lda #$00
            beq IOCHAN0

        ; Get I/O channel
GETIOCHAN   jsr GETINTNXT
IOCHAN0     sta IODVC

        ; Load X with I/O channel times 16
LDDVX       lda IODVC
            asl
            asl
            asl
            asl
            tax
            bpl X_GET.RTS94
            lda #$14
            jmp SERROR

; vi:syntax=mads
