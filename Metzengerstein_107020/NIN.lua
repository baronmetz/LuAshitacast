local synthFunc = gFunc.LoadFile('common/synth.lua');
local resistFunc = gFunc.LoadFile('common/resist.lua');
local setLeveller = gFunc.LoadFile('common/setLeveller.lua');
local delayCalculator = gFunc.LoadFile('common/delayCalculator.lua');
local weatherFunc = gFunc.LoadFile('common/weather.lua');
local spellInfo = gFunc.LoadFile('common/spellinfo.lua');
local aketon = gFunc.LoadFile('common/aketoncheck.lua');
local staffTable = gFunc.LoadFile('common/staffTable.lua');
local quoter = gFunc.LoadFile('common/quoter.lua');

local profile = {};

local sets = {
    ['Idle'] = {
        Main = 'Flame Sword',
        Sub = 'Decurion\'s Dagger',
        Range = 'Self Bow +1',
        Head = 'Lizard Helm +1',
        Neck = 'Bloodbead Amulet',
        Ear1 = 'Beetle Earring +1',
        Ear2 = 'Beetle Earring +1',
        Body = 'Fine Jerkin',
        Hands = 'Ryl.Ftm. Gloves',
        Ring1 = 'Courage Ring +1',
        Ring2 = 'Courage Ring +1',
        Back = 'Rabbit Mantle',
        Waist = 'Warrior\'s Belt +1',
        Legs = 'Lizard Trousers',
        Feet = 'Lizard Ledelsens',
    },
    ['Idle20'] = {
        Main = 'Flame Sword',
        Sub = 'Decurion\'s Dagger',
        Range = 'Self Bow +1',
        Head = 'Lizard Helm +1',
        Neck = 'Bloodbead Amulet',
        Ear1 = 'Bone Earring +1',
        Ear2 = 'Bone Earring +1',
        Body = 'Fine Jerkin',
        Hands = 'Lizard Gloves',
        Ring1 = 'Courage Ring +1',
        Ring2 = 'Courage Ring +1',
        Back = 'Rabbit Mantle',
        Waist = 'Warrior\'s Belt +1',
        Legs = 'Lizard Trousers',
        Feet = 'Lizard Ledelsens',
    },
};
profile.Sets = sets;

profile.Packer = {
};

local fastCast = 0;

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