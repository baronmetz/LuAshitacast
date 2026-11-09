local profile = {};
local sets = {
    ['DRK'] = {
        Main = 'Chaosbringer',
        Head = 'Windshear Hat',
        Neck = 'Justice Badge',
        Body = 'Dream Robe +1',
        Hands = 'Asbestos Mitts',
        Ring1 = 'Copper Ring',
        Ring2 = 'Windurstian Ring',
        Back = 'Rabbit Mantle',
        Waist = 'Blood Stone',
        Legs = 'Dream Trousers +1',
        Feet = 'Dream Boots +1',
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