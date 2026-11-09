local synthFunc = gFunc.LoadFile('common/synth.lua');
local resistFunc = gFunc.LoadFile('common/resist.lua');

local profile = {};
local sets = {
    ['BRD'] = {
        Main = 'Small sword',
        Sub = 'Decurion\'s dagger',
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
        Waist = 'Heko Obi +1',
        Legs = 'Linen Slops',
        Feet = 'Lizard Ledelsens',
    },
    ['Engaged'] = {
        Main = 'Small sword',
        Sub = 'Decurion\'s dagger',
    },
    ['Singing'] = {
        Main = 'Dream bell +1'
    },
    ['Mambo'] = {
        Range = 'Gemshorn'
    },
    ['Minuet'] = {
        Range = 'Cornette'
    },
};
profile.Sets = sets;

profile.Packer = {
};

profile.OnLoad = function()
    gSettings.AllowAddSet = true;

    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /synth /lac fwd synth');
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /resist /lac fwd resist');
end

profile.OnUnload = function()
end

profile.HandleCommand = function(args)
    if (#args == 0) then return; end

    local cmd = args[1]:lower();
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
    local action = gData.GetAction();
    if (action.Name == "Sneak") then
        gFunc.Equip("Feet", "Dream Boots +1");
    end
    if (action.Name == "Invisible") then
        gFunc.Equip("Hands", "Dream Mittens +1");
    end

    if (action.Skill == 'Singing') then
        gFunc.EquipSet('Singing');
    end
    if (action.Type == 'Bard Song') then
        if (string.match(action.Name, ' Minuet')) then
            gFunc.EquipSet('Minuet');
        elseif (string.match(action.Name, ' Mambo')) then
            gFunc.EquipSet('Mambo');
        end
    end
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()
end

return profile;