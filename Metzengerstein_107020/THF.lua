local synthFunc = gFunc.LoadFile('common/synth.lua');
local resistFunc = gFunc.LoadFile('common/resist.lua');
local setLeveller = gFunc.LoadFile('common/setLeveller.lua');
local delayCalculator = gFunc.LoadFile('common/delayCalculator.lua');
local weatherFunc = gFunc.LoadFile('common/weather.lua');
local spellInfo = gFunc.LoadFile('common/spellinfo.lua');
local aketon = gFunc.LoadFile('common/aketoncheck.lua');
local staffTable = gFunc.LoadFile('common/staffTable.lua');
local quoter = gFunc.LoadFile('common/quoter.lua');

local idleSets      = gFunc.LoadFile('Metzengerstein_107020/sets/thf/idle.lua');
local engagedSets   = gFunc.LoadFile('Metzengerstein_107020/sets/thf/engaged.lua');
local boltSets   = gFunc.LoadFile('Metzengerstein_107020/sets/thf/bolts.lua');

local profile = {};
local sets = {
};
profile.Sets = sets;

local function merge(target, source)
    for k, v in pairs(source) do
        target[k] = v;
    end
end

merge(sets, idleSets);
merge(sets, engagedSets);
merge(sets, boltSets);

profile.Packer = {
};

local fastCast = 0;

profile.OnLoad = function()
    math.randomseed(os.time());
    gSettings.AllowAddSet = true;

    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /synth /lac fwd synth');
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /resist /lac fwd resist');
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /weather /lac fwd weather');
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /tempEquipSet /lac fwd tempEquipSet');
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /harvest /lac fwd harvest');

    AshitaCore:GetChatManager():QueueCommand(-1, '/bind H /harvest');
end

profile.OnUnload = function()
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind H');
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

    if (cmd == 'tempEquipSet') then
        setLeveller.tempEquipSet(args, sets);
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
    local player = gData.GetPlayer();
    setLeveller.equipLevelSet(player, 'Haste', sets);
end

profile.HandleMidcast = function()
    local MndDebuffs = T{ 'Slow', 'Paralyze', 'Slow II', 'Paralyze II', 'Addle', 'Addle II' };
    local ElementalDebuffs = T{ 'Burn', 'Rasp', 'Drown', 'Choke', 'Frost', 'Shock' };
    local action = gData.GetAction();
    local player = gData.GetPlayer();

    spellInfo.printSpellInfo(action);

    local delay = delayCalculator.calculateDelay(action, fastCast);
    setLeveller.equipInterimLevelSet(player, 'Interrupt', sets, delay);

    if (action.Skill == 'Enfeebling Magic') then
        if (MndDebuffs:contains(action.Name)) then
            setLeveller.equipLevelSet(player, 'MNDEnfeeble', sets);
        else
            setLeveller.equipLevelSet(player, 'MaxINT', sets);
        end
        setLeveller.equipItem('main', staffTable[action.Element]);
    elseif (action.Skill == 'Elemental Magic') then
        if (action.Element == 'Light') then
            setLeveller.equipLevelSet(player, 'MNDEnfeeble', sets);
        else
            setLeveller.equipLevelSet(player, 'MaxINT', sets);
        end
        setLeveller.equipItem('main', staffTable[action.Element]);
    elseif (action.Skill == 'Dark Magic') then
        setLeveller.equipLevelSet(player, 'MaxINT', sets);
        setLeveller.equipItem('main', staffTable['Dark']);
    elseif (string.match(action.Name, 'Cure') or string.match(action.Name, 'Curaga')) then
        setLeveller.equipLevelSet(player, 'Cure', sets);
        setLeveller.equipItem('main', staffTable['Light']);
    elseif (action.Skill == 'Divine Magic') then
        setLeveller.equipLevelSet(player, 'Divine', sets);
        setLeveller.equipItem('main', staffTable['Light']);
    end
    if action.Name == 'Stoneskin' then
        setLeveller.equipLevelSet(player, 'Stoneskin', sets);
    end

    if action.Name == "Sneak" then
        setLeveller.equipItem("Feet", "Dream Boots +1");
        setLeveller.equipItem('Back', 'Skulker\'s Cape');
    end
    if action.Name == "Invisible" then
        setLeveller.equipItem("Hands", "Dream Mittens +1");
        setLeveller.equipItem('Back', 'Skulker\'s Cape');
    end

    local env = gData.GetEnvironment()

    if (action.Name == 'Drain' or action.Name == 'Aspir') then
        if env.WeatherElement == 'Dark' then
            setLeveller.equipItem('Main', "Diabolos\'s Pole");
        end
        if env.DayElement == 'Dark' then
            setLeveller.equipItem('Ring2', 'Diabolos\'s Ring');
        end
    end
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