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

        ; This is "AAPSTR", Pop String Argument and Make Address Absolute in
        ; Atari BASIC
X_POPSTR    jsr X_POPVAL
        ; Get String Address
GSTRAD  .proc
            lda #EVSDTA
            bit VTYPE
            bne RET
            ora VTYPE
            sta VTYPE
            lsr
            bcc ERR_9
            clc
            lda FR0
            adc STARP
            sta FR0
            tay
            lda FR0+1
            adc STARP+1
            sta FR0+1
RET         rts
        .endp

; vi:syntax=mads
