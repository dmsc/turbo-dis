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
            lda (L0099),Y
            bne @+
            iny
            lda (L0099),Y
@           eor #$80
            jsr VAR_PTR
            txa
            cmp (WVVTPT),Y
            beq GEN_LNHASH.HSH_CONT
            sta (WVVTPT),Y
            lda L0099
            ldy #$02
            sta (WVVTPT),Y
            iny
            lda L009A
            sta (WVVTPT),Y
            jmp GEN_LNHASH.HSH_CONT
        .endp

; Buils line number hash table and fills PROC/#LABEL addresses.
GEN_LNHASH .proc
            lda L0099
            pha
            lda L009A
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
            sta L009A
            lda STMTAB
HSH_NXT     sta L0099
            ldy #$04
            lda (L0099),Y
            cmp #TOK_PROC
            beq SETV_PROC
            cmp #TOK_PND
            beq SETV_LBL
HSH_CONT    ldy #$01
            lda (L0099),Y
            asl
            bcs HSH_EPROC
            tay
            lda (LOMEM),Y
            bne HSH_DONE  ; Skip already hashed
            ; Store address of line into hash
            lda L009A
            sta (LOMEM),Y
            iny
            lda L0099
            sta (LOMEM),Y
HSH_DONE    clc
            ldy #$02
            lda (L0099),Y
            adc L0099
            bcc HSH_NXT
            inc L009A
            bcs HSH_NXT
            ; Now, we fill remaining hashes with available lines
HSH_EPROC   lda STMTAB
            sta L0099
            lda STMTAB+1
            sta L009A
            ldy #$00
HSH_FILL    lda (LOMEM),Y
            bne LCA24
            lda L009A
            sta (LOMEM),Y
            iny
            lda L0099
            sta (LOMEM),Y
            jmp LCA2B
LCA24       sta L009A
            iny
            lda (LOMEM),Y
            sta L0099
LCA2B       iny
            bne HSH_FILL
            pla
            sta L009A
            pla
            sta L0099
            rts
        .endp

ERR_30 .proc
            lda #$1E
            jmp SERROR
        .endp

; vi:syntax=mads
