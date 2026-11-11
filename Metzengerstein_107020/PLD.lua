local synthFunc = gFunc.LoadFile('common/synth.lua');
local resistFunc = gFunc.LoadFile('common/resist.lua');
local setLeveller = gFunc.LoadFile('common/setLeveller.lua');
local delayCalculator = gFunc.LoadFile('common/delayCalculator.lua');
local weatherFunc = gFunc.LoadFile('common/weather.lua');
local spellInfo = gFunc.LoadFile('common/spellinfo.lua');
local canCast = gFunc.LoadFile('common/canCast.lua');
local aketon = gFunc.LoadFile('common/aketoncheck.lua');
local staffTable = gFunc.LoadFile('common/staffTable.lua');
local quoter = gFunc.LoadFile('common/quoter.lua');

local idleSets      = gFunc.LoadFile('Metzengerstein_107020/sets/pld/idle.lua');
local restSets      = gFunc.LoadFile('Metzengerstein_107020/sets/pld/rest.lua');
local MNDEnfeebleSets    = gFunc.LoadFile('Metzengerstein_107020/sets/pld/MNDEnfeeble.lua');
local stoneskinSets = gFunc.LoadFile('Metzengerstein_107020/sets/pld/stoneskin.lua');
local INTEnfeebleSets    = gFunc.LoadFile('Metzengerstein_107020/sets/pld/INTEnfeeble.lua');
local ELMSets    = gFunc.LoadFile('Metzengerstein_107020/sets/pld/ELM.lua');
local DarkSets    = gFunc.LoadFile('Metzengerstein_107020/sets/pld/Dark.lua');
local interruptSets = gFunc.LoadFile('Metzengerstein_107020/sets/pld/interrupt.lua');
local engagedSets   = gFunc.LoadFile('Metzengerstein_107020/sets/pld/engaged.lua');
local cureSets      = gFunc.LoadFile('Metzengerstein_107020/sets/pld/cure.lua');
local fastCastSets     = gFunc.LoadFile('Metzengerstein_107020/sets/pld/fastCast.lua');
local divineSets    = gFunc.LoadFile('Metzengerstein_107020/sets/pld/divine.lua');
local devotionSets  = gFunc.LoadFile('Metzengerstein_107020/sets/pld/devotion.lua');

local resistWaterSets = gFunc.LoadFile('Metzengerstein_107020/sets/resists/water.lua')
local resistIceSets = gFunc.LoadFile('Metzengerstein_107020/sets/resists/ice.lua')

local profile = {};

local sets = {
    ['Idle'] = {
        Main = 'Ryl.Arc. Sword',
        Sub = 'Aspis +1',
        Range = 'Self Bow +1',
        Ammo = 'Wooden Arrow',
        Head = 'Ryl.Ftm. Bandana',
        Neck = 'Justice Badge',
        Body = 'Lgn. Harness',
        Hands = 'Ryl.Ftm. Gloves',
        Ring1 = 'Windurstian Ring',
        Ring2 = 'San d\'Orian Ring',
        Back = 'Rabbit Mantle',
        Waist = 'Heko Obi +1',
        Legs = 'Lth. Trousers +1',
        Feet = 'Ryl.Ftm. Boots',
    },
};

local function merge(t1, t2)
    for k, v in pairs(t2) do
        t1[k] = v;
    end
end

merge(sets, idleSets);
merge(sets, restSets);
merge(sets, MNDEnfeebleSets);
merge(sets, stoneskinSets);
merge(sets, INTEnfeebleSets);
merge(sets, ELMSets);
merge(sets, DarkSets);
merge(sets, interruptSets);
merge(sets, engagedSets);
merge(sets, cureSets);
merge(sets, fastCastSets);
merge(sets, divineSets);
merge(sets, devotionSets);

merge(sets, resistWaterSets);
merge(sets, resistIceSets);

local fastCast = 0;
profile.Sets = sets;

profile.Packer = {
};

function protect(cmd)
    local tier = 1;
    local player = gData.GetPlayer();
    local playerLevel = player.MainJobSync;

    if (playerLevel >= 75 and cmd == 'protectra') then tier = 5;
    elseif (playerLevel >= 63) then tier = 4;
    elseif (playerLevel >= 47) then tier = 3;
    elseif (playerLevel >= 27) then tier = 2;
    end

    local spellName = cmd ..  tier;
    AshitaCore:GetChatManager():QueueCommand(1, '/ma ' .. spellName);  -- Or <me> / <stpt> etc.
end

function shell(cmd)
    local tier = 1;
    local player = gData.GetPlayer();
    local playerLevel = player.MainJobSync;

    if (playerLevel >= 75 and cmd == 'shellra') then tier = 5;
    elseif (playerLevel >= 68) then tier = 4;
    elseif (playerLevel >= 57) then tier = 3;
    elseif (playerLevel >= 37) then tier = 2;
    end

    local spellName = cmd ..  tier;
    AshitaCore:GetChatManager():QueueCommand(1, '/ma ' .. spellName);  -- Or <me> / <stpt> etc.
end

function raise(cmd)
    local tier = 1;
    local player = gData.GetPlayer();
    local playerLevel = player.MainJobSync;

    if (playerLevel >= 70) then tier = 3;
    elseif (playerLevel >= 56) then tier = 2;
    end

    local spellName = cmd ..  tier;
    AshitaCore:GetChatManager():QueueCommand(1, '/ma ' .. spellName);  -- Or <me> / <stpt> etc.
end

profile.OnLoad = function()
    math.randomseed(os.time());
    gSettings.AllowAddSet = true;
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /protect /lac fwd protect');
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /protectra /lac fwd protectra');
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /shell /lac fwd shell');
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /shellra /lac fwd shellra');
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /raise /lac fwd raise');
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /reraise /lac fwd reraise');

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
    if (string.match(cmd, 'protect')) then
        protect(cmd);
        return;
    end

    if (string.match(cmd, 'shell')) then
        shell(cmd);
        return;
    end

    if (string.match(cmd, 'raise')) then
        raise(cmd);
        return;
    end

    if (cmd == 'synth') then
        synthFunc.synth(args);
        return;
    end

    if (cmd == 'resist') then
        resistFunc.resist(args);
        return;
    end

    if (cmd == 'weather') then
        weatherFunc.Show();
        return;
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
    local action = gData.GetAction();

    setLeveller.equipLevelSet(player, 'FastCast', sets);
    if (player.MainJobSync == 75) then
        fastCast = 4;
        if (string.match(action.Name, 'Cure') or string.match(action.Name, 'Curaga')) then
            setLeveller.equipItem('Main', 'Rucke\'s Rung');
            fastCast = 12;
        end
    else
        fastCast = 0;
    end
end

profile.HandleMidcast = function()
    local MndDebuffs = T{ 'Slow', 'Paralyze', 'Slow II', 'Paralyze II', 'Addle', 'Addle II' };
    local ElementalDebuffs = T{ 'Burn', 'Rasp', 'Drown', 'Choke', 'Frost', 'Shock' };
    local statusCleaners = T{ 'Erase', 'Paralyna', 'Silena', 'Blindna', 'Poisona', 'Cursna', 'Stona', 'Viruna' };

    local action = gData.GetAction();
    local player = gData.GetPlayer();

    spellInfo.printSpellInfo(action);

    local delay = delayCalculator.calculateDelay(action, fastCast);
    setLeveller.equipInterimLevelSet(player, 'Interrupt', sets, delay);

    if (action.Skill == 'Enfeebling Magic') then
        setLeveller.equipItem('Main', staffTable[action.Element]);
        setLeveller.equipItem('Sub', 'Raptor Strap +1');
        if (MndDebuffs:contains(action.Name)) then
            setLeveller.equipLevelSet(player, 'MNDEnfeeble', sets);
        else
            setLeveller.equipLevelSet(player, 'INTEnfeeble', sets);
        end
    elseif (action.Skill == 'Elemental Magic') then
        setLeveller.equipItem('Main', staffTable[action.Element]);
        setLeveller.equipItem('Sub', 'Raptor Strap +1');
        if (action.Element == 'Light') then
            setLeveller.equipLevelSet(player, 'Divine', sets);
        else
            setLeveller.equipLevelSet(player, 'ELM', sets);
        end
    elseif (action.Skill == 'Dark Magic') then
        setLeveller.equipItem('Main', staffTable['Dark']);
        setLeveller.equipItem('Sub', 'Raptor Strap +1');
        setLeveller.equipLevelSet(player, 'Dark', sets);
    elseif (action.Skill == 'Healing Magic') then
        setLeveller.equipItem('Main', staffTable['Light']);
        setLeveller.equipItem('Sub', 'Raptor Strap +1');
        setLeveller.equipLevelSet(player, 'Cure', sets);

        if (statusCleaners:contains(action.Name)) then
            setLeveller.equipItem('Ring2', 'Virology Ring');
        end
    elseif (action.Skill == 'Divine Magic') then
        setLeveller.equipItem('Main', staffTable['Light']);
        setLeveller.equipItem('Sub', 'Raptor Strap +1');
        setLeveller.equipLevelSet(player, 'Divine', sets);
    end

    if (string.match(action.Name, 'Regen')) then
        setLeveller.equipItem('Main', 'Rucke\'s Rung');
        setLeveller.equipItem('Sub', 'Raptor Strap +1');
    end

    if string.match(action.Name, 'Bar')  then
        setLeveller.equipItem('Body', 'Blessed Bliaut');
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