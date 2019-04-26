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
        ret