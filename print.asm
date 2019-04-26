	.MODULE print

print_hl
	;print zero terminated string at HL
	ld a, (hl)
	or a
	ret z
	inc hl
	push hl
	call print_char
	pop hl
	jr print_hl


print_init
	;reset print
	ld hl, 0
	ld (_print_pos), hl
	ld (_expect), hl
	ld a, 31
	ld (_print_right), a
	ret

_print_control
	; A expected
	; C parameter
	cp 16
	jr nz, _print_control1
	ld a, c
	ld (_print_color), a
_print_control_reset
	xor a
_print_control_set
	ld (_expect), a
	ret
_print_control1
	cp 22
	jr nz, _print_control2
	ld a, c
	ld (_print_pos), a
	ld a, 23
	jr _print_control_set
_print_control2
	cp 23
	jr nz, _print_control3
	ld a, c
	ld (_print_pos + 1), a
	jr _print_control_reset
_print_control3
	cp 24
	jr nz, _print_control4
	ld a, c
	ld (_print_left), a
	jr _print_control_reset
_print_control4
	ld a, c
	ld (_print_right), a
	jr _print_control_reset
	
print_char
	;print char in A
	; 16, color
	; 22, y, x 
	; 24, lx
        ; 25, rx

	ld c, a
	ld a, (_expect)
	or a
	jp nz, _print_control	;expecting parameters for control code
	cp 16			;? color
	jr nz, _print_char1
_print_expect
	ld (_expect), a		;save expected parameter and leave
	ret
_print_char1
	cp 22			;? at
	jr z, _print_expect
	cp 24			;? left margin
	jr z, _print_expect
	cp 25			;? right margin
	jr z, _print_expect
	cp 13			;? eol
	jr z, _print_eol
	
	push af
	call _print_bounds	;? to far on the right?
	pop af
	ld a, c
	sub 32			;compute font pointer
	add a, a
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	ld de, font
	add hl, de
	push hl			;store char pointer
	ld de, (_print_pos)	;compute screen pointer
	ld a, e			;get x
        ld l, a
	ld a, d
	and 7
	rrca
	rrca
	rrca
	add a, l
	ld l, a			;add (y mod 8) * 32 to lower byte
	ld a, d
	and %11000		;higher byte 
	add a, $40		;+16384
	ld h, a
	ex de, hl
	pop hl			;restore char pointer
	push de			;store screen pointer
	ld b, 8
_print_char2
	ld a, (hl)		;copy char data
	inc hl
	ld (de), a
	inc d
	djnz _print_char2
	pop de			;compute attr pointer
	ld a, d
	and %11000
	rrca
	rrca
	rrca			; y>>3 + 22528
	add a, $58		
	ld d, a	
	ld a, (_print_color)	;get color
	ld (de), a		;store color
	ld a, (_print_pos)	;x++
	inc a
	ld (_print_pos), a
	ret

_print_eol			;eol -> go line down, to left margin
	ld de, (_print_pos)
	inc d
	ld a, (_print_left)
	ld e, a
	ld (_print_pos), de
	ret

_print_bounds
	ld a, (_print_pos)
	ld c, a
	ld a, (_print_right)
	cp c
	jr c, _print_eol
	ret

_print_pos
	.BYTE 0, 0	
_expect
	.BYTE 0	 
_print_left
	.BYTE 0
_print_right
	.BYTE 0
_print_color
	.BYTE 0
