	const_def 2 ; object constants
	const SILVERCAVEROOM2_POKE_BALL1
	const SILVERCAVEROOM2_POKE_BALL2
	const SILVERCAVEROOM2_POKE_BALL3
	const SILVERCAVEROOM2_MEW

SilverCaveRoom2_MapScripts:
	db 0 ; scene scripts

	db 0 ; callbacks

SilverCaveRoom2Calcium:
	itemball CALCIUM

SilverCaveRoom2UltraBall:
	itemball ULTRA_BALL

SilverCaveRoom2PPUp:
	itemball PP_UP

SilverCaveRoom2HiddenMaxPotion:
	hiddenitem MAX_POTION, EVENT_SILVER_CAVE_ROOM_2_HIDDEN_MAX_POTION
	
SilverCaveRoom2Mew:
	faceplayer
	opentext
	writetext MewText
	cry MEW
	pause 15
	closetext
	loadwildmon MEW, 70
	writecode VAR_BATTLETYPE, BATTLETYPE_TRAP
	startbattle
	disappear SILVERCAVEROOM2_MEW
	setevent EVENT_MEW_SPAWN
	reloadmapafterbattle
	end
	
MewText:
	text "Mew Mew"
	done

SilverCaveRoom2_MapEvents:
	db 0, 0 ; filler

	db 4 ; warp events
	warp_event 17, 31, SILVER_CAVE_ROOM_1, 2
	warp_event 11,  5, SILVER_CAVE_ROOM_3, 1
	warp_event 13, 21, SILVER_CAVE_ITEM_ROOMS, 1
	warp_event 23,  3, SILVER_CAVE_ITEM_ROOMS, 2

	db 0 ; coord events

	db 1 ; bg events
	bg_event 14, 31, BGEVENT_ITEM, SilverCaveRoom2HiddenMaxPotion

	db 4 ; object events
	object_event 24, 10, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, SilverCaveRoom2Calcium, EVENT_SILVER_CAVE_ROOM_2_CALCIUM
	object_event 22, 24, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, SilverCaveRoom2UltraBall, EVENT_SILVER_CAVE_ROOM_2_ULTRA_BALL
	object_event  4, 20, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, SilverCaveRoom2PPUp, EVENT_SILVER_CAVE_ROOM_2_PP_UP
	object_event 11, 8, SPRITE_MEW, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, SilverCaveRoom2Mew, EVENT_MEW_SPAWN