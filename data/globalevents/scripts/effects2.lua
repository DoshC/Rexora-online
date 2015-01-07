function onThink(interval, lastExecution)
local texts = {
    ["Trainers "] = {{x=32372, y=32236, z=7}, CONST_ME_MAGIC_BLUE, TEXTCOLOR_LIGHTBLUE}
}

for text, param in pairs(texts) do
    doSendAnimatedText(param[1], text, param[3])
    doSendMagicEffect(param[1], param[2])
    end
    return TRUE
end