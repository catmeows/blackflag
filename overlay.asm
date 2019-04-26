
	call set_im2		;set im 2	
	call tune		;play song
	call set_controls	;select controls
	jp start

set_im2
	ld hl, im2_table
	ld bc, 257
	ld a, $A0
set_im2a
	ld (hl), a
	inc hl
	dec bc
	ld a, b
	or c
	jr nz, set_im2a
	di
	ld a, $FD
	ld i, a
	im 2
	ei
	ret 

set_controls




