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