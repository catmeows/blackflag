	.MODULE "menu"


menu
	;IX menu structure
	; BYTE y
	; BYTE x
	; BYTE left
	; BYTE right 
	; WORD text
	; BYTE options count
	; n * WORD
	call _setup_print
	ld hl, print_char	;set callback
	ld c, (ix + 4)		;get message id
	ld b, (ix + 5)
	call depack_text	;print text
	ld hl, _menu_indent	;print indent 
	call print_hl
	call print_getpos	;get position for cursor
	dec b
	ld (_cursor_pos), bc	;store position	
	ld b, (ix + 6)			;get menu count
	ld l, b
	dec l
	ld h, 0					;and set the first
	ld (_menu_count), hl 
_menu1
	push bc			;print menu items
	ld hl, print_char
	ld c, (ix + 7)		;get item msg id
	ld b, (ix + 8)
	call depack_text	;print item
	ld a, 'n'		
	call print_char		;print EOL
	inc ix			;next item
	inc ix
	pop bc
	djnz _menu1
_menu5
	halt			;screen sync
	ld hl, _cursor_print	;print at cursor position
	call print_hl
	ld a, 32		;clear cursor	
	call print_char
	call get_keys		;get keys
	ld hl, (_menu_count)	;get menu count and cursor select
	ld bc, (_cursor_pos)	;get cursor x and y	
	bit 3, a		;is down ?
	jr z, _menu2	
	ld a, h			;last item selected ?
	cp l
	jr z, _menu3		;don't move and draw cursor
	inc h			;update selection
	inc c			;update position
	jr _menu3x		;draw cursor
_menu2
	bit 4, a		;is up ?		
	jr z, _menu4		
	ld a, h
	or a			;first item selected ?
	jr z, _menu3		;don't move and draw cursor
	dec h			;update selection
	dec c			;update position
	jr _menu3x		;draw cursor
_menu4
	bit 0, a		;is fire ?
	jr z, _menu3		;no, draw curdor
	call beep_fx1
	ld a, (_cursor_select)	;return selection
	ret
_menu3x	
	call beep_fx2
_menu3
	ld (_menu_count), hl	;store selection
	ld (_cursor_pos), bc	;store pos
	ld hl, _cursor_print	;print at (updated?) position
	call print_hl
	ld a, '>'		;cursor
	call print_char
	call wait_nokey		;wait no key
	jr _menu5		;loop

_menu_count	    .BYTE 0
_cursor_select	.BYTE 0
_cursor_print	.BYTE 22				;print cursor
_cursor_pos	    .WORD 0					;at this position
		        .BYTE 16, 121, 255		;with this color	

_setup_print
	ld l, (ix + 0)		;setup print - y
	ld h, (ix + 1)		;x
	ld (_menu_at + 1), hl
	ld a, (ix + 2)		;left
	ld (_menu_at + 4), a
	inc a			;indent by 2
	inc a
	ld (_menu_indent + 1), a
	ld a, (ix + 3)		;right
	ld (_menu_at + 6), a
	ld hl, _menu_at
	call print_hl
	ret

_menu_at 
	.BYTE 22, 0, 0, 24, 0, 25, 0, 16, 120, 255

_menu_indent
	.BYTE 24, 0, 'n', 255
	

info
	;IX info structure
	; BYTE y
	; BYTE x
    ; BYTE left
    ; BYTE right
	; BYTE messages count
	; n * WORD 
	ld b, (ix + 4)	;get number of info screens	
	push ix
	pop hl
	ld de, 5
	add hl, de		;HL point to first screen of info
_info_loop
	push ix
	push bc
	push hl
	ld a, $78
	call cls		;init
	call print_init
	call _setup_print
	pop hl			;get message id
	ld c, (hl)
	inc hl
	ld b, (hl)
	inc hl
	push hl
	ld hl, print_char
	call depack_text	;print it
	call wait_nokey		;ensure no key is pressed
	call wait_key		;wait for key
	call beep_fx1		
	pop hl
	pop bc
	pop ix
	djnz _info_loop		;next info screen
	ret
		
	
	
	