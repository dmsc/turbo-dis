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

        ; Parsing terminal failed
FAIL    .proc
            inc CPC
            bne @+
            inc CPC+1
@           ldx #$00
            lda (CPC,X)
            bmi FAIL
            cmp #$03
            beq POP_SYN
            bcs FAIL
            lda CIX
            cmp LLNGTH
            bcc @+
            sta LLNGTH  ; Store maximum input position
@           ldx OPSTKX
            lda SIX,X
            sta CIX
            lda SOX,X
            sta COX
            jmp NEXT
        .endp

; vi:syntax=mads
