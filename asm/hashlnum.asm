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

; Store into variable table the line address of the PROC or #LABEL.
SETV_PROC   lda #EVLABEL + EVL_EXEC
            .byte $2C   ; Skip 2 bytes
SETV_LBL .proc
            lda #EVLABEL + EVL_GOS
            tax
            iny
            lda (MVFA),Y
            bne @+
            iny
            lda (MVFA),Y
@           eor #$80
            jsr VAR_PTR
            txa
            cmp (WVVTPT),Y
            beq GEN_LNHASH.HSH_CONT
            sta (WVVTPT),Y
            lda MVFA
            ldy #$02
            sta (WVVTPT),Y
            iny
            lda MVFA+1
            sta (WVVTPT),Y
            jmp GEN_LNHASH.HSH_CONT
        .endp

; Buils line number hash table and fills PROC/#LABEL addresses.
GEN_LNHASH .proc
            lda MVFA    ; Store MVFA in stack to reuse here.
            pha         ; NOTE: this should not be necessary, as it is not used
            lda MVFA+1  ;       from any context that calls this.
            pha

            ; Start filling with zeroes
            lda #$00
            tay
HSH_CLR     sta (LOMEM),Y
            iny
            iny
            bne HSH_CLR
            ; Iterate through all program lines
            lda STMTAB+1
            sta MVFA+1
            lda STMTAB
HSH_NXT     sta MVFA
            ldy #$04
            lda (MVFA),Y
            cmp #TOK_PROC
            beq SETV_PROC
            cmp #TOK_PND
            beq SETV_LBL
HSH_CONT    ldy #$01
            lda (MVFA),Y
            asl
            bcs HSH_EPROC
            tay
            lda (LOMEM),Y
            bne HSH_DONE  ; Skip already hashed
            ; Store address of line into hash
            lda MVFA+1
            sta (LOMEM),Y
            iny
            lda MVFA
            sta (LOMEM),Y
HSH_DONE    clc
            ldy #$02
            lda (MVFA),Y
            adc MVFA
            bcc HSH_NXT
            inc MVFA+1
            bcs HSH_NXT
            ; Now, we fill remaining hashes with available lines
HSH_EPROC   lda STMTAB
            sta MVFA
            lda STMTAB+1
            sta MVFA+1
            ldy #$00
HSH_FILL    lda (LOMEM),Y
            bne LCA24
            lda MVFA+1
            sta (LOMEM),Y
            iny
            lda MVFA
            sta (LOMEM),Y
            jmp LCA2B
LCA24       sta MVFA+1
            iny
            lda (LOMEM),Y
            sta MVFA
LCA2B       iny
            bne HSH_FILL
            pla
            sta MVFA+1
            pla
            sta MVFA
            rts
        .endp

ERR_30 .proc
            lda #$1E
            jmp SERROR
        .endp

; vi:syntax=mads
