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
    if not gear then
        print(chat.header('Set not found: ') .. chat.message(levelledSet) .. chat.message(', trying base set ' .. set));
        gear = sets[set];
        if not gear then
            printer(chat.header('Set not found: ') .. chat.message(set));
            return
        end
    end

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

function setLeveller.tempEquipSet(args, sets)
    if not args or not args[2] then
        print("Usage: /tempEquipSet <SetName> [seconds]");
        return;
    end

    local player = gData.GetPlayer();
    if not player then return; end

    local setName = args[2];
    local seconds = tonumber(args[3]) or 10;

    if not args[3] then
        print("No time entered, defaulting to 10s");
    end

    setLeveller.equipLevelSet(player, setName, sets);
    gFunc.LockSet();

    ashita.tasks.once(seconds, function()
        gFunc.UnlockSet();
    end);
end

function setLeveller.harvest(sets)
    local target = gData.GetTarget()
    if not target or not target.Name then
        print("No target.")
        return
    end

    local name = target.Name
    local tool

    if name == "Harvesting Point" then
        tool = "Sickle"
    elseif name == "Logging Point" then
        tool = "Hatchet"
    elseif name == "Mining Point" or name == "Excavation Point" then
        tool = "Pickaxe"
    else
        print("Not a gathering point: " .. name)
        return
    end

    -- Equip Harvesting set (level-synced) and lock it briefly
    local player = gData.GetPlayer()
    setLeveller.equipLevelSet(player, "Harvesting", sets)
    gFunc.LockSet()

    -- Use the tool on the current target
    AshitaCore:GetChatManager():QueueCommand(1, '/item "' .. tool .. '" <t>')

    -- Unlock after a short delay (adjust if you want it longer)
    ashita.tasks.once(3, function()
        gFunc.UnlockSet()
    end)
end

return setLeveller;