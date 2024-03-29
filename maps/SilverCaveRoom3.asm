	const_def 2 ; object constants
	const SILVERCAVEROOM3_RED

SilverCaveRoom3_MapScripts:
	db 0 ; scene scripts

	db 0 ; callbacks

Red:
	special FadeOutMusic
	faceplayer
	opentext
	writetext .Text1
	waitbutton
	closetext
	winlosstext .Text2, .Text2
	loadtrainer RED, RED1
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	special FadeOutMusic
	opentext
	writetext .Text3
	waitbutton
	giveitem GS_BALL
	setevent EVENT_CAN_GIVE_GS_BALL_TO_KURT
	writetext .Text4
	playsound SFX_ITEM
	waitsfx
	itemnotify
	writetext .Text5
	waitbutton
	closetext
	special FadeBlackQuickly
	special ReloadSpritesNoPalettes
	disappear SILVERCAVEROOM3_RED
	pause 15
	special FadeInQuickly
	pause 30
	special HealParty
	refreshscreen
	credits
	end

.Text1:
	text "<……>"
	line "<……>"
	done

.Text2:
	text "…"
	done

.Text3:
	text "Here you've earned"
	line "this."
	done
	
.Text4
	text "<PLAYER> received"
	line "GS BALL."
	done
	
.Text5
	text "I heard rumors"
	line "that the GS BALL has"
	
	para "a connection with"
	line "Ilex Forest"
	done

SilverCaveRoom3_MapEvents:
	db 0, 0 ; filler

	db 1 ; warp events
	warp_event  9, 33, SILVER_CAVE_ROOM_2, 2

	db 0 ; coord events

	db 0 ; bg events

	db 1 ; object events
	object_event  9, 10, SPRITE_RED, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Red, EVENT_RED_IN_MT_SILVER
