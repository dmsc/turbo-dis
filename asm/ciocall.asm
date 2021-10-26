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

; Close System Device
CLSYSD      jsr LDDVX
            beq X_GET.RTS94   ; Don't close device 0
IO_CLOSE    lda #ICCLOSE
            jmp CIOV_COM

; Multiple ways to call CIOV
CIOV_LEN_FF ldy #$FF
CIOV_LEN_Y  lda #$00
CIOV_LEN_AY sta IOCB0+ICBLH,X
            tya
            sta IOCB0+ICBLL,X
CIOV_NOLEN  lda INBUFF+1
            ldy INBUFF
            sta IOCB0+ICBAH,X
            tya
            sta IOCB0+ICBAL,X
CIOV_IOCMD  lda IOCMD
CIOV_COM    sta IOCB0+ICCOM,X
            jmp B_CIOV

; vi:syntax=mads
