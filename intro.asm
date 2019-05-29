	.MODULE intro
	
select_role
			ld ix, m_intro
			call _show_intro_menu
			or a
			ld a, 4				;NO -> select period 'buccaneer heroes'
			jr z, _skip_period
			ld ix, m_period
			call _show_intro_menu
_skip_period
			ld (_period), a		;save period
			add a, a \ add a, a \ add a, a \ add a, a
			ld hl, m_1560
			add a, l
			ld l, a
			jr nc, _skip_per1
			inc h
_skip_per1
			push hl
			pop ix
			call _show_intro_menu
			ld (_role), a
			ret
			
_show_intro_menu		
			push ix
			ld a, $78	;black ink, white paper, bright on
			call cls	;clear screen
			call print_init
			pop ix
			call menu
			ret
			
			
_period		.BYTE 0
_role		.BYTE 0			