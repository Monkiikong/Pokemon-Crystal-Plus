	const_def 2 ; object constants
	const GOLDENRODDEPTSTORE6F_CLERK
	const GOLDENRODDEPTSTORE6F_LASS
	const GOLDENRODDEPTSTORE6F_SUPER_NERD

GoldenrodDeptStore6F_MapScripts:
	db 0 ; scene scripts

	db 0 ; callbacks
	
GoldenrodDeptStore6F2ClerkScript:
	faceplayer
	opentext
.Begin:
	writetext DecoClerk
	special PlaceMoneyTopRight
	loadmenu .DecoMenu
	verticalmenu
	closewindow
	ifequal $1, .PinkBed
	ifequal $2, .PolkaBed
	ifequal $3, .MagnaPlant
	writetext GRGoodBye
	waitbutton
	closetext
	end
	
.PinkBed
	checkmoney $0, 5000
	ifequal $2, .NotEnoughMoneyDeco
	checkevent EVENT_DECO_BED_2
	iftrue .AlreadyBoughtDeco
	takemoney $0, 5000
	setevent EVENT_DECO_BED_2
	writetext BoughtPinkBedText
	playsound SFX_TRANSACTION
	waitbutton
	writetext PinkBedSentText
	waitbutton
	jump .Begin
	
.PolkaBed
	checkmoney $0, 5000
	ifequal $2, .NotEnoughMoneyDeco
	checkevent EVENT_DECO_BED_3
	iftrue .AlreadyBoughtDeco
	takemoney $0, 5000
	setevent EVENT_DECO_BED_3
	writetext BoughtPolkaBedText
	playsound SFX_TRANSACTION
	waitbutton
	writetext PolkaBedSentText
	waitbutton
	jump .Begin
	
.MagnaPlant
	checkmoney $0, 5000
	ifequal $2, .NotEnoughMoneyDeco
	checkevent EVENT_DECO_PLANT_1
	iftrue .AlreadyBoughtDeco
	takemoney $0, 5000
	setevent EVENT_DECO_PLANT_1
	writetext BoughtMagnaPlantText
	playsound SFX_TRANSACTION
	waitbutton
	writetext MagnaPlantSentText
	waitbutton
	jump .Begin

.NotEnoughMoneyDeco:
	writetext DecoNoMoney
	waitbutton
	jump .Begin

.AlreadyBoughtDeco:
	writetext DecoDuplicate
	waitbutton
	jump .Begin

.DecoMenu:
	db $40 ; flags
	db 02, 00 ; start coords
	db 11, 19 ; end coords
	dw .DecoMenu2
	db 1 ; default option

.DecoMenu2:
	db $80 ; flags
	db 4 ; items
	db "Pink Bed    ¥5000@"
	db "Polka Bed   ¥5000@"
	db "Magna Plant ¥5000@"
	db "Cancel@"
	
DecoClerk:
	text "Looking to buy"
	line "some decorations?"
	done
	
DecoNoMoney:
	text "You can't afford"
	line "that."
	done

DecoDuplicate:
	text "You've already"
	line "bought that."
	done

BoughtPinkBedText:
	text "<PLAYER> bought"
	line "Pink Bed."
	done

PinkBedSentText:
	text "Pink Bed"
	line "was sent home."
	done
	
BoughtPolkaBedText:
	text "<PLAYER> bought"
	line "Polka Dot Bed."
	done

PolkaBedSentText:
	text "Polka Dot Bed"
	line "was sent home."
	done
	
BoughtMagnaPlantText:
	text "<PLAYER> bought"
	line "Magna Plant."
	done

MagnaPlantSentText:
	text "Magna Plant"
	line "was sent home."
	done

GRGoodBye:
	text "Good Bye!"
	done

GoldenrodVendingMachine:
	opentext
	writetext GoldenrodVendingText
.Start:
	special PlaceMoneyTopRight
	loadmenu .MenuHeader
	verticalmenu
	closewindow
	ifequal 1, .FreshWater
	ifequal 2, .SodaPop
	ifequal 3, .Lemonade
	closetext
	end

.FreshWater:
	checkmoney YOUR_MONEY, 200
	ifequal HAVE_LESS, .NotEnoughMoney
	giveitem FRESH_WATER
	iffalse .NotEnoughSpace
	takemoney YOUR_MONEY, 200
	itemtotext FRESH_WATER, MEM_BUFFER_0
	jump .VendItem

.SodaPop:
	checkmoney YOUR_MONEY, 300
	ifequal HAVE_LESS, .NotEnoughMoney
	giveitem SODA_POP
	iffalse .NotEnoughSpace
	takemoney YOUR_MONEY, 300
	itemtotext SODA_POP, MEM_BUFFER_0
	jump .VendItem

.Lemonade:
	checkmoney YOUR_MONEY, 350
	ifequal HAVE_LESS, .NotEnoughMoney
	giveitem LEMONADE
	iffalse .NotEnoughSpace
	takemoney YOUR_MONEY, 350
	itemtotext LEMONADE, MEM_BUFFER_0
	jump .VendItem

.VendItem:
	pause 10
	playsound SFX_ENTER_DOOR
	writetext GoldenrodClangText
	buttonsound
	itemnotify
	jump .Start

.NotEnoughMoney:
	writetext GoldenrodVendingNoMoneyText
	waitbutton
	jump .Start

.NotEnoughSpace:
	writetext GoldenrodVendingNoSpaceText
	waitbutton
	jump .Start

.MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 2, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR ; flags
	db 4 ; items
	db "FRESH WATER  ¥200@"
	db "SODA POP     ¥300@"
	db "LEMONADE     ¥350@"
	db "CANCEL@"

GoldenrodDeptStore6FLassScript:
	jumptextfaceplayer GoldenrodDeptStore6FLassText

GoldenrodDeptStore6FSuperNerdScript:
	jumptextfaceplayer GoldenrodDeptStore6FSuperNerdText

GoldenrodDeptStore6FDirectory:
	jumptext GoldenrodDeptStore6FDirectoryText

GoldenrodDeptStore6FElevatorButton:
	jumpstd elevatorbutton

GoldenrodVendingText:
	text "A vending machine!"
	line "Here's the menu."
	done

GoldenrodClangText:
	text "Clang! A can of"
	line "@"
	text_ram wStringBuffer3
	text_start
	cont "popped out!"
	done

GoldenrodVendingNoMoneyText:
	text "Oops, not enough"
	line "money."
	done

GoldenrodVendingNoSpaceText:
	text "There's no more"
	line "room for stuff."
	done

GoldenrodDeptStore6FLassText:
	text "Do you listen to"
	line "LUCKY CHANNEL?"

	para "If you want to"
	line "win, trade #MON"

	para "with as many peo-"
	line "ple as possible to"

	para "get different ID"
	line "numbers."
	done

GoldenrodDeptStore6FSuperNerdText:
	text "If you're tired,"
	line "try the vending"
	cont "machine's drinks."

	para "Your #MON will"
	line "love them too."
	done

GoldenrodDeptStore6FDirectoryText:
	text "Decorate your"
	line "life!"

	para "6F DECORATION"
	line "STATION"
	done

GoldenrodDeptStore6F_MapEvents:
	db 0, 0 ; filler

	db 3 ; warp events
	warp_event 15,  0, GOLDENROD_DEPT_STORE_5F, 2
	warp_event  2,  0, GOLDENROD_DEPT_STORE_ELEVATOR, 1
	warp_event 13,  0, GOLDENROD_DEPT_STORE_ROOF, 1

	db 0 ; coord events

	db 6 ; bg events
	bg_event 14,  0, BGEVENT_READ, GoldenrodDeptStore6FDirectory
	bg_event  3,  0, BGEVENT_READ, GoldenrodDeptStore6FElevatorButton
	bg_event  8,  1, BGEVENT_UP, GoldenrodVendingMachine
	bg_event  9,  1, BGEVENT_UP, GoldenrodVendingMachine
	bg_event 10,  1, BGEVENT_UP, GoldenrodVendingMachine
	bg_event 11,  1, BGEVENT_UP, GoldenrodVendingMachine

	db 3 ; object events
	object_event 13,  5, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStore6F2ClerkScript, -1
	object_event 10,  2, SPRITE_LASS, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStore6FLassScript, -1
	object_event  8,  2, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStore6FSuperNerdScript, -1
