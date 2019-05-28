

; MEMORY MAP
;
;
; 0x6100 (24832) - packed texts
;
;
; 0xA0A0 (41120) - im 2 handler
; 0xFD00 (64768) - im 2 257B table
; 0xFE01 (65025) - delz 32B buffer for picture depacking
; 0xFE40 (65088) - screen line 448B table


	.ORG $6100
	#INCLUDE "messages.asm"


	.ORG $A0A0
	;im 2 handler
	di
	push af
	push de
	push hl
	ld hl, (time)
	ld a, (time + 2)
	ld de, 1
	add hl, de
	adc a, 0
	ld (time), hl
	ld (time + 2), a
	pop hl
	pop de
	pop af
	ei
	ret
time
	.BYTE 0, 0, 0

	#INCLUDE "print.asm"

	#INCLUDE "font.asm"

	#INCLUDE "screen_utils.asm"

	#INCLUDE "key_utils.asm"

	#INCLUDE "depack_text.asm"
	
	#INCLUDE "sound.asm"

start
	call gen_line_table
	ld a, $78	;black ink, white paper, bright on
	call cls	;clear screen
	ld hl, 16
	ld bc, 0
	call depack_text
temploop
	jr temploop
test_decode
	ret







	.ORG $FD00
im2_table

	.ORG $FE01
delz_buffer
	
	.ORG $FE40
scr_line_tab
	.BYTE 0
	#INCLUDE "overlay.asm"