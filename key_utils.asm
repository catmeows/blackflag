	.MODULE key_utils

wait_nokey
	;wait until no key is pressed
	push af
_wait1
	call key_q
	jr nz, wait1
	pop af
	ret

wait_key
	;wait for key
	push af
_wait2
	call key_q
	jr z, _wait2
	pop af
	ret
key_q
	;check keys and return
	push bc
	ld bc, 254
	in a, (c)
	and %00011111
	cp 31
	pop bc
	ret
		
get_keys
	;return collected keys
	push ix
	push bc
	push de
	ld de, 3
	ld hl, 8
_get_keys2
	ld c, (ix + 0)
	ld b, (ix + 1)
	in a, (bc)
	and (ix + 2)	
	jr nz, _get_keys1
	scf
_get_keys1
	ccf
	rl l
	add ix, de
	dec h
	jr nz, _get_keys2
	pop de
	pop bc
	pop ix
	ret

key_data
	.BYTE 0,0,0	
	.BYTE 0,0,0	
        .BYTE 0,0,0
	.BYTE 0,0,0	
	.BYTE 0,0,0		