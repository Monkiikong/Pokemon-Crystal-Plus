	const_def 2 ; object constants
	const BLACKTHORNDRAGONSPEECHHOUSE_GRANNY
	const BLACKTHORNDRAGONSPEECHHOUSE_EKANS

BlackthornDragonSpeechHouse_MapScripts:
	db 0 ; scene scripts

	db 0 ; callbacks

BlackthornDragonSpeechHouseDratiniScript:
	opentext
	writetext BlackthornDragonSpeechHouseDratiniText
	cry DRATINI
	waitbutton
	closetext
	end

; unused
BlackthornDragonSpeechHousePictureBookshelf:
	jumpstd picturebookshelf

; unused
BlackthornDragonSpeechHouseMagazineBookshelf:
	jumpstd magazinebookshelf

BlackthornDragonSpeechHouseGrannyScript:
	faceplayer
	opentext
	writetext CarpetExplain
	waitbutton
.Begin:
	writetext CarpetClerk
	special PlaceMoneyTopRight
	loadmenu .CarpetMenu
	verticalmenu
	closewindow
	ifequal $1, .RedCarpet
	ifequal $2, .BlueCarpet
	ifequal $3, .YellowCarpet
	writetext GoodBye
	waitbutton
	closetext
	end
	
.RedCarpet
	checkmoney $0, 10000
	ifequal $2, .NotEnoughMoneyCarpet
	checkevent EVENT_DECO_CARPET_1
	iftrue .AlreadyBoughtCarpet
	takemoney $0, 10000
	setevent EVENT_DECO_CARPET_1
	writetext BoughtRedCarpetText
	playsound SFX_TRANSACTION
	waitbutton
	writetext RedCarpetSentText
	waitbutton
	jump .Begin
	
.BlueCarpet
	checkmoney $0, 10000
	ifequal $2, .NotEnoughMoneyCarpet
	checkevent EVENT_DECO_CARPET_2
	iftrue .AlreadyBoughtCarpet
	takemoney $0, 10000
	setevent EVENT_DECO_CARPET_2
	writetext BoughtBlueCarpetText
	playsound SFX_TRANSACTION
	waitbutton
	writetext BlueCarpetSentText
	waitbutton
	jump .Begin
	
.YellowCarpet
	checkmoney $0, 10000
	ifequal $2, .NotEnoughMoneyCarpet
	checkevent EVENT_DECO_CARPET_3
	iftrue .AlreadyBoughtCarpet
	takemoney $0, 10000
	setevent EVENT_DECO_CARPET_3
	writetext BoughtYellowCarpetText
	playsound SFX_TRANSACTION
	waitbutton
	writetext YellowCarpetSentText
	waitbutton
	jump .Begin
	
.NotEnoughMoneyCarpet:
	writetext CarpetNoMoney
	waitbutton
	jump .Begin

.AlreadyBoughtCarpet:
	writetext CarpetDuplicate
	waitbutton
	jump .Begin

.CarpetMenu:
	db $40 ; flags
	db 02, 00 ; start coords
	db 11, 19 ; end coords
	dw .CarpetMenu2
	db 1 ; default option

.CarpetMenu2:
	db $80 ; flags
	db 4 ; items
	db "Red        ¥10000@"
	db "Blue       ¥10000@"
	db "Yellow     ¥10000@"
	db "Cancel@"

GoodBye:
	text "Good bye!"
	done
	
CarpetExplain:
	text "I hand make these"
	line "carpets."
	
	para "I get my grand-"
	line "son to collect"
	
	para "materials that I"
	line "use to dye them."
	done
	
CarpetClerk:
	text "Would you like to"
	line "buy one?"
	done
	
CarpetNoMoney:
	text "You can't afford"
	line "that."
	done

CarpetDuplicate:
	text "You've already"
	line "bought that."
	done

BoughtRedCarpetText:
	text "<PLAYER> bought"
	line "Red Carpet."
	done

RedCarpetSentText:
	text "Red Carpet"
	line "was sent home."
	done
	
BoughtBlueCarpetText:
	text "<PLAYER> bought"
	line "Blue Carpet."
	done

BlueCarpetSentText:
	text "Blue Carpet"
	line "was sent home."
	done
	
BoughtYellowCarpetText:
	text "<PLAYER> bought"
	line "Yellow Carpet."
	done

YellowCarpetSentText:
	text "Yellow Carpet"
	line "was sent home."
	done

BlackthornDragonSpeechHouseDratiniText:
	text "DRATINI: Draa!"
	done

BlackthornDragonSpeechHouse_MapEvents:
	db 0, 0 ; filler

	db 2 ; warp events
	warp_event  2,  7, BLACKTHORN_CITY, 2
	warp_event  3,  7, BLACKTHORN_CITY, 2

	db 0 ; coord events

	db 0 ; bg events

	db 2 ; object events
	object_event  2,  3, SPRITE_GRANNY, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BlackthornDragonSpeechHouseGrannyScript, -1
	object_event  5,  5, SPRITE_DRATINI, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, BlackthornDragonSpeechHouseDratiniScript, -1
