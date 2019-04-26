

; MEMORY MAP
;
;
; 0x6100 (24832)
;
;
; 0xFD00 (64768) - im 2 257B table
; 0xFE01 (65025) - delz 32B buffer for picture depacking
; 0xFE40 (65088) - screen line 448B table
; 






















	.ORG $FD00
im2_table

	.ORG $FE01
delz_buffer
	
	.ORG $FE40
scr_line_tab
	.BYTE 0