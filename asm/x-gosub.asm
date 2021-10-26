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

ERRLNUM     jsr RESCUR
            lda #$0C
            jmp SERROR

X_GOSUB     jsr X_GS    ; Save return address and skip to X_GOTO

X_GOTO      jsr GETUINT
GTO_LINE    sta TSLNUM
            sty TSLNUM+1
            jsr SEARCHLINE
            bcs ERRLNUM
            pla
            pla
            lda BRKKEY
            beq EXECNL.GO_CHK_BRK

; vi:syntax=mads
