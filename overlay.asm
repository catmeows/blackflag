	.MODULE overlay

cold_start
	call _set_im2		;set im 2	
	call _tune		;play song
	call _set_controls	;select controls
	jp start

_set_im2
	ld hl, im2_table
	ld bc, 257
	ld a, $A0
_set_im2a
	ld (hl), a
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
	xor a
	call cls		;cls
	ld hl, _text
	call print_hl		;print menu
	ld c, 56		;multicolor title	
	ld b, 22
	ld hl, 22528 + 256 +5
_set_controls1
	ld (hl), c
	inc l
	djnz _set_controls1
	ld a, c			;change title color
	xor 64
	ld c, a
	call key_q		;check keys
	jr z, _set_control1	;loop if no keys
	





_text
	.BYTE 22,6,6,16,0
        ;      01234567890123456789012
	.BYTE 22,8,6
	.BYTE "B L A C K    F L A G"
	.BYTE 22,11,10,16,65
	.BYTE "1 REDEFINE KEYS"
	.BYTE 22,12,12,16,70
	.BYTE "5 START GAME"
	.BYTE 22,15,7,16,1
	.BYTE "CATMEOWS 2018-2019", 0 

_controls



