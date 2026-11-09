local synthFunc = gFunc.LoadFile('common/synth.lua');
local resistFunc = gFunc.LoadFile('common/resist.lua');
local setLeveller = gFunc.LoadFile('common/setLeveller.lua');
local delayCalculator = gFunc.LoadFile('common/delayCalculator.lua');
local weatherFunc = gFunc.LoadFile('common/weather.lua');
local spellInfo = gFunc.LoadFile('common/spellinfo.lua');
local canCast = gFunc.LoadFile('common/canCast.lua');
local aketon = gFunc.LoadFile('common/aketoncheck.lua');
local practiceBRD = gFunc.LoadFile('common/brd/practiceBRD.lua');
local staffTable = gFunc.LoadFile('common/staffTable.lua');

local idleSets      = gFunc.LoadFile('Metzengerstein_107020/sets/brd/idle.lua');
local restSets      = gFunc.LoadFile('Metzengerstein_107020/sets/brd/rest.lua');
local engagedSets   = gFunc.LoadFile('Metzengerstein_107020/sets/brd/engaged.lua');
local interruptSets = gFunc.LoadFile('Metzengerstein_107020/sets/brd/interrupt.lua');
local instrumentSets = gFunc.LoadFile('Metzengerstein_107020/sets/brd/instruments.lua');

local resistWaterSets = gFunc.LoadFile('Metzengerstein_107020/sets/resists/water.lua');

local profile = {};
local sets = {
};

local function merge(target, source)
    for k, v in pairs(source) do
        target[k] = v;
    end
end

merge(sets, idleSets);
merge(sets, restSets);
merge(sets, engagedSets);
merge(sets, interruptSets);
merge(sets, resistWaterSets);
merge(sets, instrumentSets);

local fastCast = 0;
profile.Sets = sets;

profile.Packer = {
};

profile.OnLoad = function()
    gSettings.AllowAddSet = true;

    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /synth /lac fwd synth');
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /resist /lac fwd resist');
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /weather /lac fwd weather');

    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /practice /lac fwd practice')
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

    if (cmd == 'practice') then
        practiceBRD.handleCommand(args);
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
end

profile.HandleItem = function()
end

profile.HandlePrecast = function()
    local player = gData.GetPlayer();
    local action = gData.GetAction();

    if (string.match(action.Name, 'Cure') or string.match(action.Name, 'Curaga')) then
        setLeveller.equipItem('Main', 'Rucke\'s Rung');
        fastCast = 10;
        return;
    end

    fastCast = 0;
end

profile.HandleMidcast = function()
    local action = gData.GetAction();
    local player = gData.GetPlayer();

    spellInfo.printSpellInfo(action);

    local delay = delayCalculator.calculateDelay(action, fastCast);
    setLeveller.equipInterimLevelSet(player, 'Interrupt', sets, delay);

    if (action.Skill == 'Singing') then
        setLeveller.equipLevelSet(player, 'Singing', sets);
    end
    if (action.Type == 'Bard Song') then
        if (string.match(action.Name, 'Minuet')) then
            setLeveller.equipLevelSet(player, 'Minuet', sets);
        elseif (string.match(action.Name, 'Mambo')) then
            setLeveller.equipLevelSet(player, 'Mambo', sets);
        elseif (string.match(action.Name, 'March')) then
            setLeveller.equipLevelSet(player, 'March', sets);
        elseif (string.match(action.Name, 'Minne')) then
            setLeveller.equipLevelSet(player, 'Minne', sets);
        elseif (string.match(action.Name, 'Threnody')) then
            setLeveller.equipLevelSet(player, 'Threnody', sets);
        elseif (string.match(action.Name, 'Lullaby')) then
            setLeveller.equipLevelSet(player, 'Lullaby', sets);
        elseif (string.match(action.Name, 'Ballad')) then
            setLeveller.equipLevelSet(player, 'Ballad', sets);
        elseif (string.match(action.Name, 'Requiem')) then
            setLeveller.equipLevelSet(player, 'Requiem', sets);
        elseif (string.match(action.Name, 'Paeon')) then
            setLeveller.equipLevelSet(player, 'Paeon', sets);
        elseif (string.match(action.Name, 'Carol')) then
            setLeveller.equipLevelSet(player, 'Carol', sets);
        elseif (string.match(action.Name, 'Madrigal')) then
            setLeveller.equipLevelSet(player, 'Madrigal', sets);
        elseif (string.match(action.Name, 'Elegy')) then
            setLeveller.equipLevelSet(player, 'Elegy', sets);
        elseif (string.match(action.Name, 'Etude')) then
            setLeveller.equipLevelSet(player, 'Etude', sets);
        end
    end

    if (action.Name == "Sneak") then
        setLeveller.equipItem("Feet", "Dream Boots +1");
    end
    if (action.Name == "Invisible") then
        setLeveller.equipItem("Hands", "Dream Mittens +1");
    end
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()
end

return profile;