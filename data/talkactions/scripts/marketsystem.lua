local config = {
        levelRequiredToAdd = 20,
        maxOffersPerPlayer = 20,
        SendOffersOnlyInPZ = true,
        blocked_items = {2165, 2152, 2148, 2160, 2166, 8918, 2167, 2168, 2169, 2202, 2203, 2204, 2205, 2206, 2207, 2208, 2209, 2210, 2211, 2212, 2213, 2214, 2215, 2343, 2433, 2640, 6132, 6300, 6301, 9932, 9933, 11138, 7735, 10518, 10521, 2471, 8982, 9778, 9777, 9776 }
        }

        -- CREATED AUCTION SYSTEM BY vDK EDITED FOR MARKET SYSTEM BY SZMUGROSS
function onSay(cid, words, param, channel)
        if(param == '') then
                doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Command requires param.")
                return true
        end
 
        local t = string.explode(param, ",")
        if(t[1] == "add") then
                if((not t[2]) or (not t[3]) or (not t[4])) then
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Command requires param.")
                        return true
                end
 
                if(not tonumber(t[3]) or (not tonumber(t[4]))) then
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You don't set valid price or items count.")
                        return true
                end
 
                if(string.len(t[3]) > 7 or (string.len(t[4]) > 3)) then
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "This price or item count is too high.")
                        return true
                end
 
                local item = getItemIdByName(t[2], false)
                if(not item) then
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Item wich such name does not exists.")
                        return true
                end
 
                if(getPlayerLevel(cid) < config.levelRequiredToAdd) then
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You don't have required (" .. config.levelRequiredToAdd .. ") level.")
                        return true
                end
 
                if(isInArray(config.blocked_items, item)) then
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "This item is blocked.")
                        return true
                end
 
                if(getPlayerItemCount(cid, item) < (tonumber(t[4]))) then
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Sorry, you don't have this item(s).")
                        return true
                end
 
                local check = db.getResult("SELECT `id` FROM `auction_system` WHERE `player` = " .. getPlayerGUID(cid) .. ";")
                if(check:getID() == -1) then
                elseif(check:getRows(true) >= config.maxOffersPerPlayer) then
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Sorry you can't add more offers (max. " .. config.maxOffersPerPlayer .. ")")
                        return true
                end
 
                if(config.SendOffersOnlyInPZ) then    
                        if(not getTilePzInfo(getPlayerPosition(cid))) then
                                doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You must be in PZ area when you add offert to database.")
                                return true
                        end
                end
 
                if(tonumber(t[4]) < 1 or (tonumber(t[3]) < 1)) then
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You have to type a number higher than 0.")
                        return true
                end
 
                if(t[5] == "yes") then
                local itemcount, costgp = math.floor(t[4]), math.floor(t[3])
                local any = 0
                    doPlayerRemoveItem(cid, item, itemcount)
                    db.executeQuery("INSERT INTO `auction_system` (`player`, `item_name`, `item_id`, `count`, `cost`, `date`, `playername`) VALUES (" .. any .. ", \"" .. t[2] .. "\", " .. getItemIdByName(t[2]) .. ", " .. itemcount .. ", " .. costgp ..", " .. os.time() .. ", " ..getPlayerGUID(cid).. ")")
                    doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You successfully add " .. itemcount .." x " .. t[2] .." for " .. costgp * itemcount .. " gps to offerts database.")
                else
                    local itemcount7, costgp2 = math.floor(t[4]), math.floor(t[3])
                    doPlayerRemoveItem(cid, item, itemcount7)
                    db.executeQuery("INSERT INTO `auction_system` (`player`, `item_name`, `item_id`, `count`, `cost`, `date`, `playername`) VALUES (" .. getPlayerGUID(cid) .. ", \"" .. t[2] .. "\", " .. getItemIdByName(t[2]) .. ", " .. itemcount7 .. ", " .. costgp2 ..", " .. os.time() .. ", " ..getPlayerGUID(cid).. ")")
                    doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You successfully add " .. itemcount7 .." x " .. t[2] .." for " .. costgp2 * itemcount7 .. " gps to offerts database.")
                    return true
                end
        end
 
        if(t[1] == "buy") then
        
                if((not t[2]) or (not t[3])) then
                    doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Command requires param.")
                return true
                end
                
                if(not tonumber(t[2])) then
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Wrong ID.")
                        return true
                end
                
 
                local buy = db.getResult("SELECT * FROM `auction_system` WHERE `id` = " .. (tonumber(t[2])) .. ";")
                if(buy:getID() ~= -1) then
                        if(getPlayerMoney(cid) < (buy:getDataInt("cost") * tonumber(t[3]))) then
                                doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You don't have enoguh GP.")
                                buy:free()
                                return true
                        end
                        
                        if(tonumber(t[3]) < 1) then
                            doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You must write count.")
                        return true
                        end
                        
                        if(tonumber(t[3]) > buy:getDataInt("count")) then
                            doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You can buy only "..buy:getDataInt("count").." this item!")
                            buy:free()
                        return true
                        end
 
                        if(getPlayerName(cid) == getPlayerNameByGUID(buy:getDataInt("playername"))) then
                                doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Sorry, you can't buy your own items.")
                                buy:free()
                                return true
                        end
 
                        if(getPlayerFreeCap(cid) < getItemWeightById(buy:getDataInt("item_id"), tonumber(t[3])))then
                                doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You try to buy a "..tonumber(t[3]).." " .. buy:getDataString("item_name") .. ". It weight " .. getItemWeightById(buy:getDataInt("item_id"), tonumber(t[3])) .. " cap oz. and you have only " .. getPlayerFreeCap(cid) .. " oz. free capacity. Put some items to depot and try again.")
                                buy:free()
                                return true
                        end
                        
                        if(config.SendOffersOnlyInPZ) then    
                            if(not getTilePzInfo(getPlayerPosition(cid))) then
                                doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You must be in PZ area when you add offert to database.")
                            return true
                            end
                        end
 
                        if(isItemStackable((buy:getDataString("item_id")))) then
                                doPlayerAddItem(cid, buy:getDataString("item_id"), t[3])
                        else
                                for i = 1, tonumber(t[3]) do
                                        doPlayerAddItem(cid, buy:getDataString("item_id"), 1)
                                end
                        end
                            if(tonumber(t[3]) == buy:getDataInt("count")) then
                                doPlayerRemoveMoney(cid, (buy:getDataInt("cost") * buy:getDataInt("count")))
                                db.executeQuery("DELETE FROM `auction_system` WHERE `id` = " .. t[2] .. ";")
                                doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You bought " .. buy:getDataInt("count") .. " ".. buy:getDataString("item_name") .. " for " .. buy:getDataInt("cost") * tonumber(t[3]) .. " gps!")
                                db.executeQuery("UPDATE `players` SET `auction_balance` = `auction_balance` + " .. buy:getDataInt("cost") .. " WHERE `id` = " .. buy:getDataInt("playername") .. ";")
                                buy:free()
                            else
                                doPlayerRemoveMoney(cid, (buy:getDataInt("cost") * tonumber(t[3])))
                                db.executeQuery("UPDATE `auction_system` SET `count` = `count` - " .. t[3] .. " WHERE `id` = " .. t[2] .. ";")
                                doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You bought " .. t[3] .. " ".. buy:getDataString("item_name") .. " for " .. buy:getDataInt("cost") * tonumber(t[3]) .. " gps!")
                                db.executeQuery("UPDATE `players` SET `auction_balance` = `auction_balance` + " .. buy:getDataInt("cost") * tonumber(t[3]) .. " WHERE `id` = " .. buy:getDataInt("playername") .. ";")
                                buy:free()
                            end
                else
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Wrong ID.")
                end
        end
 
        if(t[1] == "remove") then
                if((not tonumber(t[2]))) then
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Wrong ID.")
                        return true
                end
 
                                if(config.SendOffersOnlyInPZ) then    
                                        if(not getTilePzInfo(getPlayerPosition(cid))) then
                                                doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You must be in PZ area when you remove offerts from database.")
                                                return true
                                        end
                end
 
                local delete = db.getResult("SELECT * FROM `auction_system` WHERE `id` = " .. (tonumber(t[2])) .. ";")        
                if(delete:getID() ~= -1) then
                        if(getPlayerGUID(cid) == delete:getDataInt("playername")) then
                                db.executeQuery("DELETE FROM `auction_system` WHERE `id` = " .. t[2] .. ";")
                                if(isItemStackable(delete:getDataString("item_id"))) then
                                        doPlayerAddItem(cid, delete:getDataString("item_id"), delete:getDataInt("count"))
                                else
                                        for i = 1, delete:getDataInt("count") do
                                                doPlayerAddItem(cid, delete:getDataString("item_id"), 1)
                                        end
                                end
 
                                doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Your offert has been deleted from offerts database.")
                        else
                                doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "This is not your offert!")
                        end
                delete:free()
                else
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Wrong ID.")
                end
        end
 
        if(t[1] == "withdraw") then
                local balance = db.getResult("SELECT `auction_balance` FROM `players` WHERE `id` = " .. getPlayerGUID(cid) .. ";")
                if(balance:getDataInt("auction_balance") < 1) then
                        doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You don't have money on your auction balance.")
                        balance:free()
                        return true
                end
 
                doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You got " .. balance:getDataInt("auction_balance") .. " gps from auction system!")
                doPlayerAddMoney(cid, balance:getDataInt("auction_balance"))
                db.executeQuery("UPDATE `players` SET `auction_balance` = '0' WHERE `id` = " .. getPlayerGUID(cid) .. ";")
                balance:free()
        end
        
        if (t[1] == "buyitem") then
                        if((not t[2]) or (not t[3]) or (not t[4])) then
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Command requires param.")
                        return true
                end
 
                if(not tonumber(t[3]) or (not tonumber(t[4]))) then
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You don't set valid price or items count.")
                        return true
                end
 
                if(string.len(t[3]) > 7 or (string.len(t[4]) > 3)) then
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "This price or item count is too high.")
                        return true
                end
 
                local item = getItemIdByName(t[2], false)
                if(not item) then
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Item wich such name does not exists.")
                        return true
                end
 
                if(getPlayerLevel(cid) < config.levelRequiredToAdd) then
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You don't have required (" .. config.levelRequiredToAdd .. ") level.")
                        return true
                end
 
                if(isInArray(config.blocked_items, item)) then
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "This item is blocked.")
                        return true
                end
 
 
                local check = db.getResult("SELECT `id` FROM `auction_systembuy` WHERE `player` = " .. getPlayerGUID(cid) .. ";")
                if(check:getID() == -1) then
                elseif(check:getRows(true) >= config.maxOffersPerPlayer) then
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Sorry you can't add more offers (max. " .. config.maxOffersPerPlayer .. ")")
                        return true
                end
                
                if(getPlayerMoney(cid) < (tonumber(t[4]) * tonumber(t[3]))) then
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You don't have enoguh GP.")
                return true
                end
 
                if(config.SendOffersOnlyInPZ) then    
                        if(not getTilePzInfo(getPlayerPosition(cid))) then
                                doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You must be in PZ area when you add offert to database.")
                                return true
                        end
                end
 
                if(tonumber(t[4]) < 1 or (tonumber(t[3]) < 1)) then
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You have to type a number higher than 0.")
                        return true
                end
 
                if(t[5] == "yes") then
                local itemcount, costgp = math.floor(t[4]), math.floor(t[3])
                local any = 0
                    doPlayerRemoveMoney(cid, (itemcount * costgp))
                    db.executeQuery("INSERT INTO `auction_systembuy` (`player`, `item_name`, `item_id`, `count`, `cost`, `date`, `playername`) VALUES (" .. any .. ", \"" .. t[2] .. "\", " .. getItemIdByName(t[2]) .. ", " .. itemcount .. ", " .. costgp ..", " .. os.time() .. ", " ..getPlayerGUID(cid).. ")")
                    doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You successfully add " .. itemcount .." " .. t[2] .." for " .. costgp * itemcount .. " gps to offerts database.")
                else
                    local itemcount7, costgp2 = math.floor(t[4]), math.floor(t[3])
                    doPlayerRemoveMoney(cid, (itemcount7 * costgp2))
                    db.executeQuery("INSERT INTO `auction_systembuy` (`player`, `item_name`, `item_id`, `count`, `cost`, `date`, `playername`) VALUES (" .. getPlayerGUID(cid) .. ", \"" .. t[2] .. "\", " .. getItemIdByName(t[2]) .. ", " .. itemcount7 .. ", " .. costgp2 ..", " .. os.time() .. ", " ..getPlayerGUID(cid).. ")")
                    doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You successfully add " .. itemcount7 .." " .. t[2] .." for " .. costgp2 * itemcount7 .. " gps to offerts database.")
                return true
                end
        end
        
        if(t[1] == "sell") then
        
            if((not t[2]) or (not t[3])) then
                    doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Command requires param.")
                return true
                end
                            
                if(not tonumber(t[2])) then
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Wrong ID.")
                        return true
                end            
 
                local buy = db.getResult("SELECT * FROM `auction_systembuy` WHERE `id` = " .. (tonumber(t[2])) .. ";")
                if(buy:getID() ~= -1) then
                
                        if(not isItemStackable((buy:getDataString("item_id")))) and (tonumber(t[3]) > 1 ) then
                            doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You can sell max 1 per once time.")
                        return true
                        end            
                        
                        if(tonumber(t[3]) < 1 or tonumber(t[3]) > 100 ) then
                            doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You must write count 1-100.")
                        return true
                        end
                        
                        
                        if(tonumber(t[3]) > buy:getDataInt("count")) then
                            doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You can sell only "..buy:getDataInt("count").." this item!")
                            buy:free()
                        return true
                        end
 
                        if(getPlayerName(cid) == getPlayerNameByGUID(buy:getDataInt("playername"))) then
                                doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Sorry, you can't sell item to your auction.")
                                buy:free()
                                return true
                        end
                        local item = buy:getDataString("item_id")
                        
                        if(getPlayerItemCount(cid, item) < (tonumber(t[3]))) then
                            doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Sorry, you don't have this item(s).")
                        return true
                        end
                        
                        if(config.SendOffersOnlyInPZ) then    
                            if(not getTilePzInfo(getPlayerPosition(cid))) then
                                doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You must be in PZ area when you remove offerts from database.")
                            return true
                             end
                        end
                        
                        if(tonumber(t[3]) > buy:getDataInt("count")) then
                            doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You can sell only "..buy:getDataInt("count").." this item!")
                            buy:free()
                        return true
                        end
 
                        local idplayer = buy:getDataString("playername")
                        if(isItemStackable((buy:getDataString("item_id")))) then
                            local ls = db.getResult("SELECT `sid` FROM `player_depotitems` WHERE `player_id` = "..idplayer.." ORDER BY `sid` DESC LIMIT 1")
                            db.executeQuery("INSERT INTO `player_depotitems` (`player_id`, `sid`, `pid`, `itemtype`, `count`, `attributes`) VALUES ("..idplayer..", "..(ls:getDataInt("sid")+1)..", 102, "..item..", "..tonumber(t[3])..", '"..(tonumber(t[3]) > 1 and string.format("%x",tonumber(t[3])) or '').."')")
                        else
                                local ls2 = db.getResult("SELECT `sid` FROM `player_depotitems` WHERE `player_id` = "..idplayer.." ORDER BY `sid` DESC LIMIT 1")
                                for i = 1, tonumber(t[3]) do
                                        db.executeQuery("INSERT INTO `player_depotitems` (`player_id`, `sid`, `pid`, `itemtype`, `count`, `attributes`) VALUES ("..idplayer..", "..(ls2:getDataInt("sid")+1)..", 102, "..item..", "..tonumber(t[3])..", '"..(tonumber(t[3]) > 1 and string.format("%x", tonumber(t[3])) or '').."')")
                                end
                        end
                            if(tonumber(t[3]) == buy:getDataInt("count")) then
                                doPlayerRemoveItem(cid, buy:getDataString("item_id"), buy:getDataInt("count"))
                                db.executeQuery("DELETE FROM `auction_systembuy` WHERE `id` = " .. t[2] .. ";")
                                doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You sell " .. buy:getDataInt("count") .. " ".. buy:getDataString("item_name") .. " for " .. buy:getDataInt("cost") * buy:getDataInt("count") .. " gps!")
                                db.executeQuery("UPDATE `players` SET `auction_balance` = `auction_balance` + " .. buy:getDataInt("cost") .. " WHERE `id` = " .. getPlayerGUID(cid) ..";")
                                buy:free()
                            else
                                doPlayerRemoveItem(cid, buy:getDataString("item_id"), tonumber(t[3]))
                                db.executeQuery("UPDATE `auction_systembuy` SET `count` = `count` - " .. t[3] .. " WHERE `id` = " .. t[2] .. ";")
                                doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You sell " .. t[3] .. " ".. buy:getDataString("item_name") .. " for " .. buy:getDataInt("cost") * tonumber(t[3]) .. " gps!")
                                db.executeQuery("UPDATE `players` SET `auction_balance` = `auction_balance` + " .. buy:getDataInt("cost") * tonumber(t[3]) .. " WHERE `id` = " .. getPlayerGUID(cid).. ";")
                                buy:free()
                            end
                else
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Wrong ID.")
                end
        end
        
        if(t[1] == "canceladd") then
                if((not tonumber(t[2]))) then
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Wrong ID.")
                        return true
                end
 
                                if(config.SendOffersOnlyInPZ) then    
                                        if(not getTilePzInfo(getPlayerPosition(cid))) then
                                                doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You must be in PZ area when you remove offerts from database.")
                                                return true
                                        end
                end
 
                local delete = db.getResult("SELECT * FROM `auction_systembuy` WHERE `id` = " .. (tonumber(t[2])) .. ";")        
                if(delete:getID() ~= -1) then
                        if(getPlayerGUID(cid) == delete:getDataInt("playername")) then
                                db.executeQuery("DELETE FROM `auction_systembuy` WHERE `id` = " .. t[2] .. ";")
                                if(isItemStackable(delete:getDataString("item_id"))) then
                                        db.executeQuery("UPDATE `players` SET `auction_balance` = `auction_balance` + " .. delete:getDataInt("cost") * delete:getDataInt("count") .. " WHERE `id` = " .. delete:getDataInt("playername") .. ";")
                                else
                                        for i = 1, delete:getDataInt("count") do
                                                db.executeQuery("UPDATE `players` SET `auction_balance` = `auction_balance` + " .. delete:getDataInt("cost") * delete:getDataInt("count") .. " WHERE `id` = " .. delete:getDataInt("playername") .. ";")
                                        end
                                end
                                local itemids = delete:getDataInt("item_id")
                                doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Your offert "..delete:getDataInt("count").. "x " ..getItemNameById(itemids).. " has been deleted from offerts database.")
                        else
                                doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "This is not your offert!")
                        end
                delete:free()
                else
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Wrong ID.")
                end
        end
            
return true
end