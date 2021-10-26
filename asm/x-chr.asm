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

X_CHRP      jsr X_POPINT
            lda FR0
            ; Return string with one character A
RET_CHRP    sta LBUFF+$40
            ldy #$01
            ; Return string with length = Y
RET_STR_LY  lda #<(LBUFF+$40)
            ; Return string with length = Y at address (LBUFF & $FF00) + A
RET_STR_A   ldx #>(LBUFF+$40)
PUSHSTR     stx FR0+1
            sta FR0
            sty FR0+2
            lda #$00
            sta FR0+3
            sta VNUM
            lda #EVSTR + EVSDTA + EVDIM
            sta VTYPE
            jmp X_PUSHVAL

; vi:syntax=mads
