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

X_FRAC  .proc
            jsr X_POPVAL
            lda FR0
            and #$7F
            sec
            sbc #$40
            bcc INCRET
            tax
            lda #$00
            cpx #$05
            bcc LDAD6
            ldx #$04
LDAD6       sta FR0+1,X
            dex
            bpl LDAD6
            jsr NORMALIZE
            jmp X_PUSHVAL
INCRET      inc ARSLVL
            rts
        .endp

; vi:syntax=mads
