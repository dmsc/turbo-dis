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

X_CONT      ldy #$01
            lda (STMCUR),Y
            bpl SETDZ
            lda STOPLN
            sta TSLNUM
            lda STOPLN+1
            sta TSLNUM+1
            jsr SEARCHLINE
            ldy #$02
            lda (STMCUR),Y
            sta LLNGTH
            pla
            pla
            jmp NEXT_LINE

; vi:syntax=mads
