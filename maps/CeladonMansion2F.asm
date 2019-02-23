	const_def 2 ; object constants
	const CELADONMANSION3F_POSTER_CLERK

CeladonMansion2F_MapScripts:
	db 0 ; scene scripts

	db 0 ; callbacks
	
GameFreakPosterClerk:
	faceplayer
	opentext
.Begin:
	writetext PosterClerk
	special PlaceMoneyTopRight
	loadmenu .PosterMenu
	verticalmenu
	closewindow
	ifequal $1, .PikachuPoster
	ifequal $2, .ClefairyPoster
	ifequal $3, .JigglypuffPoster
	closetext
	end
	
.PikachuPoster
	checkmoney $0, 3000
	ifequal $2, .NotEnoughMoneyPoster
	checkevent EVENT_DECO_POSTER_1
	iftrue .AlreadyBoughtPoster
	takemoney $0, 3000
	setevent EVENT_DECO_POSTER_1
	writetext BoughtPikachuPosterText
	playsound SFX_TRANSACTION
	waitbutton
	writetext PikachuPosterSentText
	waitbutton
	jump .Begin
	
.ClefairyPoster
	checkmoney $0, 3000
	ifequal $2, .NotEnoughMoneyPoster
	checkevent EVENT_DECO_POSTER_2
	iftrue .AlreadyBoughtPoster
	takemoney $0, 3000
	setevent EVENT_DECO_POSTER_2
	writetext BoughtClefairyPosterText
	playsound SFX_TRANSACTION
	waitbutton
	writetext ClefairyPosterSentText
	waitbutton
	jump .Begin
	
.JigglypuffPoster
	checkmoney $0, 3000
	ifequal $2, .NotEnoughMoneyPoster
	checkevent EVENT_DECO_POSTER_3
	iftrue .AlreadyBoughtPoster
	takemoney $0, 3000
	setevent EVENT_DECO_POSTER_3
	writetext BoughtJigglypuffPosterText
	playsound SFX_TRANSACTION
	waitbutton
	writetext JigglypuffPosterSentText
	waitbutton
	jump .Begin

.NotEnoughMoneyPoster:
	writetext PosterNoMoney
	waitbutton
	jump .Begin

.AlreadyBoughtPoster:
	writetext PosterDuplicate
	waitbutton
	jump .Begin

.PosterMenu:
	db $40 ; flags
	db 02, 00 ; start coords
	db 11, 19 ; end coords
	dw .PosterMenu2
	db 1 ; default option

.PosterMenu2:
	db $80 ; flags
	db 4 ; items
	db "Pikachu     ¥3000@"
	db "Clefairy    ¥3000@"
	db "Jigglypuff  ¥3000@"
	db "Cancel@"
	
PosterClerk:
	text "Interested in"
	line "#mon Posters?"
	done
	
PosterNoMoney:
	text "You can't afford"
	line "that."
	done

PosterDuplicate:
	text "You've already"
	line "bought that."
	done

BoughtPikachuPosterText:
	text "<PLAYER> bought"
	line "Pikachu Poster."
	done

PikachuPosterSentText:
	text "Pikachu Poster"
	line "was sent home."
	done
	
BoughtClefairyPosterText:
	text "<PLAYER> bought"
	line "Clefairy Poster."
	done

ClefairyPosterSentText:
	text "Clefairy Poster"
	line "was sent home."
	done
	
BoughtJigglypuffPosterText:
	text "<PLAYER> bought"
	line "Jigglypuff Poster."
	done

JigglypuffPosterSentText:
	text "Jigglypuff Poster"
	line "was sent home."
	done

CeladonMansion2FComputer:
	jumptext CeladonMansion2FComputerText

CeladonMansion2FMeetingRoomSign:
	jumptext CeladonMansion2FMeetingRoomSignText

CeladonMansion2FBookshelf:
	jumpstd difficultbookshelf

CeladonMansion2FComputerText:
	text "<PLAYER> turned on"
	line "the PC."

	para "…"

	para "Someone was in the"
	line "middle of compos-"
	cont "ing an e-mail."

	para "…I hope you'll"
	line "come visit KANTO."

	para "I think you'll be"
	line "surprised at how"

	para "much things have"
	line "changed here."

	para "You'll also see"
	line "many #MON that"

	para "aren't native to"
	line "JOHTO."

	para "To the PRODUCER"

	para "…"
	done

CeladonMansion2FMeetingRoomSignText:
	text "GAME FREAK"
	line "MEETING ROOM"
	done

CeladonMansion2F_MapEvents:
	db 0, 0 ; filler

	db 4 ; warp events
	warp_event  0,  0, CELADON_MANSION_1F, 4
	warp_event  1,  0, CELADON_MANSION_3F, 2
	warp_event  6,  0, CELADON_MANSION_3F, 3
	warp_event  7,  0, CELADON_MANSION_1F, 5

	db 0 ; coord events

	db 3 ; bg events
	bg_event  0,  3, BGEVENT_READ, CeladonMansion2FComputer
	bg_event  5,  8, BGEVENT_UP, CeladonMansion2FMeetingRoomSign
	bg_event  2,  3, BGEVENT_READ, CeladonMansion2FBookshelf

	db 1 ; object events
	object_event  2,  4, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, GameFreakPosterClerk, -1