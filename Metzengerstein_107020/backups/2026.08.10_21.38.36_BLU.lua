local synthFunc = gFunc.LoadFile('common/synth.lua');
local resistFunc = gFunc.LoadFile('common/resist.lua');
local setLeveller = gFunc.LoadFile('common/setLeveller.lua');
local delayCalculator = gFunc.LoadFile('common/delayCalculator.lua');
local weatherFunc = gFunc.LoadFile('common/weather.lua');

local profile = {};
local sets = {
};
profile.Sets = sets;

profile.Packer = {
};

function equipLevelSet(player, set)
    local levelledSet = setLeveller.getLevelledSet(player, set);
    if (levelledSet ~= currentSet) then
        print(chat.header('Equipment Change:') .. chat.message(levelledSet));
        currentSet = levelledSet;
    end
    gFunc.EquipSet(sets[levelledSet]);
end

function equipInterimLevelSet(player, set, delay)
    local levelledSet = setLeveller.getLevelledSet(player, set);
    print(chat.header('Interim Equipment Change:') .. chat.message(levelledSet) .. chat.message(' for ' .. delay .. 's.'));
    gFunc.SetMidDelay(delay);
    gFunc.InterimEquipSet(sets[levelledSet]);
end

function equipItem(location, item)
    print(chat.header('Equipment Change:') .. chat.message(item));
    gFunc.Equip(location, item);
end

function equipInterimItem(location, item, delay)
    print(chat.header('Interim Equipment Change:') .. chat.message(item) .. chat.message(' for ' .. delay .. 's.'));
    gFunc.SetMidDelay(delay);
    gFunc.InterimEquip(location, item);
end

function getHaste(player)
    local levelledSet = setLeveller.getLevelledSet(player, 'Haste');
    return hasteValues[levelledSet];
end

local casting = false;
local castCount = 0;
local maxCasts = 10;
local currentSpell = 'Pollen';
local buffer  = 1.0;

function practiceBLU(args)
    if casting then
        print('\30\68[PracticeBLU] Already casting, please wait...')
        return
    end

    currentSpell = args[2] or currentSpell
    castCount = 0
    casting = true

    local res = AshitaCore:GetResourceManager():GetSpellByName(currentSpell, 0);
    if not res then
        print(string.format('\30\68[PracticeBLU] Could not find spell: %s', currentSpell))
        casting = false
        return
    end

    print(string.format('\30\68[PracticeBLU] Starting practice of %s...', currentSpell))
    castNext(res)
end

function castNext()
    local player = gData.GetPlayer();
    local mp = player.MP;

    local res = AshitaCore:GetResourceManager():GetSpellByName(currentSpell, 0);
    local mpCost = res.ManaCost

    if mp < mpCost or castCount >= maxCasts then
        casting = false
        AshitaCore:GetChatManager():QueueCommand(1, '/heal')
        print('\30\68[PracticeBLU] Practice finished ~ /heal')
        return
    end

    -- Calculate delay: (CastTime + RecastDelay) in seconds + buffer
    -- Ashita stores these as units that need * 250 to become milliseconds
    local castTimeSec  = (res.CastTime   * 250) / 1000
    local recastSec    = (res.RecastDelay * 250) / 1000
    local delay        = castTimeSec + recastSec + buffer

    castCount = castCount + 1
    AshitaCore:GetChatManager():QueueCommand(1, string.format('/ma "%s" <me>', currentSpell))

    ashita.tasks.once(delay, castNext)
end

profile.OnLoad = function()
    gSettings.AllowAddSet = true;

    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /synth /lac fwd synth');
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /resist /lac fwd resist');
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /weather /lac fwd weather');
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /practiceblu /lac fwd practiceblu');
end

profile.OnUnload = function()
end

profile.HandleCommand = function(args)
    if (#args == 0) then return; end

    local cmd = args[1]:lower();
    if (string.match(cmd, 'protect')) then
        protect(cmd);
    end

    if (string.match(cmd, 'shell')) then
        shell(cmd);
    end

    if (string.match(cmd, 'raise')) then
        raise(cmd);
    end

    if (cmd == 'synth') then
        synthFunc.synth(args);
    end

    if (cmd == 'resist') then
        resistFunc.resist(args);
    end

    if (cmd == 'weather') then
        weatherFunc.Show();
    end

    if (cmd == 'practiceblu') then
        practiceBLU(args);
    end

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