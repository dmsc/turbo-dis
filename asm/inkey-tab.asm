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

; Table with scan-codes that don't produce a key
MUTED_KEYS  .byte $9A,$98,$9D,$9B,$B3,$B5,$B0,$B2
            .byte $A6,$3C,$7C,$BC,$27,$67,$A7
MUTED_KEYS_N = * - MUTED_KEYS

; vi:syntax=mads
