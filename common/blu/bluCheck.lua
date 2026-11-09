local bluCheck = {}

local db = gFunc.LoadFile('common/blu/database.lua')

local function getTargetName()
    local target = gData.GetTarget()
    if not target or not target.Name or target.Name == '' then
        return nil
    end
    return target.Name
end

local function isMonster(target)
    if not target then return false end
    if target.Type and (target.Type == 'PC' or target.Type == 'NPC') then
        return false
    end
    return true
end

-- Returns true if the player has learned the given Blue Magic spell
local function hasLearnedSpell(spellName)
    local res = AshitaCore:GetResourceManager():GetSpellByName(spellName, 0)
    if not res then
        return false
    end

    local player = AshitaCore:GetMemoryManager():GetPlayer()
    if not player then
        return false
    end

    -- HasSpell works for Blue Magic (IDs start at 512)
    return player:HasSpell(res.Index)
end

function bluCheck.check()
    local target = gData.GetTarget()
    local name = getTargetName()

    if not name then
        print(chat.header('BLUCheck') .. chat.message('No target.'))
        return
    end

    if not isMonster(target) then
        print(chat.header('BLUCheck') .. chat.message('Target is not a monster.'))
        return
    end

    -- Exact match first, then partial
    local family = db.NameToFamily[name]
    if not family then
        for mobName, fam in pairs(db.NameToFamily) do
            if string.find(string.lower(name), string.lower(mobName)) then
                family = fam
                break
            end
        end
    end

    if not family then
        print(chat.header('BLUCheck') .. chat.message(string.format('Unknown family for "%s".', name)))
        return
    end

    local spells = db.Families[family]
    if not spells or #spells == 0 then
        print(chat.header('BLUCheck') .. chat.message(string.format('%s → Family: %s (no Blue Magic in database)', name, family)))
        return
    end

    local player = gData.GetPlayer()
    local playerLevel = player.MainJobSync or player.MainJobLevel

    print(chat.header('BLUCheck') .. chat.message(string.format('%s  →  Family: %s', name, family)))

    for _, spell in ipairs(spells) do
        local learned = hasLearnedSpell(spell.name)
        local learnedText = learned and chat.message(' [Learned]') or chat.message(' [Not learned]')

        local status = ''
        if learned then
            status = chat.message(' [Already learned]')
        elseif spell.skillReq then
            status = chat.message(string.format(' [Needs BLU skill %d+ to learn | Usable at Lv %d]', spell.skillReq, spell.level))
        else
            status = chat.message(string.format(' [Usable at Lv %d]', spell.level))
        end

        print(string.format('  • %s  Lv%d%s%s', spell.name, spell.level, status, learnedText))
    end
end

return bluCheck