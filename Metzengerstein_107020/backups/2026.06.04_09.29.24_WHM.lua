local profile = {};
local sets = {
    ['Feesh'] = {
        Main = 'Blessed Hammer',
        Sub = 'Fish Scale Shield',
        Range = 'Tarutaru F. Rod',
        Ammo = 'Lugworm',
        Head = 'Red Cap +1',
        Neck = 'Justice Badge',
        Ear1 = 'Tml. Earring',
        Ear2 = 'Cunning Earring',
        Body = 'Fsh. Tunica',
        Hands = 'Fsh. Gloves',
        Ring1 = 'Windurstian Ring',
        Ring2 = 'Mythril Ring',
        Back = 'Cotton Cape',
        Waist = 'Silver Obi +1',
        Legs = 'Fisherman\'s Hose',
        Feet = 'Fisherman\'s Boots',
    },
    ['Rest'] = {
        Main = 'Blessed Hammer',
        Sub = 'Fish Scale Shield',
        Range = 'Tarutaru F. Rod',
        Ammo = 'Lugworm',
        Head = 'Red Cap +1',
        Neck = 'Checkered Scarf',
        Ear1 = 'Tml. Earring',
        Ear2 = 'Cunning Earring',
        Body = 'Seer\'s Tunic',
        Hands = 'Scentless Armlets',
        Ring1 = 'Windurstian Ring',
        Ring2 = 'Mythril Ring',
        Back = 'Cotton Cape',
        Waist = 'Silver Obi +1',
        Legs = 'Cmb.Cst. Slacks',
        Feet = 'Seer\'s Pumps +1',
    },
    ['WHM'] = {
        Main = 'Blessed Hammer',
        Sub = 'Fish Scale Shield',
        Range = 'Tarutaru F. Rod',
        Ammo = 'Lugworm',
        Head = 'Red Cap +1',
        Neck = 'Checkered Scarf',
        Ear1 = 'Tml. Earring',
        Ear2 = 'Cunning Earring',
        Body = 'Seer\'s Tunic',
        Hands = 'Scentless Armlets',
        Ring1 = 'Windurstian Ring',
        Ring2 = 'Mythril Ring',
        Back = 'Cotton Cape',
        Waist = 'Silver Obi +1',
        Legs = 'Cmb.Cst. Slacks',
        Feet = 'Seer\'s Pumps +1',
    }
};
profile.Sets = sets;

profile.Packer = {
};

profile.OnLoad = function()
    gSettings.AllowAddSet = true;
end

profile.OnUnload = function()
end

profile.HandleCommand = function(args)
end

profile.HandleDefault = function()
    local player = gData.GetPlayer();
    if (player.Status == 'Engaged') then
        gFunc.EquipSet(sets['WHM']);
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
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()
end

return profile;