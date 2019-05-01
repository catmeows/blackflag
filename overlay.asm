	.MODULE overlay

cold_start
	call _set_im2		;set im 2	
	;call _tune		;play song   - TODO
	call print_init		;setup print
	call _set_controls	;select controls
	call _check_ay		;check ay  - TODO
	jp start

_set_im2
	ld hl, im2_table
	ld bc, 257
	ld e, $A0
_set_im2a
	ld (hl), e
	inc hl
	dec bc
	ld a, b
	or c
	jr nz, _set_im2a
	di
	ld a, $FD
	ld i, a
	im 2
	ei
	ret 

_set_controls
	ld a, 1
	call cls		;cls
	ld hl, _text
	call print_hl		;print menu
	ld e, 56		;multicolor title	
_set_controls2
	ld b, 11
	ld hl, 22528 + 256 +5
_set_controls1
	ld (hl), e
	inc l
	ld (hl), e
	inc l
	djnz _set_controls1
	ld a, e			;change title color
	xor 64
	ld e, a
	call key_q		;check keys
	jr z, _set_controls2	;loop if no keys
	ld bc, $F7FE		;keys 5..1
	in a, (c)
	and %00011111
	cp 15			; '5' pressed ?
	ret z
	cp 30			; '1' pressed ?
	jr nz, _set_controls2	; if not, loop
	xor a
	call cls
	ld hl, _controls	;texts
	ld ix, key_data		;key data
	ld b, 5
_set_controls5
	push bc			;save loop count
	push ix			;save key data	
	call print_hl		;print text for a key
	call wait_nokey		;be sure nothing is pressed now
	
	ld bc, $FEFE		;set port
_set_controls4
	in a, (c)		;read five keys
	and 31
	cp 31
	jr nz, _set_controls3	;pressed ?
	rrc b			;try next five keys
	jr _set_controls4
_set_controls3
	xor 31			;reverse 5 lower bits
	pop ix			;restore key data
	ld (ix + 0), c		;store port		
	ld (ix + 1), b
	ld (ix + 2), a		;and key mask
	ld de, 3
	add ix, de		;move to next key data record
	pop bc			;restore loop counter
	djnz _set_controls5	;next key
	jr _set_controls	;back to menu

_check_ay
	
_text
        ;      01234567890123456789012
	.BYTE 22,8,6
	.BYTE "B L A C K    F L A G"
	.BYTE 22,11,9,16,70
	.BYTE "1 REDEFINE KEYS"
	.BYTE 22,12,9,16,70
	.BYTE "5 START GAME"
	.BYTE 22,15,7,16,1
	.BYTE "CATMEOWS 2018-2019", 255 

_controls
	.BYTE 22,12,5,16,70
	.BYTE "PRESS A KEY FOR UP   ", 255 
	.BYTE 22,12,5,16,70
	.BYTE "PRESS A KEY FOR DOWN ", 255
	.BYTE 22,12,5,16,70
	.BYTE "PRESS A KEY FOR LEFT ", 255
	.BYTE 22,12,5,16,70
	.BYTE "PRESS A KEY FOR RIGHT", 255
	.BYTE 22,12,5,16,70
	.BYTE "PRESS A KEY FOR FIRE ", 255


