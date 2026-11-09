local setLeveller = {};

function setLeveller.getLevelledSet(player, set)
    if (player.MainJobLevel == player.MainJobSync) then
        return set
    elseif (player.MainJobSync >= 70) then
        return set .. 70;
    elseif (player.MainJobSync >= 60) then
        return set .. 60;
    elseif (player.MainJobSync >= 50) then
        return set .. 50;
    elseif (player.MainJobSync >= 40) then
        return set .. 40;
    elseif (player.MainJobSync >= 30) then
        return set .. 30;
    elseif (player.MainJobSync >= 20) then
        return set .. 20;
    elseif (player.MainJobSync >= 10) then
        return set .. 10;
    else
        return set;
    end
end

local function debugPrint(...)
    if gSettings.Debug then
        print(...)
    end
end

local TP_LOCK = 300

function setLeveller.shouldLockWeapons(player)
    player = player or gData.GetPlayer()
    if not player then return false end
    return (player.TP or 0) >= TP_LOCK
end

-- Copy a set without Main/Sub so EquipSet cannot wipe TP
function setLeveller.withoutWeapons(set)
    if not set then return set end
    local copy = {}
    for k, v in pairs(set) do
        if k ~= 'Main' and k ~= 'Sub' and k ~= 'main' and k ~= 'sub' and k ~= 'Range' and k ~= 'range' then
            copy[k] = v
        end
    end
    return copy
end

function setLeveller.equipLevelSet(player, set, sets)
    local levelledSet = setLeveller.getLevelledSet(player, set);

    local gear = sets[levelledSet]
    if not gear then return end

    if setLeveller.shouldLockWeapons(player) then
        gear = setLeveller.withoutWeapons(gear)
    end

    if (levelledSet ~= currentSet) then
        debugPrint(chat.header('Equipment Change:') .. chat.message(levelledSet));
        currentSet = levelledSet;
    end
    gFunc.EquipSet(gear);
end

function setLeveller.equipInterimLevelSet(player, set, sets, delay)
    local levelledSet = setLeveller.getLevelledSet(player, set);
    
    local gear = sets[levelledSet]
    if not gear then return end

    if setLeveller.shouldLockWeapons(player) then
        gear = setLeveller.withoutWeapons(gear)
    end

    debugPrint(chat.header('Interim Equipment Change:') .. chat.message(levelledSet) .. chat.message(' for ' .. delay .. 's.'));
    gFunc.SetMidDelay(delay);
    gFunc.InterimEquipSet(gear);
end

function setLeveller.equipItem(location, item)
    if (location == 'Main' or location == 'Sub')
        and setLeveller.shouldLockWeapons() then
        return
    end

    local slot = gData.GetEquipment()[location]
    local current = slot and slot.Name or nil
    if current ~= item then
        debugPrint(chat.header('Equipment Change:') .. chat.message(item));
        gFunc.Equip(location, item);
    end
end

function setLeveller.equipInterimItem(location, item, delay)
    if (location == 'Main' or location == 'Sub')
        and setLeveller.shouldLockWeapons() then
        return
    end
    debugPrint(chat.header('Interim Equipment Change:') .. chat.message(item) .. chat.message(' for ' .. delay .. 's.'));
    gFunc.SetMidDelay(delay);
    gFunc.InterimEquip(location, item);
end

return setLeveller;