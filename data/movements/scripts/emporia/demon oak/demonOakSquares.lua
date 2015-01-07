local voices = {
	'Release me and you will be rewarded greatefully!',
	'What is this? Demon Legs lying here? Someone might have lost them!',
	'I\'m trapped, come here and free me fast!!',
	'I can bring your beloved back from the dead, just release me!',
	'What a nice shiny golden armor. Come to me and you can have it!',
	'Find a way in here and release me! Pleeeease hurry!',
	'You can have my demon set, if you help me get out of here!'
}

local startUid = 9000
function onStepIn(cid, item, position, fromPosition)
	local player = isPlayer(cid)
	if not player then
		return true
	end

	local status = math.max(getPlayerStorageValue(cid,DemonOak.Squares), 0)
	if item.uid - startUid == status + 1 then
		setPlayerStorageValue(cid,DemonOak.Squares, status + 1)
		doCreatureSay(cid,voices[math.random(#voices)], TALKTYPE_MONSTER_YELL, false, cid, DEMON_OAK_POSITION)
	end
	return true
end