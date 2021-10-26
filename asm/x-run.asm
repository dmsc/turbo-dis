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

X_RUN   .proc
            iny
            cpy NXTSTD
            bcs RUN_NOFILE
            jsr X_LOAD_RUN
RUN_NOFILE  lda STMTAB
            sta STMCUR
            lda STMTAB+1
            sta STMCUR+1
            lda #$00
            sta F_FOR
            sta F_BRK
            ldy #$03
            sty NXTSTD
            dey
            lda (STMCUR),Y
            sta LLNGTH
            dey
            lda (STMCUR),Y
            bmi RUNEND
            jsr RUNINIT
        .endp

; vi:syntax=mads
