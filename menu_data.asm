	.MODULE menu_data

intro	.BYTE 4			;x
	.BYTE 4			;y
	.BYTE 4			;left
	.BYTE 28		;right
	.WORD msg_intro 	;text
	.BYTE 2
	.WORD msg_no_thanks	;not thanks
	.WORD msg_yes		;yes

period	.BYTE 4	
	.BYTE 4
	.BYTE 4
	.BYTE 28
	.WORD msg_select_period
	.BYTE 6
	.WORD msg_empire, msg_merchants, msg_colonists, msg_war, msg_heroes, msg_sunset

role1560
	.BYTE 4, 4, 4, 28
	.WORD msg_areyouan
	.BYTE 3
	.WORD msg_eseahawk, msg_fcorsair, msg_srenegade

role1600
	.BYTE 4, 4, 4, 28
	.WORD msg_areyouan
	.BYTE 4
	.WORD msg_eexplorer. msg_fadventurer, msg_dtrader, msg_srenegade


