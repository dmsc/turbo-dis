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

X_PUSH_ERR11
            bcs ERR_11

X_PUSH_ERR3
            bcs ERR_3

        ; "ARGPUSH" in Atari BASIC: Push FR0 to Argument Stack
X_PUSHVAL   inc ARSLVL
            ldy ARSLVL
            cpy #$20
            bcs ERR_10
            lda FR0+5
            sta ARGSTK5,Y
            lda FR0+4
            sta ARGSTK4,Y
            lda FR0+3
            sta ARGSTK3,Y
            lda FR0+2
            sta ARGSTK2,Y
            lda FR0+1
            sta ARGSTK1,Y
            lda FR0
            sta ARGSTK0,Y
            lda VNUM
            sta VARSTK1,Y
            lda VTYPE
            sta VARSTK0,Y
            rts

; vi:syntax=mads
