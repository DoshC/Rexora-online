function onThink(interval, lastExecution)
local texts = {
	["Trainers"] = {{x=32366, y=32236, z=7}, CONST_ME_MAGIC_BLUE, TEXTCOLOR_LIGHTBLUE},
	["Magic"] = {{x=32200, y=32207, z=7}, CONST_ME_MAGIC_RED, TEXTCOLOR_RED},
	["Distance"] = {{x=32205, y=32207, z=7}, CONST_ME_MAGIC_GREEN, TEXTCOLOR_GREEN},
	["Club"] = {{x=32199, y = 32211, z=7}, CONST_ME_MAGIC_BLUE, TEXTCOLOR_YELLOW},
	["Sword"] = {{x=32202, y=32211, z=7}, CONST_ME_MAGIC_BLUE, TEXTCOLOR_YELLOW},
	["Axe"] = {{x=32205, y=32211, z=7}, CONST_ME_MAGIC_BLUE, TEXTCOLOR_YELLOW}
}

for text, param in pairs(texts) do
    doSendAnimatedText(param[1], text, param[3])
    doSendMagicEffect(param[1], param[2])
    end
    return TRUE
end