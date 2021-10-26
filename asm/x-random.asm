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

X_RNDFN     dec ARSLVL

X_RND   .proc
            lda #$3F
            sta FR0
            ldx #$05
LDA8C       lda RANDOM
            and #$F0
            cmp #$A0
            bcs LDA8C
            sta FR1
LDA97       lda RANDOM
            and #$0F
            cmp #$0A
            bcs LDA97
            ora FR1
            sta FR0,X
            dex
            bne LDA8C
            jsr NORMALIZE
            jmp X_RET_FP
        .endp

X_RAND      jsr X_RND
            jsr X_FMUL
            jmp X_INT

; vi:syntax=mads
