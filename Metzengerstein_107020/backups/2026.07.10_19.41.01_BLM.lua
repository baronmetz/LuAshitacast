local profile = {};
local sets = {
    ['BLM'] = {
        Main = 'Decurion\'s Dagger',
        Range = 'Willow Fish. Rod',
        Ammo = 'Little Worm',
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