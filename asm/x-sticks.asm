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

X_PADDLE    lda #$00
            beq X_GRF

X_STICK     lda #$08
            bne X_GRF

X_PTRIG     lda #$0C
            bne X_GRF

X_STRIG     lda #$14
X_GRF       sta L00EC
            jsr X_POPINT
            bne ERR_3B
            cmp #$08
            bcs ERR_3B
            adc L00EC
            tax
            lda PADDL0,X
X_RET_A     ldy #$00
            jmp X_RET_AY

ERR_3B      jmp ERR_3

; vi:syntax=mads
