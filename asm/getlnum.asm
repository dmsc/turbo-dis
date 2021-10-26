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

        ; Get typed line number
GET_LNUM .proc
            jsr T_AFP
            bcc GLNUM
GLN1        lda #$00
            sta CIX
            ldy #$80
            bmi SLNUM
GLNUM       jsr T_FPI
            bcs GLN1
            ldy FR0+1
            bmi GLN1
            lda FR0
SLNUM       sty TSLNUM+1
            sta TSLNUM
            jsr SETCODE
            lda TSLNUM+1
            sta FR0+1
            jmp SETCODE
        .endp

; vi:syntax=mads
