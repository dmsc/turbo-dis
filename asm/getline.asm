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

            ; Get line for input
GLINE       ldx ENTDTD
            bne GLGO
            lda PROMPT
            jsr PUTCHAR
GLGO        ldx ENTDTD
            lda #ICGETREC
            jsr GLPCX
            jsr CIOV_LEN_FF
            jmp IOTEST

; vi:syntax=mads
