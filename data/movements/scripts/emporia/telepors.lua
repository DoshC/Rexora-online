local config = {
	[3950]  = {removeId = 2350, destination = {x=33182, y=32714, z=14}, exitDestination = {x=33231, y=32705, z=8}}, -- from Morguthis Boss
	[3951]  = {removeId = 2351, destination = {x=33349, y=32827, z=14}, exitDestination = {x=33282, y=32744, z=8}}, -- from Thalas Boss
	[3952]  = {removeId = 2353, destination = {x=33174, y=32934, z=15}, exitDestination = {x=33250, y=32832, z=8}}, -- from Mahrdis Boss
	[3953]  = {removeId = 2352, destination = {x=33186, y=33012, z=14}, exitDestination = {x=33025, y=32868, z=8}}, -- from Omruc Boss
	[3954]  = {removeId = 2348, destination = {x=33041, y=32774, z=14}, exitDestination = {x=33133, y=32642, z=8}}, -- from Rahemos Boss
	[3955]  = {removeId = 2354, destination = {x=33126, y=32591, z=15}, exitDestination = {x=33131, y=32566, z=8}}, -- from  Dipthrah Boss
	[3956]  = {removeId = 2349, destination = {x=33145, y=32665, z=15}, exitDestination = {x=33206, y=32592, z=8}} -- from Vashresamun Boss
}

function onStepIn(creature, item, position, fromPosition)
	local player = isPlayer(cid)
	if not player then
		return true
	end

	local teleport = config[item.uid]
	if not doPlayerRemoveItem(cid,teleport.removeId, 1) then
		doTeleportThing(cid,teleport.exitDestination)
		doSendMagicEffect(getPlayerPosition(cid),CONST_ME_TELEPORT)
	else
		doTeleportThing(cid,teleport.destination)
		doSendMagicEffect(getPlayerPosition(cid),CONST_ME_TELEPORT)
	end
	return true
end