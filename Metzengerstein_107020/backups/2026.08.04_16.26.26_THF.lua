local synthFunc = gFunc.LoadFile('common/synth.lua');
local resistFunc = gFunc.LoadFile('common/resist.lua');
local setLeveller = gFunc.LoadFile('common/setLeveller.lua');

local profile = {};
local sets = {
    ['Idle'] = {
        Main = 'Blind Knife',
        Sub = 'Lauan Shield',
        Range = 'Lgn. Crossbow',
        Ammo = 'Blind Bolt',
        Head = 'Cmp. Eye Circlet',
        Neck = 'Justice Badge',
        Ear1 = 'Tml. Earring',
        Ear2 = 'Amber Earring',
        Body = 'Lgn. Harness',
        Hands = 'Gloves',
        Ring1 = 'Windurstian Ring',
        Ring2 = 'Chariot Band',
        Back = 'Rabbit Mantle',
        Waist = 'Blood Stone',
        Legs = 'Linen Slops',
        Feet = 'Dream Boots +1',
    },
};
profile.Sets = sets;

profile.Packer = {
};

function equipLevelSet(player, set)
    local levelledSet = setLeveller.getLevelledSet(player, set);
    if (levelledSet ~= currentSet) then
        print('Equipping set ' .. levelledSet);
        currentSet = levelledSet;
    end
    gFunc.EquipSet(sets[levelledSet]);
end

function equipInterimLevelSet(player, set, delay)
    local levelledSet = setLeveller.getLevelledSet(player, set);
    print('Equipping set ' .. levelledSet .. ' after ' .. delay .. 's'); 
    gFunc.SetMidDelay(delay);
    gFunc.InterimEquipSet(sets[levelledSet]);
end

function equipItem(location, item)
    print(chat.header('Equipping: ') .. chat.message(item));
    gFunc.Equip(location, item);
end

function equipInterimItem(location, item, delay)
    print(chat.header('Equipping: ') .. chat.message(item .. ' after ' .. delay .. 's.'));
    gFunc.SetMidDelay(delay);
    gFunc.InterimEquip(location, item);
end

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
        equipLevelSet(player, 'Engaged', true);
    elseif (player.Status == 'Resting') then
        equipLevelSet(player, 'Rest', true);
    else
        equipLevelSet(player, resistFunc.idleSet, true);
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