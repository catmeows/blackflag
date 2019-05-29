	.MODULE menu_data
		
_msg_welcome 	.EQU 0
_msg_nothanks 	.EQU 1
_msg_yes		.EQU 2

m_intro		.BYTE 4			;y
			.BYTE 2			;x
			.BYTE 2			;left margin
			.BYTE 28		;right margin
			.WORD _msg_welcome 	;text
			.BYTE 2				;2 options:
			.WORD _msg_nothanks	;not thanks
			.WORD _msg_yes		;yes
			
_msg_period		.EQU 3
_msg_empire		.EQU 4
_msg_merchants	.EQU 5
_msg_colonists  .EQU 6
_msg_war		.EQU 7
_msg_heroes		.EQU 8
_msg_sunset		.EQU 9			

m_period	.BYTE 4	
			.BYTE 0
			.BYTE 0
			.BYTE 31
			.WORD _msg_period
			.BYTE 6
			.WORD _msg_empire, _msg_merchants, _msg_colonists, _msg_war, _msg_heroes, _msg_sunset

_msg_areuan		.EQU 10
_msg_ehawk		.EQU 11
_msg_fcorsair	.EQU 12
_msg_srenegade	.EQU 13
_msg_eexplorer	.EQU 14
_msg_fadventur	.EQU 15
_msg_dtrader	.EQU 16
_msg_eadventur	.EQU 17
_msg_huguenot	.EQU 18
_msg_dprivat	.EQU 19
_msg_fprivat	.EQU 20
_msg_ebuccan	.EQU 21
_msg_fbuccan	.EQU 22
_msg_dadventur	.EQU 23
_msg_epirate	.EQU 24

m_1560		.BYTE 4, 2, 2, 28
			.WORD _msg_areuan
			.BYTE 3
			.WORD _msg_ehawk, _msg_fcorsair, _msg_srenegade
			.WORD 0 ;padding
			.BYTE 0
			
m_1600		.BYTE 4, 2, 2, 28
			.WORD _msg_areuan
			.BYTE 4
			.WORD _msg_eexplorer, _msg_fadventur, _msg_dtrader, _msg_srenegade
			.BYTE 0

m_1620		.BYTE 4, 2, 2, 28
			.WORD _msg_areuan
			.BYTE 4
			.WORD _msg_eadventur, _msg_huguenot, _msg_dprivat, _msg_srenegade
			.BYTE 0

m_1640		.BYTE 4, 2, 2, 28
			.WORD _msg_areuan
			.BYTE 4
			.WORD _msg_eadventur, _msg_fprivat, _msg_dtrader, _msg_srenegade 
			.BYTE 0

m_1660		.BYTE 4, 2, 2, 28
			.WORD _msg_areuan
			.BYTE 4
			.WORD _msg_ebuccan, _msg_fbuccan, _msg_dadventur, _msg_srenegade
			.BYTE 0

m_1680		.BYTE 4, 2, 2, 28
			.WORD _msg_areuan
			.BYTE 4
			.WORD _msg_epirate, _msg_fbuccan, _msg_dadventur, _msg_srenegade	



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


