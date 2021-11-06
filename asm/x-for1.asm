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

        ; First part of FOR statement
X_FOR   .proc
            sty ONLOOP
            lda (STMCUR),Y
            bne LF3C8
            iny
            lda (STMCUR),Y
LF3C8       eor #$80
            sta L00C7
            jsr EXEXPR
            ldx TOPRSTK
            stx TEMPA
            ldx TOPRSTK+1
            stx TEMPA+1
LF3D7       jsr X_POP
            bcs LF3E8
            bne LF3E8
            ldy #$0C
            lda (TOPRSTK),Y
            cmp L00C7
            bne LF3D7
            beq LF3F0
LF3E8       lda TEMPA
            sta TOPRSTK
            lda TEMPA+1
            sta TOPRSTK+1
LF3F0       lda #$0D
            jsr REXPAND
            jsr GETFP
            ldy #$00    ; FLIM in basic sources
            jsr MV6RS   ; Store limit to run-time stack
            jsr T_FLD1
            ldx STINDEX
            inx
            cpx NXTSTD
            bcs NSTEP
            jsr GETFP
NSTEP       ldy #$06    ; FSTEP in BASIC sources
            jsr MV6RS   ; Store step to run-time stack
            lda F_FOR   ; Check *F flag
            bne FOR_TSTSKIP     ; IF set, test if we need to skip the FOR body
PUSH        lda L00C7
            ldy #$0C
            sta (TEMPA),Y
            lda #$00
            beq X_GS.GS1
        .endp

; vi:syntax=mads
