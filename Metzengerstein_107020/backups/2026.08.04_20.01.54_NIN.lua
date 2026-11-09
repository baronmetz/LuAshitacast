local profile = {};
local sets = {
    ['NIN'] = {
        Main = 'Wakizashi',
        Sub = 'Blind Knife',
        Head = 'Horror Head II',
        Neck = 'Justice Badge',
        Ear1 = 'Tml. Earring',
        Ear2 = 'Amber Earring',
        Body = 'Lgn. Harness',
        Hands = 'Dream Mittens +1',
        Ring1 = 'Chariot Band',
        Ring2 = 'Windurstian Ring',
        Back = 'Rabbit Mantle',
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
    local player = gData.GetPlayer();
    gFunc.EquipSet(sets['NIN']);
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