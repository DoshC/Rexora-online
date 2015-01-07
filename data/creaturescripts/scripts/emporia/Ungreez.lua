local name = "Ungreez"
function onKill(cid, target)
if getCreatureName(target) == name then
if(getPlayerStorageValue(cid,TheInquisition.Questline) == 18) then
setPlayerStorageValue(cid,TheInquisition.Questline, 19)
setPlayerStorageValue(cid,TheInquisition.Mission06, 2) -- The Inquisition Questlog- "Mission 6: The Demon Ungreez"
docreaturesay(cid,"You have slain Ungreez.", TALKTYPE_MONSTER_YELL)

end
end
return true
end