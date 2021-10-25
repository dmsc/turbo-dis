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

; Address of relocation table
RELOC_TABLE = $5000
TBXL_RELOC_ADDR = $3000     ; Address of relocated data

            ; Perform relocation using relocation table loaded at fixed address
LOAD_END .proc
            lda #$00
            sta NMIEN
            sei
            dec PORTB

            ; Calculate new address and offset
            ldx MEMLO+1
            lda MEMLO
            beq NO_INC
            inx
NO_INC      txa
            sec
            sbc #>TBXL_RELOC_ADDR
            sta FIX_ADD+1

            ; Read relocation table and adjust all pointers
            lda #<RELOC_TABLE
            sta FR0+2
            lda #>RELOC_TABLE
            sta FR0+3
            ldx #0
            ldy #0
DO_RELOC1
            lda (FR0+2),y
            sta FR0
            iny
            lda (FR0+2),y
            sta FR0+1
            ora FR0
            beq END_RELOC

            ; Read new byte and adjust
            lda (FR0,x)
            clc
FIX_ADD
            adc #00
            sta (FR0,x)

            iny
            bne DO_RELOC1
            inc FR0+3
            bne DO_RELOC1

END_RELOC
            ; Ok, now move relocated low data to correct position
            ldy #0
            ldx #>(TOP_LOWMEM-TBXL_LOW_ADDRESS+255)

COPY_LOOP
COPY_READ
            lda TBXL_RELOC_ADDR, y
COPY_WRITE
            sta TBXL_LOW_ADDRESS, y
            iny
            bne COPY_LOOP
            inc COPY_READ+2
            inc COPY_WRITE+2
            dex
            bne COPY_LOOP

            ; Ok, all code is now relocated properly, setup IRQ vectors
            lda #>NMI_PROC
            sta NMI_VEC+1
            lda #>IRQ_PROC
            sta IRQ_VEC+1

            ; Enable interrupts again and return
            inc PORTB
            lda #$40
            sta NMIEN
            cli
            rts
        .endp

; vi:syntax=mads
