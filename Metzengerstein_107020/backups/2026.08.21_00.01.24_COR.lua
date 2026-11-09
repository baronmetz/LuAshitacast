local synthFunc = gFunc.LoadFile('common/synth.lua');
local resistFunc = gFunc.LoadFile('common/resist.lua');
local setLeveller = gFunc.LoadFile('common/setLeveller.lua');
local delayCalculator = gFunc.LoadFile('common/delayCalculator.lua');
local weatherFunc = gFunc.LoadFile('common/weather.lua');
local spellInfo = gFunc.LoadFile('common/spellinfo.lua');
local detectSync = gFunc.LoadFile('common/detectSyncChanged.lua')

local profile = {};
local sets = {
};
profile.Sets = sets;

profile.Packer = {
};

local function debugPrint(...)
    if gSettings.Debug then
        print(...)
    end
end

function equipLevelSet(player, set)
    local levelledSet = setLeveller.getLevelledSet(player, set);
    if (levelledSet ~= currentSet) then
        debugPrint(chat.header('Equipment Change:') .. chat.message(levelledSet));
        currentSet = levelledSet;
    end
    gFunc.EquipSet(sets[levelledSet]);
end

function equipInterimLevelSet(player, set, delay)
    local levelledSet = setLeveller.getLevelledSet(player, set);
    debugPrint(chat.header('Interim Equipment Change:') .. chat.message(levelledSet) .. chat.message(' for ' .. delay .. 's.'));
    gFunc.SetMidDelay(delay);
    gFunc.InterimEquipSet(sets[levelledSet]);
end

function equipItem(location, item)
    debugPrint(chat.header('Equipment Change:') .. chat.message(item));
    gFunc.Equip(location, item);
end

function equipInterimItem(location, item, delay)
    debugPrint(chat.header('Interim Equipment Change:') .. chat.message(item) .. chat.message(' for ' .. delay .. 's.'));
    gFunc.SetMidDelay(delay);
    gFunc.InterimEquip(location, item);
end

profile.OnLoad = function()
    gSettings.AllowAddSet = true;

    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /synth /lac fwd synth');
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /resist /lac fwd resist');
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /weather /lac fwd weather');
end

profile.OnUnload = function()
end

profile.HandleCommand = function(args)
    if (#args == 0) then return; end

    local cmd = args[1]:lower();

    if (cmd == 'synth') then
        synthFunc.synth(args);
    end

    if (cmd == 'resist') then
        resistFunc.resist(args);
    end

    if (cmd == 'weather') then
        weatherFunc.Show();
    end
end

profile.HandleDefault = function()
    local player = gData.GetPlayer();
    if (player.Status == 'Engaged') then
        equipLevelSet(player, 'Engaged');
    elseif (player.Status == 'Resting') then
        equipLevelSet(player, 'Rest');
    else
        equipLevelSet(player, resistFunc.idleSet);
    end
end

profile.HandleAbility = function()
end

profile.HandleItem = function()
end

profile.HandlePrecast = function()
end

profile.HandleMidcast = function()
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()
end

return profile;