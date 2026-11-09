local profile = {};
local sets = {
    ['BRD'] = {
        Main = 'Blind Knife',
        Head = 'Cmp. Eye Circlet',
        Neck = 'Justice Badge',
        Ear1 = 'Tml. Earring',
        Ear2 = 'Amber Earring',
        Body = 'Lgn. Harness',
        Hands = 'Gloves',
        Ring1 = 'Windurstian Ring',
        Ring2 = 'Shell Ring',
        Back = 'Cape',
        Waist = 'Heko Obi +1',
        Legs = 'Linen Slops',
        Feet = 'Solea',
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