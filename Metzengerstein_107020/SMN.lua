local synthFunc = gFunc.LoadFile('common/synth.lua');
local resistFunc = gFunc.LoadFile('common/resist.lua');
local setLeveller = gFunc.LoadFile('common/setLeveller.lua');
local delayCalculator = gFunc.LoadFile('common/delayCalculator.lua');
local weatherFunc = gFunc.LoadFile('common/weather.lua');
local practiceSMN = gFunc.LoadFile('common/smn/practiceSMN.lua')
local aketon = gFunc.LoadFile('common/aketoncheck.lua');
local spellInfo = gFunc.LoadFile('common/spellinfo.lua');
local staffTable = gFunc.LoadFile('common/staffTable.lua');

local idleSets = gFunc.LoadFile('Metzengerstein_107020/sets/smn/idle.lua');
local restSets = gFunc.LoadFile('Metzengerstein_107020/sets/smn/rest.lua');
local engagedSets = gFunc.LoadFile('Metzengerstein_107020/sets/smn/engaged.lua');
local darkSets = gFunc.LoadFile('Metzengerstein_107020/sets/smn/dark.lua');
local ELMSets = gFunc.LoadFile('Metzengerstein_107020/sets/smn/ELM.lua');
local INTEnfeebleSets = gFunc.LoadFile('Metzengerstein_107020/sets/smn/INTEnfeeble.lua');
local MNDEnfeebleSets = gFunc.LoadFile('Metzengerstein_107020/sets/smn/MNDEnfeeble.lua');
local CureSets = gFunc.LoadFile('Metzengerstein_107020/sets/smn/cure.lua');
local InterruptSets = gFunc.LoadFile('Metzengerstein_107020/sets/smn/interrupt.lua');
local avatarSets = gFunc.LoadFile('Metzengerstein_107020/sets/smn/avatars.lua');

local resistWaterSets = gFunc.LoadFile('Metzengerstein_107020/sets/resists/water.lua');

local currentSet = 'Idle';

local profile = {};
local sets = {
};

local fastCast = 0;
profile.Sets = sets;

local function merge(t1, t2)
    for k, v in pairs(t2) do
        t1[k] = v;
    end
end

merge(sets, idleSets);
merge(sets, restSets);
merge(sets, engagedSets);
merge(sets, darkSets);
merge(sets, ELMSets);
merge(sets, INTEnfeebleSets);
merge(sets, MNDEnfeebleSets);
merge(sets, CureSets);
merge(sets, InterruptSets);
merge(sets, resistWaterSets);
merge(sets, avatarSets);

profile.Packer = {
};

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

    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /practiceSMN /lac fwd practicesmn')
end

profile.OnUnload = function()
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

    if (cmd == 'practicesmn') then
        practiceSMN.handleCommand(args);
        return;
    end
end

profile.HandleDefault = function()
    local player = gData.GetPlayer();
    local pet = gData.GetPet();
    if (player.Status == 'Engaged') then
        setLeveller.equipLevelSet(player, 'Engaged', sets);

        if (pet ~= nil) then
            setLeveller.equipLevelSet(player, pet.Name, sets);
        end
    elseif (player.Status == 'Resting') then
        setLeveller.equipLevelSet(player, 'Rest', sets);
    else
        if aketon.isInWindy() then
            setLeveller.equipItem('Body', 'Federation Aketon');
        elseif aketon.isInSandy() then
            setLeveller.equipItem('Body', 'Kingdom Aketon');
        else
            setLeveller.equipLevelSet(player, resistFunc.idleSet, sets);

            if (pet ~= nil) then
                setLeveller.equipLevelSet(player, pet.Name, sets);
            end
        end
    end
end

profile.HandleAbility = function()
end

profile.HandleItem = function()
end

profile.HandlePrecast = function()
    local player = gData.GetPlayer();
    setLeveller.equipLevelSet(player, 'FastCast', sets);
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
end

return profile;