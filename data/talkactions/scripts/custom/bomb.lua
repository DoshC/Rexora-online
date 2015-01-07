function getPlayersInRange(position, radiusx, radiusy)
	local creaturesList = {}
	for x = -radiusx, radiusx do
		for y = -radiusy, radiusy do
			if not (x == 0 and y == 0) then
				local creature = getTopCreature({x = position.x+x, y = position.y+y, z = position.z})
				if creature.type == 1 then
					table.insert(creaturesList, creature.uid)
				end
			end
		end
	end

	local creature = getTopCreature(position)
	if creature.type == 1 then
		if not(table.find(creaturesList, creature.uid)) then
			table.insert(creaturesList, creature.uid)
		end
	end
    return creaturesList
end

function isPositionInArray(haystack, needle)
	for i = 1, #haystack do
		if haystack[i].x == needle.x and haystack[i].y == needle.y and haystack[i].z == needle.z then
			return true
		end
	end
	return false
end

local t = {
	from = {x=32015, y=32348, z=7},
	to = {x=32029, y=32358, z=7},
	storage = {
		placed = 10001,
		max = 10002,
		radius = 10003
	},
	delay = 3000,
	bombID = 10570,
	effect = CONST_ME_FIREAREA,
	blockID = 9421,
	text = "BOOM!",
	temple = {x=32349, y=32222, z=7},
	exceptions = {
		{x=32015, y=32348, z=7},
		{x=32016, y=32348, z=7},
		{x=32015, y=32349, z=7},
		
		{x=32015, y=32358, z=7},
		{x=32015, y=32357, z=7},
		{x=32016, y=32358, z=7},
		
		{x=32029, y=32348, z=7},
		{x=32029, y=32349, z=7},
		{x=32028, y=32348, z=7},
		
		{x=32029, y=32358, z=7},
		{x=32029, y=32357, z=7},
		{x=32028, y=32358, z=7}
	}
}
function reset()
	local dummy = doCreateItem(10570, 1, {x=32010,y=32351,z=7})
	for x = t.from.x, t.to.x do
		for y = t.from.y, t.to.y do
			local pos = {x=x,y=y,z=t.from.z}
			local i1, i2, i3  = getTileItemById(pos, 8304).uid, getTileItemById(pos, 8306).uid, getTileItemById(pos, 8310).uid
			if i1 > 0 then
				doRemoveItem(i1)
			end
			if i2 > 0 then
				doRemoveItem(i2)
			end
			if i3 > 0 then
				doRemoveItem(i3)
			end
			if queryTileAddThing(dummy, pos, 4) == RETURNVALUE_NOERROR and not isPositionInArray(t.exceptions, pos) then
				doCreateItem(t.blockID, 1, pos)
			end
		end
	end
	doRemoveItem(dummy)
end

local function boom(pos, cid)
	local v = getTileItemById(pos, t.bombID).uid
	if isPlayer(cid) and isInRange(getThingPos(cid), t.from, t.to) then
		setPlayerStorageValue(cid, t.storage.placed, getPlayerStorageValue(cid, t.storage.placed) - 1)
		doCreatureSay(cid, t.text, TALKTYPE_ORANGE_2, false, nil, pos)
		doSendMagicEffect(pos, t.effect)
		local c = getTopCreature(pos).uid
		if isPlayer(c) and isInRange(getThingPos(c), t.from, t.to) then
			doSendMagicEffect(pos, CONST_ME_GIFT_WRAPS)
			doTeleportThing(c, t.temple)
			doSendMagicEffect(t.temple, CONST_ME_MORTAREA)
			local n1, n2 = getPlayerName(c), getPlayerName(cid)
			doBroadcastMessage(n1==n2 and n1 .. " killed " .. (getPlayerSex(c) == 0 and "her" or "him") .. "self!" or n1 .. " was killed by " .. n2 .. " in bomberman!", MESSAGE_STATUS_WARNING)
			local a = getPlayersInRange({x=32022, y=32353, z=7}, 7, 5)
			if #a < 2 then
				doBroadcastMessage(getPlayerName(a[1]) .. " has won the bomberman match!", MESSAGE_STATUS_WARNING)
				doPlayerAddExperience(a[1], 15000)
				doTeleportThing(a[1], t.temple)
				doSendMagicEffect(t.temple, CONST_ME_FIREWORK_RED)
				reset()
				reset()
			end
		else
			local b = getTileItemById(pos, t.blockID).uid
			if b > 0 then
				doSendMagicEffect(pos, CONST_ME_BLOCKHIT)
				doRemoveItem(b)
				local r = math.random(10)
				if r < 4 then
					doCreateItem(r==1 and 8304 or r==2 and 8306 or r==3 and 8310, 1, _pos)
				end
			end
		end
		local N, E, W, S, l = 1, 1, 1, 1, getPlayerStorageValue(cid, t.storage.radius)
		function loopDir(dir)
			local _pos = {x=pos.x+(dir=="E" and E or dir=="W" and -W or 0), y=pos.y+(dir=="N" and -N or dir=="S" and S or 0), z=pos.z}
			if queryTileAddThing(v, _pos, 4) == RETURNVALUE_NOERROR or getTileItemById(_pos, t.blockID).uid > 0 then
				doSendMagicEffect(_pos, t.effect)
				local c = getTopCreature(_pos).uid
				if isPlayer(c) and isInRange(getThingPos(c), t.from, t.to) then
					doSendMagicEffect(_pos, CONST_ME_GIFT_WRAPS)
					doTeleportThing(c, t.temple)
					doSendMagicEffect(t.temple, CONST_ME_MORTAREA)
					local n1, n2 = getPlayerName(c), getPlayerName(cid)
					doBroadcastMessage(n1==n2 and n1 .. " killed " .. (getPlayerSex(c) == 0 and "her" or "him") .. "self in bomberman!" or n1 .. " was killed by " .. n2 .. " in bomberman!", MESSAGE_STATUS_WARNING)
					local a = getPlayersInRange({x=32022, y=32353, z=7}, 7, 5)
					if #a < 2 then
						doBroadcastMessage(getPlayerName(a[1]) .. " has won the bomberman match!", MESSAGE_STATUS_WARNING)
						doPlayerAddExperience(a[1], 15000)
						doTeleportThing(a[1], t.temple)
						doSendMagicEffect(t.temple, CONST_ME_FIREWORK_RED)
						reset()
						reset()
						return "endgame"
					end
				else
					local b = getTileItemById(_pos, t.blockID).uid
					if b > 0 then
						doSendMagicEffect(_pos, CONST_ME_BLOCKHIT)
						doRemoveItem(b)
						local r = math.random(10)
						if r < 4 then
							doCreateItem(r==1 and 8304 or r==2 and 8306 or r==3 and 8310, 1, _pos)
						end
						return false
					end
				end
			elseif queryTileAddThing(v, _pos, 4) == 3 then
				return false
			end
			return true
		end
		while N <= l do
			local q = loopDir("N")
			if q == "endgame" then
				return doRemoveItem(v, 1)
			elseif not q then
				break
			else
				N = N + 1
			end
		end
		while E <= l do
			local q = loopDir("E")
			if q == "endgame" then
				return doRemoveItem(v, 1)
			elseif not q then
				break
			else
				E = E + 1
			end
		end
		while W <= l do
			local q = loopDir("W")
			if q == "endgame" then
				return doRemoveItem(v, 1)
			elseif not q then
				break
			else
				W = W + 1
			end
		end
		while S <= l do
			local q = loopDir("S")
			if q == "endgame" then
				return doRemoveItem(v, 1)
			elseif not q then
				break
			else
				S = S + 1
			end
		end
	end
	doRemoveItem(v, 1)
end
function onSay(cid, words, param, channel)
	if isInRange(getThingPos(cid), t.from, t.to) then
		setPlayerStorageValue(cid, t.storage.placed, math.max(getPlayerStorageValue(cid, t.storage.placed), 0))
		setPlayerStorageValue(cid, t.storage.max, math.max(getPlayerStorageValue(cid, t.storage.max), 1))
		setPlayerStorageValue(cid, t.storage.radius, math.max(getPlayerStorageValue(cid, t.storage.radius), 1))
		if getPlayerStorageValue(cid, t.storage.placed) < getPlayerStorageValue(cid, t.storage.max) then
			doCreateItem(t.bombID, 1, getThingPos(cid))
			addEvent(boom, t.delay, getThingPos(cid), cid)
			setPlayerStorageValue(cid, t.storage.placed, getPlayerStorageValue(cid, t.storage.placed) + 1)
		end
		return true
	end
end