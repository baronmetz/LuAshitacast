local canCast = {};

function canCast.canCast(spellName)
    if not spellName or spellName == '' then
        return false
    end

    -- Look the spell up in the resource manager (language 0 = English)
    local res = AshitaCore:GetResourceManager():GetSpellByName(spellName, 0)
    if not res then
        return false
    end

    local player = AshitaCore:GetMemoryManager():GetPlayer()
    if not player then
        return false
    end

    return player:HasSpell(res.Index)
end

return canCast;