	const_def 2 ; object constants
	const HALLOFFAME_LANCE

HallOfFame_MapScripts:
	db 2 ; scene scripts
	scene_script .EnterHallOfFame ; SCENE_DEFAULT
	scene_script .DummyScene ; SCENE_FINISHED

	db 0 ; callbacks

.EnterHallOfFame:
	priorityjump .EnterHallOfFameScript
	end

.DummyScene:
	end

.EnterHallOfFameScript:
	follow HALLOFFAME_LANCE, PLAYER
	applymovement HALLOFFAME_LANCE, HallOfFame_WalkUpWithLance
	stopfollow
	turnobject PLAYER, RIGHT
	opentext
	writetext HallOfFame_LanceText
	waitbutton	
	checkcode VAR_BADGES
	ifequal 16, .CheckGoldTrophy
	checkevent EVENT_DECO_SILVER_TROPHY
	iftrue .NoTrophy
	jump .SilverTrophy
.CheckGoldTrophy
	checkevent EVENT_DECO_GOLD_TROPHY
	iftrue .NoTrophy
	jump .GoldTrophy
.SilverTrophy
	writetext LanceTrophyText
	waitbutton
	setevent EVENT_DECO_SILVER_TROPHY
	writetext SilverTrophyText
	playsound SFX_ITEM
	pause 60
	waitbutton
	writetext SilverTrophySentText
	waitbutton
	jump .NoTrophy
.GoldTrophy
	writetext LanceTrophyText
	waitbutton
	setevent EVENT_DECO_GOLD_TROPHY
	writetext GoldTrophyText
	playsound SFX_ITEM
	pause 60
	waitbutton
	writetext GoldTrophySentText
	waitbutton
	jump .NoTrophy
.NoTrophy:	
	closetext
	turnobject HALLOFFAME_LANCE, UP
	applymovement PLAYER, HallOfFame_SlowlyApproachMachine
	setscene SCENE_FINISHED
	pause 15
	writebyte HEALMACHINE_HALL_OF_FAME
	special HealMachineAnim
	setevent EVENT_BEAT_ELITE_FOUR
	clearevent EVENT_ICE_PATH_ARTICUNO
	clearevent EVENT_POWER_PLANT_ZAPDOS
	clearevent EVENT_CINNABAR_ISLAND_MOLTRES
	clearevent EVENT_BEAT_ELITE_FOUR
	setevent EVENT_TELEPORT_GUY
	setevent EVENT_RIVAL_SPROUT_TOWER
	clearevent EVENT_RED_IN_MT_SILVER
	setevent EVENT_OLIVINE_PORT_SPRITES_BEFORE_HALL_OF_FAME
	clearevent EVENT_OLIVINE_PORT_SPRITES_AFTER_HALL_OF_FAME
	setmapscene SPROUT_TOWER_3F, SCENE_FINISHED
	special HealParty
	checkevent EVENT_GOT_SS_TICKET_FROM_ELM
	iftrue .SkipPhoneCall
	specialphonecall SPECIALCALL_SSTICKET
.SkipPhoneCall:
	halloffame
	end

HallOfFame_WalkUpWithLance:
	step UP
	step UP
	step UP
	step UP
	step UP
	step UP
	step UP
	step UP
	step RIGHT
	turn_head LEFT
	step_end

HallOfFame_SlowlyApproachMachine:
	slow_step UP
	step_end

	
HallOfFame_LanceText:
	text "LANCE: It's been a"
	line "long time since I"
	cont "last came here."

	para "This is where we"
	line "honor the LEAGUE"

	para "CHAMPIONS for all"
	line "eternity."

	para "Their courageous"
	line "#MON are also"
	cont "inducted."

	para "Here today, we"
	line "witnessed the rise"

	para "of a new LEAGUE"
	line "CHAMPION--a"

	para "trainer who feels"
	line "compassion for,"

	para "and trust toward,"
	line "all #MON."

	para "A trainer who"
	line "succeeded through"

	para "perseverance and"
	line "determination."

	para "The new LEAGUE"
	line "CHAMPION who has"

	para "all the makings"
	line "of greatness!"

	para "<PLAY_G>, allow me"
	line "to register you"

	para "and your partners"
	line "as CHAMPIONS!"
	done

LanceTrophyText:
	text "Take this as a"
	line "memento of what"

	para "you accomplished"
	line "here today."
	done	

GoldTrophyText:
	text "<PLAYER> received"
	line "Gold Trophy."
	done

GoldTrophySentText:
	text "Gold Trophy"
	line "was sent home."
	done

SilverTrophyText:
	text "<PLAYER> received"
	line "Silver Trophy."
	done

SilverTrophySentText:
	text "Silver Trophy"
	line "was sent home."
	done
	
HallOfFame_MapEvents:
	db 0, 0 ; filler

	db 2 ; warp events
	warp_event  4, 13, LANCES_ROOM, 3
	warp_event  5, 13, LANCES_ROOM, 4

	db 0 ; coord events

	db 0 ; bg events

	db 1 ; object events
	object_event  4, 12, SPRITE_LANCE, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, -1
