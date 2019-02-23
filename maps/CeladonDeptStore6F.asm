	const_def 1 ; object constants
	const CELADONDEPTSTORE6F_CLERK
	const CELADONDEPTSTORE6F_YOUNGSTER

CeladonDeptStore6F_MapScripts:
	db 0 ; scene scripts

	db 1 ; callbacks
	callback MAPCALLBACK_TILES, .HideRooftopStairs

.HideRooftopStairs:
	changeblock 12, 0, $03 ; wall
	return

CeladonDeptStore6FYoungsterScript:
	jumptextfaceplayer CeladonDeptStore6FYoungsterText

CeladonDeptStore6F2ClerkScript:
	faceplayer
	opentext
.Begin:
	writetext CeladonDecoClerk
	special PlaceMoneyTopRight
	loadmenu .DecoMenu
	verticalmenu
	closewindow
	ifequal $1, .PikachuBed
	ifequal $2, .TropicPlant
	ifequal $3, .JumboPlant
	closetext
	end
	
.PikachuBed
	checkmoney $0, 5000
	ifequal $2, .NotEnoughMoneyDeco
	checkevent EVENT_DECO_BED_4
	iftrue .AlreadyBoughtDeco
	takemoney $0, 5000
	setevent EVENT_DECO_BED_4
	writetext BoughtPikachuBedText
	playsound SFX_TRANSACTION
	waitbutton
	writetext PikachuBedSentText
	waitbutton
	jump .Begin
	
.TropicPlant
	checkmoney $0, 5000
	ifequal $2, .NotEnoughMoneyDeco
	checkevent EVENT_DECO_PLANT_2
	iftrue .AlreadyBoughtDeco
	takemoney $0, 5000
	setevent EVENT_DECO_PLANT_2
	writetext BoughtTropicPlantText
	playsound SFX_TRANSACTION
	waitbutton
	writetext TropicPlantSentText
	waitbutton
	jump .Begin
	
.JumboPlant
	checkmoney $0, 5000
	ifequal $2, .NotEnoughMoneyDeco
	checkevent EVENT_DECO_PLANT_3
	iftrue .AlreadyBoughtDeco
	takemoney $0, 5000
	setevent EVENT_DECO_PLANT_3
	writetext BoughtJumboPlantText
	playsound SFX_TRANSACTION
	waitbutton
	writetext JumboPlantSentText
	waitbutton
	jump .Begin

.NotEnoughMoneyDeco:
	writetext CeladonDecoNoMoney
	waitbutton
	jump .Begin

.AlreadyBoughtDeco:
	writetext CeladonDecoDuplicate
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
	db "Pikachu Bed ¥5000@"
	db "Tropic Plant¥5000@"
	db "Jumbo Plant ¥5000@"
	db "Cancel@"
	
CeladonDecoClerk:
	text "Looking to buy"
	line "some decorations?"
	done
	
CeladonDecoNoMoney:
	text "You can't afford"
	line "that."
	done

CeladonDecoDuplicate:
	text "You've already"
	line "bought that."
	done

BoughtPikachuBedText:
	text "<PLAYER> bought"
	line "Pikachu Bed."
	done

PikachuBedSentText:
	text "Pikachu Bed"
	line "was sent home."
	done
	
BoughtTropicPlantText:
	text "<PLAYER> bought"
	line "Tropic Plant."
	done

TropicPlantSentText:
	text "Tropic Plant"
	line "was sent home."
	done
	
BoughtJumboPlantText:
	text "<PLAYER> bought"
	line "Jumbo Plant."
	done

JumboPlantSentText:
	text "Jumbo Plant"
	line "was sent home."
	done


CeladonDeptStore6FVendingMachine:
	opentext
	writetext CeladonVendingText
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
	writetext CeladonClangText
	buttonsound
	itemnotify
	jump .Start

.NotEnoughMoney:
	writetext CeladonVendingNoMoneyText
	waitbutton
	jump .Start

.NotEnoughSpace:
	writetext CeladonVendingNoSpaceText
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
	
CeladonDeptStore6FPokeDollVendingMachine1:
	opentext
	writetext CeladonPokeDollVendingMachine1Text
.Start:
	special PlaceMoneyTopRight
	loadmenu .Doll1MenuData
	verticalmenu
	closewindow
	ifequal $1, .PoliwagDoll
	ifequal $2, .DiglettDoll
	ifequal $3, .StarmieDoll
	closetext
	closetext
	end

.PoliwagDoll:
	checkmoney $0, 2400
	ifequal $2, .NotEnoughMoney
	checkevent EVENT_DECO_POLIWAG_DOLL
	iftrue .AlreadyBought
	takemoney $0, 2400
	setevent EVENT_DECO_POLIWAG_DOLL
	writetext BoughtPoliwagDollText
	playsound SFX_TRANSACTION
	waitbutton
	writetext PoliwagDollSentText
	waitbutton
	jump .Start

.DiglettDoll:
	checkmoney $0, 2400
	ifequal $2, .NotEnoughMoney
	checkevent EVENT_DECO_DIGLETT_DOLL
	iftrue .AlreadyBought
	takemoney $0, 2400
	setevent EVENT_DECO_DIGLETT_DOLL
	writetext BoughtDiglettDollText
	playsound SFX_TRANSACTION
	waitbutton
	writetext DiglettDollSentText
	waitbutton
	jump .Start

.StarmieDoll:
	checkmoney $0, 2400
	ifequal $2, .NotEnoughMoney
	checkevent EVENT_DECO_STARMIE_DOLL
	iftrue .AlreadyBought
	takemoney $0, 2400
	setevent EVENT_DECO_STARMIE_DOLL
	writetext BoughtStarmieDollText
	playsound SFX_TRANSACTION
	waitbutton
	writetext StarmieDollSentText
	waitbutton
	jump .Start

.NotEnoughMoney:
	writetext CeladonPokeDollVendingMachineNoMoneyText
	waitbutton
	jump .Start

.AlreadyBought:
	writetext CeladonPokeDollVendingMachineAlreadyBoughtText
	waitbutton
	jump .Start

.Doll1MenuData:
	db $40 ; flags
	db 02, 00 ; start coords
	db 11, 19 ; end coords
	dw .Doll1MenuData2
	db 1 ; default option

.Doll1MenuData2:
	db $80 ; flags
	db 4 ; items
	db "Poliwag     ¥2400@"
	db "Diglett     ¥2400@"
	db "Starmie     ¥2400@"
	db "Cancel@"
	
CeladonDeptStore6FPokeDollVendingMachine3:
	opentext
	writetext CeladonPokeDollVendingMachine1Text
.Start:
	special PlaceMoneyTopRight
	loadmenu .Doll3MenuData
	verticalmenu
	closewindow
	ifequal $1, .ShellderDoll
	ifequal $2, .GrimerDoll
	ifequal $3, .WeedleDoll
	closetext
	closetext
	end

.ShellderDoll:
	checkmoney $0, 2400
	ifequal $2, .NotEnoughMoney
	checkevent EVENT_DECO_SHELLDER_DOLL
	iftrue .AlreadyBought
	takemoney $0, 2400
	setevent EVENT_DECO_SHELLDER_DOLL
	writetext BoughtShellderDollText
	playsound SFX_TRANSACTION
	waitbutton
	writetext ShellderDollSentText
	waitbutton
	jump .Start

.GrimerDoll:
	checkmoney $0, 2400
	ifequal $2, .NotEnoughMoney
	checkevent EVENT_DECO_GRIMER_DOLL
	iftrue .AlreadyBought
	takemoney $0, 2400
	setevent EVENT_DECO_GRIMER_DOLL
	writetext BoughtGrimerDollText
	playsound SFX_TRANSACTION
	waitbutton
	writetext GrimerDollSentText
	waitbutton
	jump .Start

.WeedleDoll:
	checkmoney $0, 2400
	ifequal $2, .NotEnoughMoney
	checkevent EVENT_DECO_WEEDLE_DOLL
	iftrue .AlreadyBought
	takemoney $0, 2400
	setevent EVENT_DECO_WEEDLE_DOLL
	writetext BoughtWeedleDollText
	playsound SFX_TRANSACTION
	waitbutton
	writetext WeedleDollSentText
	waitbutton
	jump .Start

.NotEnoughMoney:
	writetext CeladonPokeDollVendingMachineNoMoneyText
	waitbutton
	jump .Start

.AlreadyBought:
	writetext CeladonPokeDollVendingMachineAlreadyBoughtText
	waitbutton
	jump .Start

.Doll3MenuData:
	db $40 ; flags
	db 02, 00 ; start coords
	db 11, 19 ; end coords
	dw .Doll3MenuData2
	db 1 ; default option

.Doll3MenuData2:
	db $80 ; flags
	db 4 ; items
	db "Shellder    ¥2400@"
	db "Grimer      ¥2400@"
	db "Weedle      ¥2400@"
	db "Cancel@"
	
BoughtShellderDollText:
	text "<PLAYER> bought"
	line "Shellder Doll."
	done

ShellderDollSentText:
	text "Shellder Doll"
	line "was sent home."
	done

BoughtGrimerDollText:
	text "<PLAYER> bought"
	line "Grimer Doll."
	done

GrimerDollSentText:
	text "Grimer Doll"
	line "was sent home."
	done

BoughtWeedleDollText:
	text "<PLAYER> bought"
	line "Weedle Doll."
	done

WeedleDollSentText:
	text "Weedle Doll"
	line "was sent home."
	done

CeladonDeptStore6FPokeDollVendingMachine2:
	opentext
	writetext CeladonPokeDollVendingMachine1Text
.Start:
	special PlaceMoneyTopRight
	loadmenu .Doll2MenuData
	verticalmenu
	closewindow
	ifequal $1, .MagikarpDoll
	ifequal $2, .OddishDoll
	ifequal $3, .GengarDoll
	closetext
	closetext
	end

.MagikarpDoll:
	checkmoney $0, 2400
	ifequal $2, .NotEnoughMoney
	checkevent EVENT_DECO_MAGIKARP_DOLL
	iftrue .AlreadyBought
	takemoney $0, 2400
	setevent EVENT_DECO_MAGIKARP_DOLL
	writetext BoughtMagikarpDollText
	playsound SFX_TRANSACTION
	waitbutton
	writetext MagikarpDollSentText
	waitbutton
	jump .Start

.OddishDoll:
	checkmoney $0, 2400
	ifequal $2, .NotEnoughMoney
	checkevent EVENT_DECO_ODDISH_DOLL
	iftrue .AlreadyBought
	takemoney $0, 2400
	setevent EVENT_DECO_ODDISH_DOLL
	writetext BoughtOddishDollText
	playsound SFX_TRANSACTION
	waitbutton
	writetext OddishDollSentText
	waitbutton
	jump .Start

.GengarDoll:
	checkmoney $0, 2400
	ifequal $2, .NotEnoughMoney
	checkevent EVENT_DECO_GENGAR_DOLL
	iftrue .AlreadyBought
	takemoney $0, 2400
	setevent EVENT_DECO_GENGAR_DOLL
	writetext BoughtGengarDollText
	playsound SFX_TRANSACTION
	waitbutton
	writetext GengarDollSentText
	waitbutton
	jump .Start

.NotEnoughMoney:
	writetext CeladonPokeDollVendingMachineNoMoneyText
	waitbutton
	jump .Start

.AlreadyBought:
	writetext CeladonPokeDollVendingMachineAlreadyBoughtText
	waitbutton
	jump .Start

.Doll2MenuData:
	db $40 ; flags
	db 02, 00 ; start coords
	db 11, 19 ; end coords
	dw .Doll2MenuData2
	db 1 ; default option

.Doll2MenuData2:
	db $80 ; flags
	db 4 ; items
	db "Magikarp    ¥2400@"
	db "Oddish      ¥2400@"
	db "Gengar      ¥2400@"
	db "Cancel@"
	
BoughtMagikarpDollText:
	text "<PLAYER> bought"
	line "Magikarp Doll."
	done

MagikarpDollSentText:
	text "Magikarp Doll"
	line "was sent home."
	done

BoughtOddishDollText:
	text "<PLAYER> bought"
	line "Oddish Doll."
	done

OddishDollSentText:
	text "Oddish Doll"
	line "was sent home."
	done

BoughtGengarDollText:
	text "<PLAYER> bought"
	line "Gengar Doll."
	done

GengarDollSentText:
	text "Gengar Doll"
	line "was sent home."
	done
	
CeladonPokeDollVendingMachine1Text:
	text "A vending machine"
	line "for #mon dolls!"
	done
	
CeladonPokeDollVendingMachineNoMoneyText:
	text "It costs too much!"
	done

CeladonPokeDollVendingMachineAlreadyBoughtText:
	text "It's a duplicate!"
	done

BoughtPoliwagDollText:
	text "<PLAYER> bought"
	line "Poliwag Doll."
	done

PoliwagDollSentText:
	text "Poliwag Doll"
	line "was sent home."
	done

BoughtDiglettDollText:
	text "<PLAYER> bought"
	line "Diglett Doll."
	done

DiglettDollSentText:
	text "Diglett Doll"
	line "was sent home."
	done

BoughtStarmieDollText:
	text "<PLAYER> bought"
	line "Starmie Doll."
	done

StarmieDollSentText:
	text "Starmie Doll"
	line "was sent home."
	done

CeladonDeptStore6FDirectory:
	jumptext CeladonDeptStore6FDirectoryText

; unused
CeladonDeptStore6FElevatorButton:
	jumpstd elevatorbutton

CeladonVendingText:
	text "A vending machine!"
	line "Here's the menu."
	done

CeladonClangText:
	text "Clang!"

	para "@"
	text_ram wStringBuffer3
	text_start
	line "popped out."
	done

CeladonVendingNoMoneyText:
	text "Oops, not enough"
	line "money…"
	done

CeladonVendingNoSpaceText:
	text "There's no more"
	line "room for stuff…"
	done

CeladonDeptStore6FYoungsterText:
	text "Aww! There's no"
	line "games here!"

	para "I wanted to play…"
	done

CeladonDeptStore6FDirectoryText:
	text "6F: DECORATIONS"
	line "VENDING MACHINES"
	done

CeladonDeptStore6F_MapEvents:
	db 0, 0 ; filler

	db 2 ; warp events
	warp_event 15,  0, CELADON_DEPT_STORE_5F, 2
	warp_event  2,  0, CELADON_DEPT_STORE_ELEVATOR, 1

	db 0 ; coord events

	db 6 ; bg events
	bg_event 14,  0, BGEVENT_READ, CeladonDeptStore6FDirectory
	bg_event  3,  0, BGEVENT_READ, CeladonDeptStore1FElevatorButton
	bg_event  8,  1, BGEVENT_UP, CeladonDeptStore6FVendingMachine
	bg_event  9,  1, BGEVENT_UP, CeladonDeptStore6FPokeDollVendingMachine1
	bg_event 10,  1, BGEVENT_UP, CeladonDeptStore6FPokeDollVendingMachine2
	bg_event 11,  1, BGEVENT_UP, CeladonDeptStore6FPokeDollVendingMachine3
	db 2 ; object events
	object_event 13,  5, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CeladonDeptStore6F2ClerkScript, -1
	object_event 11,  5, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WANDER, 2, 1, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CeladonDeptStore6FYoungsterScript, -1
