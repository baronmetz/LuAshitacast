local synthFunc = gFunc.LoadFile('common/synth.lua');
local resistFunc = gFunc.LoadFile('common/resist.lua');
local setLeveller = gFunc.LoadFile('common/setLeveller.lua');
local delayCalculator = gFunc.LoadFile('common/delayCalculator.lua');
local weatherFunc = gFunc.LoadFile('common/weather.lua');

local profile = {};
local sets = {
    ['Idle'] = {
        Main = 'Wakizashi',
        Sub = 'Blind Knife',
        Range = 'Clothespole',
        Ammo = 'Lugworm',
        Head = 'Horror Head II',
        Neck = 'Justice Badge',
        Ear1 = 'Tml. Earring',
        Ear2 = 'Amber Earring',
        Body = 'Power Gi',
        Hands = 'Dream Mittens +1',
        Ring1 = 'Balance Ring',
        Ring2 = 'Balance Ring',
        Back = 'Rabbit Mantle',
        Legs = 'Dream Trousers +1',
        Feet = 'Dream Boots +1',
    },
};
profile.Sets = sets;

profile.Packer = {
};

local function debugPrint(...)
    if gSettings.Debug then
        print(...)
    end
end

local hasteValues = {
    ['Haste'] = 0,
    ['Haste60'] = 0,
};

function getHaste(player)
    local levelledSet = setLeveller.getLevelledSet(player, 'Haste');
    return hasteValues[levelledSet];
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
        setLeveller.equipLevelSet(player, 'Engaged', sets);
    elseif (player.Status == 'Resting') then
        setLeveller.equipLevelSet(player, 'Rest', sets);
    else
        setLeveller.equipLevelSet(player, resistFunc.idleSet, sets);
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