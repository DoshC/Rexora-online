STORAGE_CHARTAN = 1
STORAGE_ZALAMON = 2
STORAGE_CLAY = 3
STORAGE_EARTH = 4
STORAGE_WOOD = 5
STORAGE_SCEPTRE = 6
STORAGE_BOSS = 7
STORAGE_END = 8
STORAGE_TELEPORT = 9
STORAGE_ZLAK = 10
STORAGE_NOBLE = 11
STORAGE_MAGISTRATUS = 12
STORAGE_GATE = 13
STORAGE_GHOST = 14
STORAGE_ZUMTAH = 15
STORAGE_ZIZZLE = 16
STORAGE_LAST = 17
STORAGE_DRAGON = 18
PRISON_POS = {x = 33362, y = 31205, z = 8}
STORAGE_THE_KEEPER = 19
STORAGE_OUTFIT = 20
POS_LAST_ROOM = {x = 33360, y = 31406, z = 10}
POS_PRISON_EXIT = {x = 33385, y = 31112, z = 8}
POS_LEVER_TELEPORT = {
	{x = 33078, y = 31080, z = 13},
	{x = 33082, y = 31110, z = 2}
}
SOUL_PARTS, ZALAMON_FORMS, ZLAK_MISSIONS, REAGENTS, BOSSES, PRIZE = {
	["spite of the emperor"] = 120,
	["wrath of the emperor"] = 121,
	["scorn of the emperor"] = 122,
	["fury of the emperor"] = 123
},
{
	["snake god essence"] = {
		TEXT = "IT'S NOT THAT EASY MORTALS! FEEL THE POWER OF THE GOD!",
		NEW_FORM = "snake thing"
	},
	["snake thing"] = {
		TEXT = "NOOO! NOW YOU HERETICS WILL FACE MY GODLY WRATH!",
		NEW_FORM = "lizard abomination"
	},
	["lizard abomination"] = {
		TEXT = "YOU ... WILL ... PAY WITH ETERNITY ... OF AGONY!",
		NEW_FORM = "mutated zalamon"
	}
},
{
	["lizard magistratus"] = {
		MAX_STORAGE_VALUE = 4,
		STORAGE_ZLAK = 1
	},
	["lizard noble"] = {
		MAX_STORAGE_VALUE = 6,
		STORAGE_ZLAK = 2
	}
},
{
	[2549] = {
		ITEMEX = {
			false,
			12322
		},
		TEXT = "You dig out a handful of ordinary clay.",
		STORAGE = STORAGE_CLAY,
		ADDITEM = 12285
	},
	[5710] = {
		ITEMEX = {
			true,
			101
		},
		TEXT = "You dig out a handful of earth from this sacred place.",
		STORAGE = STORAGE_EARTH,
		ADDITEM = 12297
	},
	[2553] = {
		ITEMEX = {
			false,
			12296
		},
		TEXT = "The cracked part of the table lets you cut out a large chunk of wood with your pick.",
		STORAGE = STORAGE_WOOD,
		ADDITEM = 12295
	}
},
{
	[105] = "scorn of the emperor",
	[106] = "spite of the emperor",
	[107] = "fury of the emperor",
	[108] = "wrath of the emperor"
},
{
	[113] = 12642,
	[114] = 12643,
	[115] = 12645
}
function storageDoors(cid, uid, direction, storage, value)
	if(getPlayerStorageValue(cid, storage) >= value) then
		if(direction == "vertical") then
			if(getCreaturePosition(cid).y > getThingPosition(uid).y) then
				doTeleportThing(cid, {x = getPlayerPosition(cid).x, y = getPlayerPosition(cid).y - 2, z = getPlayerPosition(cid).z})
			else
				doTeleportThing(cid, {x = getPlayerPosition(cid).x, y = getPlayerPosition(cid).y + 2, z = getPlayerPosition(cid).z})
			end
		elseif(direction == "horizontal") then
			if(getCreaturePosition(cid).y > getThingPosition(uid).y) then
				doTeleportThing(cid, {x = getPlayerPosition(cid).x, y = getPlayerPosition(cid).y - 2, z = getPlayerPosition(cid).z})
			else
				doTeleportThing(cid, {x = getPlayerPosition(cid).x, y = getPlayerPosition(cid).y + 2, z = getPlayerPosition(cid).z})
			end
		end
	else
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "The doors are sealed against unwanted intruders.")
	end
	return true
end

function doPlayerTeleportIfStorage(cid, storage, value, newpos, oldpos)
	if(getPlayerStorageValue(cid, storage) >= value) then
		doTeleportThing(cid, newpos)
		doSendMagicEffect(newpos, CONST_ME_TELEPORT)
	else
		return oldpos and doTeleportThing(cid, oldpos) or true
	end
	return true
end