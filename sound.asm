	.MODULE sound

ay_on	.BYTE 0


beep_fx1
		push af
		push bc
		ld bc, $8080
		ld a, 16
_bfx1		
		out (254), a
		djnz _bfx1
        xor 16
		ld b, c
		inc c
		jr nz, _bfx1
		pop bc
		pop af
		ret
		
beep_fx2
		push af
		push bc
		push hl
		ld hl, $61d0
		ld c, 1
_bfx2
		ld a, (hl)
		and 16
		out (254), a
		push hl
		dec hl
		dec hl
		dec hl
		dec hl
		ld a, (hl)
		and 16
		out (254), a
		pop hl
		ld b, c
_bfx2a
		djnz _bfx2a
		inc c
		inc l
		jr nz, _bfx2
		pop hl
		pop bc
		pop af
		ret