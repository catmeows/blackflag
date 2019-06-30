
; 00 - REST
;
;
;
;
;
; SWEEPS
; 	127 - jump, adresss
;	128 - sustain
;	-127..126 - duty change this frame 
;	example 0,0,0,0,0,0,0,0,-1,-2,-4,-4,128
; CHORDS
;   127 - jump, adress
;   128 - sustain
;   -127..126 - change in halfnotes
;   example 3,4,-7, 127, 
; ROWS
;	duration
; 
; DRUMS - noise, decreasing pitch
;       - noise, high constant pitch
;       -
;  
  


_wham_exit
	exx
	xor a
	in a, (254)
	cpl
	and 31
	ret z			;check keys			

	ld ix, 310		; cca 40Hz update
	push ix			;will be shorter if playing drum this frame

	ld ix, _wham1note
	call _wham_doframe	;update ch1 for next frame
	
	ld ix, _wham2note
	call _wham_doframe	;update ch2 for next frame
	pop ix
	exx
_whamloop
	;takes 248T -> 14113Hz
	;CH1 - B.. duty, DE.. freq
	;CH2 - C.. duty, HL.. freq
	ld a, b			;4		
	or a			;4
	jp z, _wham1		;10
	ld a, $18		;7		25 -> 136
	out (254), a		;11
	dec b			;4
	jp _wham2		;10
				;--
				;50
_wham1
	ld a, $00		;       7
	out (254), a		;	11	11	
	nop			;	4	4
	jp _wham2		;	10	10
_wham2
	dec de			;6		6
	ld a, d			;4		4
	or e			;4		4
				;--
				;14

	jr nz, _wham3		;7      12
_whamf1
	ld de, 0		;10
_whamd1
	ld b, 0			;7
	jp _wham4		;10
				;--
				;34
_wham3
	jr _wham3a		;       12
_wham3a
	jp _wham4		;       10
				;	--
				;       34	34
				;---
				;98
_wham4
	ld a, 7
	ld a, 7			;				+14
	ld a, c			;		4
	or a			;		4
	jp z, _wham5		;		10
	ld a, $18		;		7 ->  98	->112
	out (254), a
	dec c
	jp _wham6
_wham5
	ld a, $00
	out (254), a		 
	dec c
	jp _wham6
_wham6
	dec hl
	ld a, h
	or l
	jr nz, _wham7
_whamf2
	ld hl, 0
_whamd2
	ld c, 0
	jp _wham8
_wham7
	jr _wham7a
_wham7a
	jp _wham8
_wham8
	dec ix				;10	..	73	
	.BYTE 221
	ld a, h				;8
	.BYTE 221
	or l				;8
	jr nz, _whamloop	;12
						;--
						;36		38
	jp _wham_exit

_wham_getnote
	;A.. note
	;return frequency in DE
	ld hl, _notetable
	add a, a
	add a, l
	jr nc, _wham_getnote1
	inc h
_wham_getnote1
	ld e, (hl)
	inc hl
	ld d, (hl)
	ret


	 
_wham_doframe
	ld a, (ix + 9)
	or a
	call z, _wham_dorow
	;get chord pointer
	ld l, (ix + 1)
	ld h, (ix + 2)
	ld a, l
	or h
	jr z, _wham_chord_sustain	;no change if there is no chord pattern
_wham_doframe1
	ld a, (hl)
	cp 128
	jr z, _wham_chord_sustain
	cp 127
	jr nz, _wham_chord_no_jump
	;read new pointer
	inc hl
	ld a, (hl)
	inc hl
	ld h, (hl)
	ld l, a
	jr _wham_doframe1
_wham_chord_no_jump
	;modify note
	add a, (ix + 0)
	ld (ix + 0), a
	;update chord pointer
	inc hl
	ld (ix + 1), l
	ld (ix + 2), h
_wham_chord_sustain
	;get sweep pointer
	ld l, (ix + 3)
	ld h, (ix + 4)
	ld a, l
	or h
	jr z, _wham_sweep_sustain
_wham_doframe2
	;get sweep delta
	ld a, (hl)
	cp 128		;sustain?
	jr z, _wham_sweep_sustain
	cp 127		;jump?
	jr nz, _wham_sweep_no_jump
	inc hl
	ld a, (hl)
	inc hl
	ld h, (hl)
	ld l, a		;new ptr in HL
	jr _wham_doframe2	;and repeat 
_wham_sweep_no_jump
	ex de, hl
	ld l, (ix + 7)	;read adress to modify duty in sound core
	ld h, (ix + 8)
	add a, (hl)	;add sweep 
	ld (hl), a	;store new duty
	inc de
	ld (ix + 3), e	;update sweep pointer
	ld (ix + 4), d
_wham_sweep_sustain
	ld a, (ix + 0)	;get current note
	call _wham_getnote
	ld l, (ix + 5)	;get ptr to modify freq in sound core 
	ld h, (ix + 6)
	ld (hl), e	;modify freq
	inc hl
	ld (hl), d 
	ret

_wham_dorow	
	ld l, (ix + 10)		;get row pointer
	ld h, (ix + 11)
	
	ld a, (hl)			;row interpreter
	inc hl
	cp 255				;end of pattern?
	jr nz, _wham_row_noend
	;TODO next pattern
	
_wham_row_noend
	;drums ?
	cp 250
	jr nz







	;40 - 60 - 3
	;70 - 30 - 1
	;140 - 30 - 0
	;70 - 60 - 0


_wham_drum1
	ld e, 200	;length
	ld c, 30	;start pitch
	ld d, 1		;pitch delta
	ld h, 253	;rng
	ld l, 17
_wham_drum1a
	ld a, h
	rrca
	add a, l
	ld h, a
	and 16
	or 0
	out (254), a
	ld b, c
_wham_drum1b
	djnz _wham_drum1b
	ld a, c
	add a, d
	ld c, a
	dec e
	jr nz, _wham_drum1a
	ret


_wham_drum2
	ld hl, 50	;params
	ld b, 10	;
	ld de, 46	;
_wham_drum2a
	push bc
	ld a, $18
	out (254), a
	ld b, h
	ld c, l
_wham_drum2x
	dec bc
	ld a, b
	or c
	jr nz, _wham_drum2x
	ld a, 0
	out (254), a
	ld b, h
	ld c, l
_wham_drum2y
	dec bc
	ld a, b
	or c
	jr nz, _wham_drum2y
	add hl, de
	pop bc
	djnz _wham_drum2a
	ret


  	

_notetable
	.WORD 0

	
_wham1note	.BYTE 0			;0	
_wham1chord	.WORD 0			;1,2
_wham1sweep	.WORD 0			;3,4
_wham1fptr	.WORD _whamf1 + 1	;5,6
_wham1dptr	.WORD _whamd1 + 1	;7,8
_wham1duration	.BYTE 0			;9
_wham1rowptr .WORD 0			;10,11
_wham1pattptr .WORD 0			;12,13

_wham2note	.BYTE 0
_wham2chord	.WORD 0
_wham2sweep	.WORD 0
_wham1fptr	.WORD _whamf1 + 1
_wham1dptr	.WORD _whamd1 + 1
_wham2duration	.BYTE 0
