RepelWoreOffScript::
	opentext
	writetext .text
	waitbutton
	closetext
	end

.text
	; REPEL's effect wore off.
	text_far UnknownText_0x1bd308
	text_end

UseAnotherRepelScript::
	opentext
	writetext .text
	yesorno
	iffalse .done
	callasm DoItemEffect
.done
	closetext
	end

.text:
	text_far _UseAnotherRepelText
	text_end
	
HiddenItemScript::
	opentext
	copybytetovar wEngineBuffer3
	itemtotext USE_SCRIPT_VAR, MEM_BUFFER_0
	callasm .append_tmhm_move_name
	writetext .found_text
	giveitem ITEM_FROM_MEM
	iffalse .bag_full
	callasm SetMemEvent
	specialsound
	itemnotify
	jump .finish

.bag_full
	buttonsound
	writetext .no_room_text
	waitbutton

.finish
	closetext
	end

.append_tmhm_move_name
	ld de, wStringBuffer3 + STRLEN("TM##")
	farcall AppendTMHMMoveName
	ret

.found_text
	; found @ !
	text_far UnknownText_0x1bd321
	text_end

.no_room_text
	; But   has no space left…
	text_far UnknownText_0x1bd331
	text_end

SetMemEvent:
	ld hl, wEngineBuffer1
	ld a, [hli]
	ld d, [hl]
	ld e, a
	ld b, SET_FLAG
	call EventFlagAction
	ret
