local synthFunc = gFunc.LoadFile('common/synth.lua');
local resistFunc = gFunc.LoadFile('common/resist.lua');
local setLeveller = gFunc.LoadFile('common/setLeveller.lua');
local delayCalculator = gFunc.LoadFile('common/delayCalculator.lua');
local weatherFunc = gFunc.LoadFile('common/weather.lua');
local spellInfo = gFunc.LoadFile('common/spellinfo.lua');
local detectSync = gFunc.LoadFile('common/detectSyncChanged.lua')
local staffTable = gFunc.LoadFile('common/staffTable.lua');
local aketon = gFunc.LoadFile('common/aketoncheck.lua');
local quoter = gFunc.LoadFile('common/quoter.lua');

local idleSets      = gFunc.LoadFile('Metzengerstein_107020/sets/cor/idle.lua');
local engagedSets   = gFunc.LoadFile('Metzengerstein_107020/sets/cor/engaged.lua');
local restSets      = gFunc.LoadFile('Metzengerstein_107020/sets/cor/rest.lua');

local profile = {};
local sets = {
    ['Harvest'] = {
        Body = 'Field Tunica',
        Hands = 'Field Gloves',
        Legs = 'Field Hose',
        Feet = 'Field Boots',
    },
};

local function merge(t1, t2)
    for k, v in pairs(t2) do
        t1[k] = v;
    end
end

profile.Sets = sets;

profile.Packer = {
};

local function debugPrint(...)
    if gSettings.Debug then
        print(...)
    end
end

merge(sets, idleSets);
merge(sets, engagedSets);
merge(sets, restSets);

profile.OnLoad = function()
    math.randomseed(os.time());
    gSettings.AllowAddSet = true;

    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /synth /lac fwd synth');
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /resist /lac fwd resist');
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /weather /lac fwd weather');
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /harvest /lac fwd harvest');

    AshitaCore:GetChatManager():QueueCommand(-1, '/bind ^H /harvest');
end

profile.OnUnload = function()
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind ^H');
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

    if (cmd == 'harvest') then
        setLeveller.harvest(sets);
    end
end

profile.HandleDefault = function()
    local player = gData.GetPlayer();
    if (player.Status == 'Engaged') then
        setLeveller.equipLevelSet(player, 'Engaged', sets);
    elseif (player.Status == 'Resting') then
        setLeveller.equipLevelSet(player, 'Rest', sets);
    else
        if aketon.isInWindy() then
            setLeveller.equipItem('Body', 'Federation Aketon');
        elseif aketon.isInSandy() then
            setLeveller.equipItem('Body', 'Kingdom Aketon');
        else
            setLeveller.equipLevelSet(player, resistFunc.idleSet, sets);
        end
    end
end

profile.HandleAbility = function()
    local action = gData.GetAction()
    if action and action.Name then
        quoter.sayFor(action.Name)
    end
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
    local action = gData.GetAction()
    if action and action.Name then
        quoter.sayFor(action.Name)
    end
end

return profile;