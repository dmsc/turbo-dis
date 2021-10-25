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

X_USR   .proc
            jsr DO_USR
            jsr T_IFP
            jmp X_PUSHVAL

DO_USR      lda #>(DISROM-1)
            pha
.if (<(DISROM-1)) != (>(DISROM-1))
            lda #<(DISROM-1)
.endif
            pha
            lda COMCNT
            sta L00C6
USR_NARG    jsr X_POPINT
            dec L00C6
            bmi USR_OK
            lda FR0
            pha
            lda FR0+1
            pha
            jmp USR_NARG
USR_OK      inc PORTB
            lda COMCNT
            pha
            jmp (FR0)
        .endp

; vi:syntax=mads
