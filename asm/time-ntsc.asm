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


; Detects NTSC and patches the code
TIME_NTSC .proc

            ; Detect PAL or NTSC ANTIC by reading the max VCOUNT value
            dec PORTB
            lda #0
@
            sta FR0
            lda VCOUNT
            cmp FR0
            bcs @-

            ; FR0 = 155 PAL, 130 NTSC
            lda FR0
            cmp #135
            bcs RET

            ; We have NTSC ANTIC, patch TIME$ functions:
            ldx #5

@
            ; Change 4320000 to 5184000
            lda JF_DAY_N, x
            sta JF_DAY, x
            ; Change jsr MUL5 ; jsr MUL10 into jsr MUL60; nop; nop; nop
            lda P_NTSC, x
            sta X_TIMESET.PATCH_NTSC, x
            dex
            bpl @-
            bmi RET

JF_DAY_N    .fl 5184000
P_NTSC      jsr X_TIMESET.TS_MUL60
            nop
            nop
            nop

RET
            inc PORTB
        .endp

; vi:syntax=mads
