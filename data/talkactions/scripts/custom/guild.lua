function onSay(cid, words, param, channel)
	doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Guild management guide!")
	doShowTextDialog(cid, 5958, "•How to create a guild? \n\nHello there! Please follow this steps in order to create a guild in Emporia!\n\n•Level requirement: Lv 100\n¤Log into your account at Emporia.vapus.net\n¤Go to the Guilds sections IN YOUR ACCOUNT and press create guild\n¤After that you will be redirected to your guild page!\n¤Now you can invite people (Make sure they are offline).. upload guild image, and more! \n\n•MAKE SURE TO BE OFFLINE BEFORE DOING THIS! ELSE IT WILL NOT WORK")
	return true
end