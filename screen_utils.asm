	.MODULE scr_utils

cls
	;clear screen with color in A
	ld hl, 16384
	ld de, 16385
	ld bc, 6144
	ld (hl), 0
	ldir
	ld (hl), a
	ld bc, 767
	ldir
    ret
	
gen_line_table
	;generate line table
	;top 16 and bottom 16 lines points to ROM to allow clipping
	ld hl, scr_line_tab
	call _gen_tab1
	ld b, 192
	ld de, 16384
_gen_tab3
	ld (hl), e
	inc hl
	ld (hl), d
	inc hl
	call de_down
	djnz _gen_tab3
_gen_tab1
	ld b, 32
	xor a
_gen_tab2
	ld (hl), a
	inc hl
	djnz _gen_tab2
	ret

de_down
	inc d
	ld a, d
	and 7
	ret nz
	ld a, e
	add a, 32
	ld e, a
	ret c
	ld a, d
	sub 8
	ld d, a
	ret



	