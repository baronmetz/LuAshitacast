local spellInfo = {};

local function toSeconds(units)
    if not units then return nil end
    return units * 0.25
end

local function fmt(sec)
    if not sec then return '?' end
    return string.format('%.2fs', sec)
end

local function debugPrint(...)
    if gSettings.Debug then
        print(...)
    end
end

function spellInfo.printSpellInfo(action)
    if not action or not action.Name then
        return
    end
    local res = AshitaCore:GetResourceManager():GetSpellByName(action.Name, 0)

    local castSec   = toSeconds(res and res.CastTime)
    local recastSec = toSeconds(res and res.RecastDelay)

    if not castSec and action.CastTime then
        castSec = toSeconds(action.CastTime)
    end
    if not recastSec and action.RecastDelay then
        recastSec = toSeconds(action.RecastDelay)
    end

    debugPrint(chat.header("Casting: ") .. chat.message(action.Name) 
    .. chat.header(" Skill: ") .. chat.message(action.Skill) 
    .. chat.header(" Element: ") .. chat.message(action.Element)
    .. chat.header(" Cast Time: ") .. chat.message(fmt(castSec))
    .. chat.header(" Recast Delay: ") .. chat.message(fmt(recastSec)));
end

return spellInfo;
