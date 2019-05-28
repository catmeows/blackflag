	.MODULE menu_data
	
msg_welcome 	.EQU 0
msg_nothanks 	.EQU 1
msg_yes			.EQU 2
msg_period		.EQU 3
msg_empire		.EQU 4
msg_merchants	.EQU 5
msg_colonists   .EQU 6
msg_war			.EQU 7
msg_heroes		.EQU 8
msg_sunset		.EQU 9

m_intro		.BYTE 4			;y
			.BYTE 2			;x
			.BYTE 2			;left
			.BYTE 28		;right
			.WORD msg_welcome 	;text
			.BYTE 2
			.WORD msg_nothanks	;not thanks
			.WORD msg_yes		;yes

m_period	.BYTE 2	
			.BYTE 4
			.BYTE 2
			.BYTE 28
			.WORD msg_period
			.BYTE 6
			.WORD msg_empire, msg_merchants, msg_colonists, msg_war, msg_heroes, msg_sunset

;role1560
;	.BYTE 4, 4, 4, 28
;	.WORD msg_areyouan
;	.BYTE 3
;	.WORD msg_eseahawk, msg_fcorsair, msg_srenegade

;role1600
;	.BYTE 4, 4, 4, 28
;	.WORD msg_areyouan
;	.BYTE 4
;	.WORD msg_eexplorer. msg_fadventurer, msg_dtrader, msg_srenegade


