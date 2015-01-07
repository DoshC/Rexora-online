local messages = {
	"The OTX Server (Emporia)",
	"Want to save your progress? Use this command: !saveme",
	"List of commands: !commands, !spells, !aol, !bless, !stamina, !changender, !soft, !firewalker, !buy."
}

local i = 0
function onThink(interval, lastExecution)
local message = messages[(i % #messages) + 1]
    doBroadcastMessage("Information: " .. message .. "", MESSAGE_STATUS_CONSOLE_BLUE)
    i = i + 1
    return TRUE
end