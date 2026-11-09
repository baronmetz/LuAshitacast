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
        --Sub = 'Fish Scale Shield',
        --Range = 'Clothespole',
        --Ammo = 'Lugworm',
        Head = 'Red Cap +1',
        Neck = 'Checkered Scarf',
        Ear1 = 'Tml. Earring',
        Ear2 = 'Cunning Earring',
        Body = 'Seer\'s Tunic',
        Hands = 'Scentless Armlets',
        Ring1 = 'Windurstian Ring',
        Ring2 = 'Garnet Ring',
        Back = 'Green Cape',
        Waist = 'Silver Obi +1',
        Legs = 'Cmb.Cst. Slacks',
        Feet = 'Seer\'s Pumps +1',
    },
    ['WHM'] = {
        Main = 'Earth Staff',
        Range = 'Willow Fish. Rod',
        Ammo = 'Little Worm',
        Head = 'Crow Beret',
        Neck = 'Willpower Torque',
        Ear1 = 'Mythril Earring',
        Ear2 = 'Cunning Earring',
        Body = 'Wonder Kaftan',
        Hands = 'Wonder Mitts',
        Ring1 = 'Windurstian Ring',
        Ring2 = 'Garnet Ring',
        Back = 'Gramary Cape',
        Waist = 'Silver Obi +1',
        Legs = 'Cmb.Cst. Slacks',
        Feet = 'Seer\'s Pumps +1',
    }};
profile.Sets = sets;

profile.Packer = {
};

profile.OnLoad = function()
    gSettings.AllowAddSet = true;
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /protectra /lac fwd protectra');
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /shellra /lac fwd shellra');

    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /protect /lac fwd protect');
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /shell /lac fwd shell');
end

profile.OnUnload = function()
end

profile.HandleCommand = function(args)
    if (#args == 0) then return; end

    local cmd = args[1]:lower();
    if (cmd == 'protectra' or cmd == 'protect') then
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

    if (cmd == 'shellra' or cmd == 'shell') then
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
end

profile.HandleDefault = function()
    local player = gData.GetPlayer();
    if (player.Status == 'Engaged') then
        gFunc.EquipSet(sets['WHM']);
        gFunc.Equip("Main", "Arcana Breaker");
        gFunc.Equip("Sub", "Fish Scale Shield");
    elseif (player.Status == 'Resting') then
        gFunc.EquipSet(sets['Rest']);
    else
        gFunc.EquipSet(sets['WHM']);
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
    if action.Name == "Sneak" then
        gFunc.Equip("Feet", "Dream Boots +1");
    end
    if action.Name == "Invisible" then
        gFunc.Equip("Hands", "Dream Mittens +1");
    end

    if (action.Skill == 'Enfeebling Magic') then
        gFunc.Equip('main', ElementalStaffTable[action.Element]);
    elseif (action.Skill == 'Elemental Magic') then
        gFunc.Equip('main', ElementalStaffTable[action.Element]);
    elseif (string.match(action.Name, 'Cure') or string.match(action.Name, 'Curaga')) then
        gFunc.Equip('main', ElementalStaffTable['Light']);
    end
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()
end

return profile;