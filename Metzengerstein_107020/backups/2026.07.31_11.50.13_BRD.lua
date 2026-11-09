local profile = {};
local sets = {
    ['BRD'] = {
        Main = 'Decurion\'s Dagger',
        Range = 'Gemshorn',
        Head = 'Cmp. Eye Circlet',
        Neck = 'Justice Badge',
        Ear1 = 'Tml. Earring',
        Ear2 = 'Amber Earring',
        Body = 'Lgn. Harness',
        Hands = 'Gloves',
        Ring1 = 'Windurstian Ring',
        Ring2 = 'Shell Ring',
        Back = 'Cotton Cape',
        Waist = 'Silver Obi +1',
        Legs = 'Linen Slops',
        Feet = 'Lizard Ledelsens',
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
    if (player.Status == 'Engaged') then
        gFunc.EquipSet(sets['Engaged']);
    elseif (player.Status == 'Resting') then
        gFunc.EquipSet(sets['Rest']);
    else
        gFunc.EquipSet(sets['BRD']);
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