ChadOakGossipScript:
	random 10
	ifequal 0, .Blue
	ifequal 1, .Daisy
	ifequal 2, .ProfElm
	ifequal 3, .Dream
	ifequal 4, .Kurt
	ifequal 5, .League
	ifequal 6, .RadioShow
	ifequal 7, .Battling
	ifequal 8, .DaisyTea
	ifequal 9, .Traveled

.Blue:
	farwritetext ChadBlueGossipText
	buttonsound
	jump PhoneScript_HangupText_Male

.Daisy:
	farwritetext ChadDaisyGossipText
	buttonsound
	jump PhoneScript_HangupText_Male

.ProfElm:
	farwritetext ChadProfElmGossipText
	buttonsound
	jump PhoneScript_HangupText_Male

.Dream:
	farwritetext ChadDreamGossipText
	buttonsound
	jump PhoneScript_HangupText_Male

.Kurt:
	farwritetext ChadKurtGossipText
	buttonsound
	jump PhoneScript_HangupText_Male

.League:
	farwritetext ChadLeagueGossipText
	buttonsound
	jump PhoneScript_HangupText_Male

.RadioShow:
	farwritetext ChadRadioShowGossipText
	buttonsound
	jump PhoneScript_HangupText_Male

.Battling:
	farwritetext ChadBattlingGossipText
	buttonsound
	jump PhoneScript_HangupText_Male

.DaisyTea:
	farwritetext ChadDaisyTeaGossipText
	buttonsound
	jump PhoneScript_HangupText_Male

.Traveled:
	farwritetext ChadTravelGossipText
	buttonsound
	jump PhoneScript_HangupText_Male
