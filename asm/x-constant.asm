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

            ; %0 : load number 0
X_N0        lda #$00
            tay
            beq X_TF
            ; %3 : load number 3
X_N3        ldy #$03
            .byte $2C   ; Skip 2 bytes
            ; %2 : load number 2
X_N2        ldy #$02
            lda #$40
            bne X_TF
            ; %1 : Load number 1
X_N1        lda #$40
X_TI        ldy #$01
X_TF        inc ARSLVL
            ldx ARSLVL
            sta ARGSTK0,X
            tya
            sta ARGSTK1,X
            lda #$00
            sta VARSTK0,X
            sta ARGSTK2,X
            sta ARGSTK3,X
            sta ARGSTK4,X
            sta ARGSTK5,X
            rts

X_SGN       ldx ARSLVL
            dec ARSLVL
            lda ARGSTK0,X
            asl
            beq X_N0
            lda #$80
            ror
            bne X_TI

; vi:syntax=mads
