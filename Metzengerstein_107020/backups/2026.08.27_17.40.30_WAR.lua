local synthFunc = gFunc.LoadFile('common/synth.lua');
local resistFunc = gFunc.LoadFile('common/resist.lua');
local setLeveller = gFunc.LoadFile('common/setLeveller.lua');
local delayCalculator = gFunc.LoadFile('common/delayCalculator.lua');
local weatherFunc = gFunc.LoadFile('common/weather.lua');
local spellInfo = gFunc.LoadFile('common/spellinfo.lua');
local canCast = gFunc.LoadFile('common/canCast.lua');
local aketon = gFunc.LoadFile('common/aketoncheck.lua')

local profile = {};
local sets = {
    ['Idle'] = {
        Main = 'Rusty Greatsword',
        Range = 'Self Bow +1',
        Head = 'Horror Head II',
        Neck = 'Justice Badge',
        Body = 'Dream Robe +1',
        Hands = 'Dream Mittens +1',
        Ring2 = 'Windurstian Ring',
        Back = 'Rabbit Mantle',
        Legs = 'Dream Trousers +1',
        Feet = 'Dream Boots +1',
    },
};

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
local currentSet = 'Idle';

local hasteValues = {
    ['Haste'] = 7,
    ['Haste10'] = 0,
    ['Haste20'] = 0,
    ['Haste30'] = 0,
    ['Haste40'] = 0,
    ['Haste50'] = 0,
    ['Haste60'] = 0,
    ['Haste70'] = 7,
};

function getHaste(player)
    local levelledSet = setLeveller.getLevelledSet(player, 'Haste');
    return hasteValues[levelledSet];
end

profile.Sets = sets;

profile.Packer = {
};

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
        else
            setLeveller.equipLevelSet(player, 'Idle', sets);
        end
    end
end

profile.HandleAbility = function()
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

    local haste = getHaste(player);
    local delay = delayCalculator.calculateDelay(action, haste);
    setLeveller.equipInterimLevelSet(player, 'Interrupt', sets, delay);

    if (action.Skill == 'Enfeebling Magic') then
        if (MndDebuffs:contains(action.Name)) then
            setLeveller.equipLevelSet(player, 'MNDEnfeeble', sets);
        else
            setLeveller.equipLevelSet(player, 'MaxINT', sets);
        end
        setLeveller.equipItem('main', ElementalStaffTable[action.Element]);
    elseif (action.Skill == 'Elemental Magic') then
        if (action.Element == 'Light') then
            setLeveller.equipLevelSet(player, 'MNDEnfeeble', sets);
        else
            setLeveller.equipLevelSet(player, 'MaxINT', sets);
        end
        setLeveller.equipItem('main', ElementalStaffTable[action.Element]);
    elseif (action.Skill == 'Dark Magic') then
        setLeveller.equipLevelSet(player, 'MaxINT', sets);
        setLeveller.equipItem('main', ElementalStaffTable['Dark']);
    elseif (string.match(action.Name, 'Cure') or string.match(action.Name, 'Curaga')) then
        setLeveller.equipLevelSet(player, 'Cure', sets);
        setLeveller.equipItem('main', ElementalStaffTable['Light']);
    elseif (action.Skill == 'Divine Magic') then
        setLeveller.equipLevelSet(player, 'Divine', sets);
        setLeveller.equipItem('main', ElementalStaffTable['Light']);
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