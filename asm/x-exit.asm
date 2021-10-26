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

X_EXIT  .proc
            jsr X_POP
            bcs ERR_26
            bne @+
            lda #TOK_FOR
@           tax
            inx ; Search "NEXT" if "FOR", "WEND" if "WHILE", "LOOP" if "DO",
                ; "UNTIL" if "REPEAT"
            jmp SKIP_STMT
        .endp

; vi:syntax=mads
