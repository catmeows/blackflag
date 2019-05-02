	.MODULE "menu"


menu
	;IX menu structure
	; BYTE x
	; BYTE y
	; BYTE left
	; BYTE right 
	; WORD text
	; BYTE options count
	; n * WORD
	ld l, (ix + 0)		;setup print - x
	ld h, (ix + 1)		;y
	ld (_menu_at + 1), hl
	ld a, (ix + 2)		;left
	ld (_menu_at + 4), a
	inc a			;indent by 2
	inc a
	ld (_menu_indent + 1), a
	ld a, (ix + 3)		;right
	ld (_menu_at + 5), a
	ld hl, _menu_at
	call print_hl		
	ld hl, print_char	;set callback
	ld c, (ix + 4)		;get message id
	ld b, (ix + 5)
	call depack_text	;print text
	ld hl, _menu_indent	;print indent 
	call print_hl
	call print_getpos	;get position for cursor
	dec c
	push bc	
	ld b, (ix + 6)
_menu1
	push bc			;print menu items
	ld hl, print_char
	ld c, (ix + 7)		;get item msg id
	ld b, (ix + 8)
	call depack_text	;print item
	ld a, 13		
	call print_char		;print EOL
	inc ix			;next item
	inc ix
	pop bc
	djnz _menu1


			


_menu_at 
	.BYTE 22, 0, 0, 24, 0, 25, 0, 16, 120, 255

_menu_indent
	.BYTE 24, 0, 13, 255