local synthFunc = gFunc.LoadFile('common/synth.lua');
local resistFunc = gFunc.LoadFile('common/resist.lua');
local setLeveller = gFunc.LoadFile('common/setLeveller.lua');

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
        Ammo = 'Holy Ampulla',
        Head = 'Healer\'s cap',
        Neck = 'Checkered Scarf',
        Hands = 'Healer\'s mitts',
        Ear1 = 'Geist Earring',
        Ear2 = 'Geist Earring',
        Body = 'Seer\'s Tunic',
    },
    ['Idle'] = {
        Main = 'Earth Staff',
        Ammo = 'Holy Ampulla',
        Head = 'Healer\'s cap',
        Neck = 'Willpower Torque',
        Ear1 = 'Geist Earring',
        Ear2 = 'Geist Earring',
        Body = 'Healer\'s bliaut',
        Hands = 'Healer\'s mitts',
        Ring1 = 'Windurstian Ring',
        Ring2 = 'Ether Ring',
        Back = 'Red Cape +1',
        Waist = 'Silver Obi +1',
        Legs = 'Healer\'s pantaloons',
        Feet = 'Healer\'s duckbills',
    },
    ['MaxMND'] = {
        Main = 'Water Staff',
        Ammo = 'Holy Ampulla',
        Head = 'Healer\'s cap',
        Neck = 'Ajari Necklace',
        Ear1 = 'Geist Earring',
        Ear2 = 'Geist Earring',
        Body = 'Healer\'s bliaut',
        Back = 'Red Cape +1',
        Hands = 'Healer\'s mitts',
        Legs = 'Healer\'s pantaloons',
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
    ['Engaged'] = {
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
        Legs = 'Healer\'s pantaloons',
        Feet = 'Healer\'s duckbills',
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
    }};
profile.Sets = sets;

profile.Packer = {
};

function equipLevelSet(player, set)
    setLeveller.equipLevelSet(player, set, sets);
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
        equipLevelSet(player, 'Engaged');
    elseif (player.Status == 'Resting') then
        equipLevelSet(player, 'Rest');
    else
        equipLevelSet(player, resistFunc.idleSet);
    end
end

profile.HandleAbility = function()
end

profile.HandleItem = function()
end

profile.HandlePrecast = function()
end

profile.HandleMidcast = function()
    local MndDebuffs = T{ 'Slow', 'Paralyze', 'Slow II', 'Paralyze II', 'Addle', 'Addle II' };
    local ElementalDebuffs = T{ 'Burn', 'Rasp', 'Drown', 'Choke', 'Frost', 'Shock' };
    local action = gData.GetAction();
    local player = gData.GetPlayer();
    if action.Name == "Sneak" then
        gFunc.Equip("Feet", "Dream Boots +1");
    end
    if action.Name == "Invisible" then
        gFunc.Equip("Hands", "Dream Mittens +1");
    end

    if (action.Skill == 'Enfeebling Magic') then
         if (MndDebuffs:contains(action.Name)) then
            equipLevelSet(player, 'MaxMND');
        else
            equipLevelSet(player, 'MaxINT');
        end
        gFunc.Equip('main', ElementalStaffTable[action.Element]);
    elseif (action.Skill == 'Elemental Magic') then
        if (action.Element == 'Light') then
            equipLevelSet(player, 'MaxMND');
        else
            equipLevelSet(player, 'MaxINT');
        end
        gFunc.Equip('main', ElementalStaffTable[action.Element]);
    elseif (action.Skill == 'Dark Magic') then
        equipLevelSet(player, 'MaxINT');
        gFunc.Equip('main', ElementalStaffTable['Dark']);
    elseif (action.Skill == 'Divine Magic' or string.match(action.Name, 'Cure') or string.match(action.Name, 'Curaga')) then
        equipLevelSet(player, 'MaxMND');
        gFunc.Equip('main', ElementalStaffTable['Light']);
    elseif (string.match(action.Name, 'Stoneskin')) then
        equipLevelSet(player, 'MaxMND');
    end
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()
end

return profile;