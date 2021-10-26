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

X_CMP   .proc
            ldy OPSTKX
            lda OPSTK+1,Y
            cmp #$2F
            bcc FRCMPP
            jmp STRCMP

FRCMPP      ldy ARSLVL
            dec ARSLVL
            ldx ARSLVL
            dec ARSLVL
            lda ARGSTK0,X
            cmp ARGSTK0,Y
            bne FRCMPEXP
            asl
            bcc FRCMPPOS
            inx
            dey
FRCMPPOS    lda ARGSTK1,X
            cmp ARGSTK1,Y
            bne FRCMPEND
            lda ARGSTK2,X
            cmp ARGSTK2,Y
            bne FRCMPEND
            lda ARGSTK3,X
            cmp ARGSTK3,Y
            bne FRCMPEND
            lda ARGSTK4,X
            cmp ARGSTK4,Y
            bne FRCMPEND
            lda ARGSTK5,X
            cmp ARGSTK5,Y
FRCMPEND    rts
FRCMPEXP    ora ARGSTK0,Y
            bpl FRCMPEND
            ror
            eor #$80
            rol
            rts
        .endp

; vi:syntax=mads
