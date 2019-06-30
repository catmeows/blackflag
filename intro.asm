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
			ld hl, m_1560		;compute adress of role menu 
			add a, l			;period*16
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
			
select_name
			ld a, $78
			call cls
			call print_init
			
_select_name_init
				
			
_select_name_enter
			
			ld a, 32
			ld (_select_name1 + 5), a
			ld hl, _select_name1
			call print_hl			;erase cursor
			call get_keys			;read key
			ld bc, (_select_name2)		;BC print position
			ld hl, (_cursor_pointer)	;HL char position	
			bit 4, a					;up ?
			jr z, _select_name_enter1
			

			
_select_name1
			.BYTE 22
_select_name2			
			.BYTE 0,0,16,121,0,255



			; A B C D E F G
			; H I J K L M N
			; O P Q R S T DEL
			; U V W X Y Z OK
_input		.BYTE "ABCDEFGHIJKLMNOPQRSTdUVWXYZo"
_name_head	.BYTE 22,0,0,16,123			;
_name		.BYTE "          "			
			.BYTE 255
_incognito	.BYTE "INCOGNITO "			
_period		.BYTE 0						;!!!TODO can be in scratchpad area
_role		.BYTE 0						;!!!TODO can be in scratchpad area
_cursor_pointer
			.WORD 0						;!!!TODO can be in scratchpad area