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