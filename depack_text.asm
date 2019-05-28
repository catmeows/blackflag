	.MODULE depack_text
	
	;test: 4800 chars packed to 2079 bytes + 512 bytes dictionary -> 54% i.e. 4.3 bits per character

depack_text
	;HL callback
	;BC message id

	ld (_callback + 1), hl	;set callback

	ld hl, messages
	inc bc			;add one 
_find1
	dec bc			;decrease one
	ld a, b
	or c
	jr z, _depack		;message found ?
_find2
	ld a, (hl)		;scan for next message end
	inc hl
	cp 255
	jr nz, _find2
	jr _find1		;when found decrease message counter
_depack	
	ld a, (hl)		;get code
	cp 255			;end of message ?
	ret z			;leave
	push hl
	call _decode
	pop hl
	inc hl
	jr _depack

_decode	
	ld c, a
	ld b, 0
	ld hl, dictionary			
	add hl, bc
	add hl, bc		;find code in dictionary
	ld a, (hl)		;get first
	cp 255			;is it leaf?
	jr nz, _decode1
	inc hl
	ld a, (hl)		;get literal
_callback	
	jp 0			;apply callback
_decode1
	push hl			;not a leaf
	call _decode		;decode first (recursion)
	pop hl			
	inc hl
	ld a, (hl)
	jp _decode		;decode second (recursion) and leave		
	

