local synthFunc = gFunc.LoadFile('common/synth.lua');
local resistFunc = gFunc.LoadFile('common/resist.lua');
local setLeveller = gFunc.LoadFile('common/setLeveller.lua');
local delayCalculator = gFunc.LoadFile('common/delayCalculator.lua');
local weatherFunc = gFunc.LoadFile('common/weather.lua');
local spellInfo = gFunc.LoadFile('common/spellinfo.lua');
local detectSync = gFunc.LoadFile('common/detectSyncChanged.lua')
local bluCheck = gFunc.LoadFile('common/blu/bluCheck.lua')
local aketon = gFunc.LoadFile('common/aketoncheck.lua');
local staffTable = gFunc.LoadFile('common/staffTable.lua');
local quoter = gFunc.LoadFile('common/quoter.lua');

local idleSets      = gFunc.LoadFile('Metzengerstein_107020/sets/blu/idle.lua');
local restSets      = gFunc.LoadFile('Metzengerstein_107020/sets/blu/rest.lua');
local MNDEnfeebleSets    = gFunc.LoadFile('Metzengerstein_107020/sets/blu/MNDEnfeeble.lua');
local stoneskinSets = gFunc.LoadFile('Metzengerstein_107020/sets/blu/stoneskin.lua');
local INTEnfeebleSets    = gFunc.LoadFile('Metzengerstein_107020/sets/blu/INTEnfeeble.lua');
local ELMSets    = gFunc.LoadFile('Metzengerstein_107020/sets/blu/ELM.lua');
local DarkSets    = gFunc.LoadFile('Metzengerstein_107020/sets/blu/dark.lua');
local interruptSets = gFunc.LoadFile('Metzengerstein_107020/sets/blu/interrupt.lua');
local engagedSets   = gFunc.LoadFile('Metzengerstein_107020/sets/blu/engaged.lua');
local cureSets      = gFunc.LoadFile('Metzengerstein_107020/sets/blu/cure.lua');
local divineSets    = gFunc.LoadFile('Metzengerstein_107020/sets/blu/divine.lua');

local resistWaterSets = gFunc.LoadFile('Metzengerstein_107020/sets/resists/water.lua');
local resistIceSets = gFunc.LoadFile('Metzengerstein_107020/sets/resists/ice.lua');

local profile = {};

local sets = {};

local function merge(target, source)
    for k, v in pairs(source) do
        target[k] = v;
    end
end

merge(sets, idleSets);
merge(sets, restSets);
merge(sets, engagedSets);
merge(sets, interruptSets);
merge(sets, MNDEnfeebleSets);
merge(sets, stoneskinSets);
merge(sets, INTEnfeebleSets);
merge(sets, ELMSets);
merge(sets, DarkSets);
merge(sets, cureSets);
merge(sets, divineSets);

merge(sets, resistWaterSets);
merge(sets, resistIceSets);

local fastCast = 0;
profile.Sets = sets;

profile.Packer = {
};

local function debugPrint(...)
    if gSettings.Debug then
        print(...)
    end
end

local casting = false;
local castCount = 0;
local maxCasts = 10;
local currentSpell = 'Pollen';
local buffer  = 1.0;

function practiceBLU(args)
    if casting then
        if args[2] == 'stop' then
            castCount = maxCasts;
            print('\30\68[PracticeBLU] Stopped casting...');
            return;
        end

        print('\30\68[PracticeBLU] Already casting, please wait...')
        return
    elseif args[2] == 'stop' then
        print('\30\68[PracticeBLU] Was not casting...');
        return
    end

    currentSpell = args[2] or currentSpell
    castCount = 0
    casting = true

    local res = AshitaCore:GetResourceManager():GetSpellByName(currentSpell, 0);
    if not res then
        print(string.format('\30\68[PracticeBLU] Could not find spell: %s', currentSpell))
        casting = false
        return
    end

    print(string.format('\30\68[PracticeBLU] Starting practice of %s...', currentSpell))
    castNext(res)
end

function castNext()
    local player = gData.GetPlayer();
    local mp = player.MP;

    local res = AshitaCore:GetResourceManager():GetSpellByName(currentSpell, 0);
    local mpCost = res.ManaCost

    if mp < mpCost then
        casting = false
        AshitaCore:GetChatManager():QueueCommand(1, '/heal')
        print('\30\68[PracticeBLU] Practice finished ~ /heal')
        return
    elseif castCount >= maxCasts then
        casting = false
        print('\30\68[PracticeBLU] Set of 6 done, hit the button again ~ ');
        return;
    end

    -- Calculate delay: (CastTime + RecastDelay) in seconds + buffer
    -- Ashita stores these as units that need * 250 to become milliseconds
    local castTimeSec  = (res.CastTime   * 250) / 1000
    local recastSec    = (res.RecastDelay * 250) / 1000
    local delay        = castTimeSec + recastSec + buffer

    castCount = castCount + 1
    AshitaCore:GetChatManager():QueueCommand(1, string.format('/ma "%s" <me>', currentSpell))

    ashita.tasks.once(delay, castNext)
end

function protect(cmd)
    local tier = 1;
    local player = gData.GetPlayer();
    local playerLevel = player.MainJobSync / 2;

    if (playerLevel >= 75) then tier = 5;
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
    local playerLevel = player.MainJobSync / 2;

    if (playerLevel >= 75) then tier = 5;
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
    local playerLevel = player.MainJobSync / 2;

    if (playerLevel >= 70) then tier = 3;
    elseif (playerLevel >= 56) then tier = 2;
    end

    local spellName = cmd ..  tier;
    AshitaCore:GetChatManager():QueueCommand(1, '/ma ' .. spellName);  -- Or <me> / <stpt> etc.
end

profile.OnLoad = function()
    math.randomseed(os.time());
    gSettings.AllowAddSet = true;

    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /protectra /lac fwd protectra');
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /shellra /lac fwd shellra');

    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /protect /lac fwd protect');
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /shell /lac fwd shell');

    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /raise /lac fwd raise');
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /reraise /lac fwd reraise');

    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /synth /lac fwd synth');
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /resist /lac fwd resist');
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /weather /lac fwd weather');

    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /practiceblu /lac fwd practiceblu');
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /blucheck /lac fwd blucheck')
end

profile.OnUnload = function()
end

profile.HandleCommand = function(args)
    if (#args == 0) then return; end

    local cmd = args[1]:lower();
    if (string.match(cmd, 'protect')) then
        protect(cmd);
    end

    if (string.match(cmd, 'shell')) then
        shell(cmd);
    end

    if (string.match(cmd, 'raise')) then
        raise(cmd);
    end

    if (cmd == 'synth') then
        synthFunc.synth(args);
    end

    if (cmd == 'resist') then
        resistFunc.resist(args);
    end

    if (cmd == 'weather') then
        weatherFunc.Show();
    end

    if (cmd == 'practiceblu') then
        practiceBLU(args);
    end

    if cmd == 'blucheck' then
        bluCheck.check();
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

    if (string.match(action.Name, 'Cure') or string.match(action.Name, 'Curaga')) then
        setLeveller.equipItem('Main', 'Rucke\'s Rung');
        fastCast = 10;
        return;
    end

    fastCast = 0;
end

profile.HandleMidcast = function()
    local action = gData.GetAction()
    if action and action.Name and math.random(100) <= 20 then
        quoter.sayFor(action.Name)
    end

    local MndDebuffs = T{ 'Slow', 'Paralyze', 'Slow II', 'Paralyze II', 'Addle', 'Addle II' };
    local ElementalDebuffs = T{ 'Burn', 'Rasp', 'Drown', 'Choke', 'Frost', 'Shock' };
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