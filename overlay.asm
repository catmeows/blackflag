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
	call cls
	ld hl, _text
	call print_hl
	





_text
	.BYTE 22,6,6,16,0
        ;      01234567890123456789012
	.BYTE "B L A C K   F L A G"
	.BYTE 22,8,10,16,65
	.BYTE "SELECT  CONTROLS"
	.BYTE 22,11,12,16,70
	.BYTE "1 SINCLAIR",22,11,13
	.BYTE "2   CURSOR",22,11,14
	.BYTE "3    QAOPM",22,11,15
	.BYTE "4    EDUIN",22,7,17,16,2
	.BYTE "CATMEOWS 2018-2019", 0 

_controls



