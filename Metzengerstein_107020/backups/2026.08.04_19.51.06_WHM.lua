local synthFunc = gFunc.LoadFile('common/synth.lua');
local resistFunc = gFunc.LoadFile('common/resist.lua');
local setLeveller = gFunc.LoadFile('common/setLeveller.lua');
local delayCalculator = gFunc.LoadFile('common/delayCalculator.lua');

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
    ['Rest'] = {
        Main = 'Dark Staff',
        Neck = 'Checkered Scarf',
        Body = 'Seer\'s Tunic',
        Legs = 'Baron\'s Slops',
    },
    ['Idle'] = {
        Main = 'Earth Staff',
        Ammo = 'Holy Ampulla',
        Head = 'Healer\'s cap',
        Neck = 'Checkered Scarf',
        Ear1 = 'Geist Earring',
        Ear2 = 'Geist Earring',
        Body = 'Healer\'s bliaut',
        Hands = 'Healer\'s mitts',
        Ring1 = 'Windurstian Ring',
        Ring2 = 'Ether Ring',
        Back = 'Red Cape +1',
        Waist = 'Silver Obi +1',
        Legs = 'Healer\'s Pantaln.',
        Feet = 'Healer\'s duckbills',
    },
    ['MaxMND'] = {
        Main = 'Water Staff',
        Ammo = 'Holy Ampulla',
        Head = 'Healer\'s Cap',
        Neck = 'Ajari Necklace',
        Ear1 = 'Geist Earring',
        Ear2 = 'Geist Earring',
        Body = 'Healer\'s Bliaut',
        Back = 'Red Cape +1',
        Waist = 'Silver Obi +1',
        Legs = 'Wonder Braccae',
        Feet = 'Seer\'s Pumps +1',
    },
    ['MaxMND60'] = {
        Main = 'Water Staff',
        Ammo = 'Holy Ampulla',
        Head = 'Healer\'s cap',
        Neck = 'Ajari Necklace',
        Ear1 = 'Geist Earring',
        Ear2 = 'Geist Earring',
        Body = 'Healer\'s bliaut',
        Back = 'Red Cape +1',
        Hands = 'Healer\'s mitts',
        Legs = 'Healer\'s Pantaln.',
        Feet = 'Seer\'s Pumps +1',
    },
    ['MaxINT'] = {
        Main = 'Ice Staff',
        Ammo = 'Holy Ampulla',
        Neck = 'Checkered Scarf',
        Ear1 = 'Cunning Earring',
        Back = 'Red Cape +1',
        Feet = 'Healer\'s duckbills',
    },
    ['MaxINT60'] = {
        Main = 'Ice Staff',
        Ammo = 'Holy Ampulla',
        Neck = 'Checkered Scarf',
        Ear1 = 'Cunning Earring',
        Back = 'Red Cape +1',
        Feet = 'Healer\'s duckbills',
    },
    ['Engaged'] = {
        Main = 'Battle Staff',
        Head = 'Healer\'s cap',
        Neck = 'Checkered Scarf',
        Ear1 = 'Geist Earring',
        Ear2 = 'Geist Earring',
        Body = 'Healer\'s bliaut',
        Hands = 'Healer\'s mitts',
        Ring1 = 'Windurstian Ring',
        Ring2 = 'Garnet Ring',
        Back = 'Gramary Cape',
        Waist = 'Silver Obi +1',
        Legs = 'Healer\'s Pantaln.',
        Feet = 'Healer\'s Duckbills',
    },
    ['Engaged60'] = {
        Main = 'Battle Staff',
        Head = 'Healer\'s cap',
        Neck = 'Willpower Torque',
        Ear1 = 'Geist Earring',
        Ear2 = 'Geist Earring',
        Body = 'Healer\'s bliaut',
        Hands = 'Healer\'s mitts',
        Ring1 = 'Windurstian Ring',
        Ring2 = 'Garnet Ring',
        Back = 'Gramary Cape',
        Waist = 'Silver Obi +1',
        Legs = 'Healer\'s Pantaln.',
        Feet = 'Healer\'s Duckbills',
    },
    ['Idle20'] = {
        Main = 'Willow Wand +1',
        Sub = 'Fish Scale Shield',
        Head = 'Cmp. Eye Circlet',
        Neck = 'Black Neckerchief',
        Ear1 = 'Tml. Earring',
        Ear2 = 'Amber Earring',
        Body = 'Linen Robe',
        Hands = 'Scentless Armlets',
        Ring1 = 'Windurstian Ring',
        Ring2 = 'Shell Ring',
        Back = 'Cotton Cape',
        Waist = 'Silver Obi +1',
        Legs = 'Linen Slops',
        Feet = 'Dream Boots +1',
    },
    ['Idle50'] = {
        Main = 'Blessed Hammer',
        Sub = 'Fish Scale Shield',
        Ammo = 'Holy Ampulla',
        Head = 'Crow Beret',
        Neck = 'Willpower Torque',
        Ear1 = 'Geist Earring',
        Ear2 = 'Geist Earring',
        Body = 'Crow Jupon',
        Hands = 'Crow Bracers',
        Ring1 = 'Windurstian Ring',
        Ring2 = 'Ether Ring',
        Back = 'Red Cape +1',
        Waist = 'Silver Obi +1',
        Legs = 'Crow Hose',
        Feet = 'Crow Gaiters',
    },
    ['Idle40'] = {
        Main = 'Blessed Hammer',
        Sub = 'Fish Scale Shield',
        Ammo = 'Holy Ampulla',
        Head = 'Red Cap +1',
        Neck = 'Willpower Torque',
        Ear1 = 'Geist Earring',
        Ear2 = 'Geist Earring',
        Body = 'Wonder Kaftan',
        Hands = 'Scentless Armlets',
        Ring1 = 'Windurstian Ring',
        Ring2 = 'Ether Ring',
        Back = 'Cotton Cape',
        Waist = 'Silver Obi +1',
        Legs = 'Wonder Braccae',
        Feet = 'Wonder Clomps',
    },
    ['Rest40'] = {
        Main = 'Blessed Hammer',
        Sub = 'Fish Scale Shield',
        Ammo = 'Holy Ampulla',
        Head = 'Red Cap +1',
        Neck = 'Willpower Torque',
        Ear1 = 'Geist Earring',
        Ear2 = 'Geist Earring',
        Body = 'Seer\'s Tunic',
        Hands = 'Scentless Armlets',
        Ring1 = 'Windurstian Ring',
        Ring2 = 'Ether Ring',
        Back = 'Cotton Cape',
        Waist = 'Silver Obi +1',
        Legs = 'Wonder Braccae',
        Feet = 'Wonder Clomps',
    },
    ['Rest60'] = {
        Main = 'Dark Staff',
        Neck = 'Checkered Scarf',
        Body = 'Seer\'s Tunic',
        Legs = 'Baron\'s Slops',
    },
    ['Idle60'] = {
        Main = 'Earth Staff',
        Ammo = 'Holy Ampulla',
        Head = 'Healer\'s Cap',
        Neck = 'Willpower Torque',
        Ear1 = 'Geist Earring',
        Ear2 = 'Geist Earring',
        Body = 'Healer\'s Bliaut',
        Hands = 'Healer\'s Mitts',
        Ring1 = 'Windurstian Ring',
        Ring2 = 'Ether Ring',
        Back = 'Red Cape +1',
        Waist = 'Silver Obi +1',
        Legs = 'Healer\'s Pantaln.',
        Feet = 'Healer\'s Duckbills',
    },
    ['Interrupt'] = {
        Neck = 'Willpower Torque',
        Body = 'Healer\'s Bliaut',
        Hands = 'Healer\'s mitts',
        Waist = 'Silver Obi +1',
        Legs = 'Healer\'s Pantaln.',
        Feet = 'Healer\'s Duckbills',
    },
    ['Interrupt60'] = {
        Neck = 'Willpower Torque',
        Body = 'Healer\'s Bliaut',
        Hands = 'Healer\'s mitts',
        Waist = 'Silver Obi +1',
        Legs = 'Healer\'s Pantaln.',
        Feet = 'Healer\'s Duckbills',
    },
    ['Rest30'] = {
        Main = 'Willow Wand +1',
        Sub = 'Fish Scale Shield',
        Head = 'Cmp. Eye Circlet',
        Neck = 'Black Neckerchief',
        Ear1 = 'Tml. Earring',
        Ear2 = 'Cunning Earring',
        Body = 'Seer\'s Tunic',
        Hands = 'Scentless Armlets',
        Ring1 = 'Windurstian Ring',
        Ring2 = 'Shell Ring',
        Back = 'Cotton Cape',
        Waist = 'Silver Obi +1',
        Legs = 'Baron\'s Slops',
        Feet = 'Seer\'s Pumps +1',
    },
};

local hasteValues = {
    ['Haste'] = 0,
    ['Haste60'] = 0,
};
profile.Sets = sets;

profile.Packer = {
};

function equipLevelSet(player, set)
    local levelledSet = setLeveller.getLevelledSet(player, set);
    if (levelledSet ~= currentSet) then
        print('Equipping set ' .. levelledSet);
        currentSet = levelledSet;
    end
    gFunc.EquipSet(sets[levelledSet]);
end

function equipInterimLevelSet(player, set, delay)
    local levelledSet = setLeveller.getLevelledSet(player, set);
    print('Equipping set ' .. levelledSet .. ' after ' .. delay .. 's'); 
    gFunc.SetMidDelay(delay);
    gFunc.InterimEquipSet(sets[levelledSet]);
end

function equipItem(location, item)
    print(chat.header('Equipping: ') .. chat.message(item));
    gFunc.Equip(location, item);
end

function equipInterimItem(location, item, delay)
    print(chat.header('Equipping: ') .. chat.message(item .. ' after ' .. delay .. 's.'));
    gFunc.SetMidDelay(delay);
    gFunc.InterimEquip(location, item);
end

function getHaste(player)
    local levelledSet = setLeveller.getLevelledSet(player, 'Haste');
    return hasteValues[levelledSet];
end

function protect(cmd)
    local tier = 1;
    local player = gData.GetPlayer();
    local playerLevel = player.MainJobSync;

    print('Player Level: ' .. playerLevel)
    if (playerLevel >= 75) then tier = 5;
    elseif (playerLevel >= 63) then tier = 4;
    elseif (playerLevel >= 47) then tier = 3;
    elseif (playerLevel >= 27) then tier = 2;
    end
    print('Tier level: ' .. tier);

    local spellName = cmd ..  tier;
    print('Casting ' .. spellName .. ' (auto-tier ' .. tier .. ')');
    AshitaCore:GetChatManager():QueueCommand(1, '/ma ' .. spellName);  -- Or <me> / <stpt> etc.
end

function shell(cmd)
    local tier = 1;
    local player = gData.GetPlayer();
    local playerLevel = player.MainJobSync;

    print('Player Level: ' .. playerLevel)
    if (playerLevel >= 75) then tier = 5;
    elseif (playerLevel >= 68) then tier = 4;
    elseif (playerLevel >= 57) then tier = 3;
    elseif (playerLevel >= 37) then tier = 2;
    end
    print('Tier level: ' .. tier);

    local spellName = cmd ..  tier;
    print('Casting ' .. spellName .. ' (auto-tier ' .. tier .. ')');
    AshitaCore:GetChatManager():QueueCommand(1, '/ma ' .. spellName);  -- Or <me> / <stpt> etc.
end

function raise(cmd)
    local tier = 1;
    local player = gData.GetPlayer();
    local playerLevel = player.MainJobSync;

    print('Player Level: ' .. playerLevel)
    if (playerLevel >= 70) then tier = 3;
    elseif (playerLevel >= 56) then tier = 2;
    end
    print('Tier level: ' .. tier);

    local spellName = cmd ..  tier;
    print('Casting ' .. spellName .. ' (auto-tier ' .. tier .. ')');
    AshitaCore:GetChatManager():QueueCommand(1, '/ma ' .. spellName);  -- Or <me> / <stpt> etc.
end

profile.OnLoad = function()
    gSettings.AllowAddSet = true;
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /protect /lac fwd protect');
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /protectra /lac fwd protectra');
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /shell /lac fwd shell');
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /shellra /lac fwd shellra');
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /raise /lac fwd raise');

    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /synth /lac fwd synth');
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /resist /lac fwd resist');
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

    if (cmd == 'raise') then
        raise(cmd);
    end

    if (cmd == 'synth') then
        synthFunc.synth(args);
    end

    if (cmd == 'resist') then
        resistFunc.resist(args);
    end
end

profile.HandleDefault = function()
    local player = gData.GetPlayer();
    if (player.Status == 'Engaged') then
        equipLevelSet(player, 'Engaged', true);
    elseif (player.Status == 'Resting') then
        equipLevelSet(player, 'Rest', true);
    else
        equipLevelSet(player, resistFunc.idleSet, true);
    end
end

profile.HandleAbility = function()
end

profile.HandleItem = function()
end

profile.HandlePrecast = function()
    local player = gData.GetPlayer();
    equipLevelSet(player, 'Haste');
end

profile.HandleMidcast = function()
    local MndDebuffs = T{ 'Slow', 'Paralyze', 'Slow II', 'Paralyze II', 'Addle', 'Addle II' };
    local ElementalDebuffs = T{ 'Burn', 'Rasp', 'Drown', 'Choke', 'Frost', 'Shock' };
    local action = gData.GetAction();
    local player = gData.GetPlayer();

    print("Midcast for spell " .. action.Name .. " of skill type " .. action.Skill .. " and element " .. action.Element);
    
    print('Equipping interrupt gear....');
    local haste = getHaste(player);
    local delay = delayCalculator.calculateDelay(action, haste);
    equipInterimLevelSet(player, 'Interrupt', delay);

    print(chat.header('Midcast: ') .. chat.message('Equipping midcast gear in ' .. delay .. 's.'));

    if (action.Skill == 'Enfeebling Magic') then
        if (MndDebuffs:contains(action.Name)) then
            equipLevelSet(player, 'MaxMND');
        else
            equipLevelSet(player, 'MaxINT');
        end
        equipItem('main', ElementalStaffTable[action.Element]);
        equipItem('body', 'Healer\'s Bliaut');
    elseif (action.Skill == 'Elemental Magic') then
        if (action.Element == 'Light') then
            equipLevelSet(player, 'MaxMND');
        else
            equipLevelSet(player, 'MaxINT');
        end
        equipItem('main', ElementalStaffTable[action.Element]);
    elseif (action.Skill == 'Dark Magic') then
        equipLevelSet(player, 'MaxINT', delay);
        equipItem('main', ElementalStaffTable['Dark']);
    elseif (string.match(action.Name, 'Cure') or string.match(action.Name, 'Curaga')) then
        equipItem('main', ElementalStaffTable['Light']);
        equipItem('hands', 'Healer\'s mitts');
        equipItem('legs', 'Healer\'s Pantaln.');
    elseif (action.Skill == 'Divine Magic') then
        equipItem('main', ElementalStaffTable['Light']);
        equipItem('legs', 'Healer\'s Pantaln.');
    end
    if action.Name == 'Stoneskin' then
        equipLevelSet(player, 'MaxMND');
    end

    if action.Name == "Sneak" then
        equipItem("Feet", "Dream Boots +1");
    end
    if action.Name == "Invisible" then
        equipItem("Hands", "Dream Mittens +1");
    end
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()
end

return profile;