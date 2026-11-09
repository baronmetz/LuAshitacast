local synthFunc = gFunc.LoadFile('common/synth.lua');
local resistFunc = gFunc.LoadFile('common/resist.lua');
local setLeveller = gFunc.LoadFile('common/setLeveller.lua');
local delayCalculator = gFunc.LoadFile('common/delayCalculator.lua');
local weatherFunc = gFunc.LoadFile('common/weather.lua');
local spellInfo = gFunc.LoadFile('common/spellinfo.lua');
local canCast = gFunc.LoadFile('common/canCast.lua');
local aketon = gFunc.LoadFile('common/aketoncheck.lua');

local resistWaterSets = gFunc.LoadFile('Metzengerstein_107020/sets/resists/water.lua')

local currentSet = 'Idle';
local profile = {};
local ElementalStaffTable = {
    ['Fire'] = 'Fire Staff',
    ['Ice'] = 'Ice Staff',
    ['Wind'] = 'Wind Staff',
    ['Earth'] = 'Earth Staff',
    ['Thunder'] = 'Thunder Staff',
    ['Water'] = 'Water Staff',
    ['Light'] = 'Light Staff',
    ['Dark'] = 'Dark Staff'
};
local sets = {
    ['Idle'] = {
        Main = 'Decurion\'s Dagger',
        Head = 'Cmp. Eye Circlet',
        Neck = 'Willpower Torque',
        Ear1 = 'Tml. Earring',
        Ear2 = 'Amber Earring',
        Body = 'Wonder Kaftan',
        Hands = 'Wonder Mitts',
        Ring1 = 'Windurstian Ring',
        Ring2 = 'Shell Ring',
        Back = 'Cotton Cape',
        Waist = 'Silver Obi +1',
        Legs = 'Wonder Braccae',
        Feet = 'Seer\'s Pumps +1',
    },
    ['Rest'] = {
        Main = 'Decurion\'s Dagger',
        Head = 'Cmp. Eye Circlet',
        Neck = 'Willpower Torque',
        Ear1 = 'Tml. Earring',
        Ear2 = 'Amber Earring',
        Body = 'Seer\'s Tunic',
        Hands = 'Wonder Mitts',
        Ring1 = 'Windurstian Ring',
        Ring2 = 'Shell Ring',
        Back = 'Cotton Cape',
        Waist = 'Silver Obi +1',
        Legs = 'Wonder Braccae',
        Feet = 'Seer\'s Pumps +1',
    },
};

local fastCast = 0;
profile.Sets = sets;

local function merge(t1, t2)
    for k, v in pairs(t2) do
        t1[k] = v;
    end
end

merge(sets, resistWaterSets);

profile.Packer = {
};

function protect(cmd)
    local tier = 1;
    local player = gData.GetPlayer();
    local playerLevel = player.MainJobSync / 2;

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
    local playerLevel = player.MainJobSync / 2;

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
    local playerLevel = player.MainJobSync / 2;

    if (playerLevel >= 70) then tier = 3;
    elseif (playerLevel >= 56) then tier = 2;
    end

    local spellName = cmd ..  tier;
    AshitaCore:GetChatManager():QueueCommand(1, '/ma ' .. spellName);  -- Or <me> / <stpt> etc.
end

profile.OnLoad = function()
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
    local player = gData.GetPlayer();
    
    if not action or not action.Name then
        return
    end
end

profile.HandleItem = function()
end

profile.HandlePrecast = function()
    local player = gData.GetPlayer();
    local action = gData.GetAction();

    fastCast = 0;
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
        setLeveller.equipItem('Main', ElementalStaffTable[action.Element]);
        setLeveller.equipItem('Sub', 'Raptor Strap +1');
        if (MndDebuffs:contains(action.Name)) then
            setLeveller.equipLevelSet(player, 'MNDEnfeeble', sets);
        else
            setLeveller.equipLevelSet(player, 'INTEnfeeble', sets);
        end
    elseif (action.Skill == 'Elemental Magic') then
        setLeveller.equipItem('Main', ElementalStaffTable[action.Element]);
        setLeveller.equipItem('Sub', 'Raptor Strap +1');
        if (action.Element == 'Light') then
            setLeveller.equipLevelSet(player, 'MNDEnfeeble', sets);
        else
            setLeveller.equipLevelSet(player, 'INTEnfeeble', sets);
        end
    elseif (action.Skill == 'Dark Magic') then
        setLeveller.equipItem('Main', ElementalStaffTable['Dark']);
        setLeveller.equipItem('Sub', 'Raptor Strap +1');
        setLeveller.equipLevelSet(player, 'INTEnfeeble', sets);
    elseif (action.Skill == 'Healing Magic') then
        setLeveller.equipItem('Main', ElementalStaffTable['Light']);
        setLeveller.equipItem('Sub', 'Raptor Strap +1');
        setLeveller.equipLevelSet(player, 'Cure', sets);
    elseif (action.Skill == 'Divine Magic') then
        setLeveller.equipItem('Main', ElementalStaffTable['Light']);
        setLeveller.equipItem('Sub', 'Raptor Strap +1');
        setLeveller.equipLevelSet(player, 'Divine', sets);
    end

    if (string.match(action.Name, 'Regen')) then
        setLeveller.equipItem('Sub', 'Raptor Strap +1');
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