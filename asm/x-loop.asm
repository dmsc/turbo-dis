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

ERR_27      lda #$1B
            .byte $2C   ; Skip 2 bytes
ERR_25      lda #$19
            jmp SERROR

X_LOOP  .proc
            jsr X_POP
            bcs ERR_25
            cmp #TOK_DO
            bne ERR_22B
            lda #$04
            jsr RCONT
            lda #TOK_DO
            jmp RETURN
ERR_22B     jmp ERR_22
        .endp

; vi:syntax=mads
