	.MODULE key_utils

wait_nokey
	;wait until no key is pressed
	push af
_wait1
	call key_q
	jr nz, _wait1
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
	;return collected keys - bit is set if key presssed
	;order is up, down, left, right, fire
	push ix
	push bc
	push de
	push hl
	ld ix, key_data
	ld de, 3
	ld hl, $500
_get_keys2
	ld c, (ix + 0)
	ld b, (ix + 1)
	in a, (c)			;read port
	and (ix + 2)		;mask bit
	jr nz, _get_keys1	;NZ if not pressed, Z if pressed
	scf					;set bit if pressed, otherwise will go with carry=0 as result of AND 
_get_keys1
	rl l				;collect bit
	add ix, de			;move to next key
	dec h
	jr nz, _get_keys2
	ld a, l
	pop hl
	pop de
	pop bc
	pop ix
	ret

key_data
	.BYTE $FE,$FB,$01	;here is port HI LO, and mask for bit key
	.BYTE $FE,$FD,$01   ;predefined keys: QAOPM	
    .BYTE $FE,$DF,$02
	.BYTE $FE,$DF,$01	
	.BYTE $FE,$7F,$04		