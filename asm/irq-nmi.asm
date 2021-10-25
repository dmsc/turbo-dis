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

NMI_PROC .proc
            bit NMIST   ; 37
            bpl @+
            jmp (VDSLST)
@           pha
            txa
            pha
            lda #>NMI_END
            pha
            lda #<NMI_END
            pha
            tsx
            lda $100 + 5,X
            pha
            cld
            pha
            txa
            pha
            tya
            pha
            inc PORTB
            sta NMIRES
            jmp (VVBLKI)
        .endp

IRQ_PROC .proc
            pha ; 14
            lda #>IRQ_END
            pha
            lda #<IRQ_END
            pha
            php
            inc PORTB
            jmp (VIMIRQ)
        .endp

; vi:syntax=mads
