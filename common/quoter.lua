local quoter = {}

-- Add as many as you want. Keys are exact ability / WS names.
local pools = {
    gFunc.LoadFile('common/quotes/Hand2Hand.lua'),
    gFunc.LoadFile('common/quotes/Club.lua'),
    gFunc.LoadFile('common/quotes/GreatKatana.lua'),
    gFunc.LoadFile('common/quotes/Sword.lua'),
    gFunc.LoadFile('common/quotes/Polearm.lua'),
    gFunc.LoadFile('common/quotes/Archery.lua'),
    gFunc.LoadFile('common/quotes/Marksmanship.lua'),
    gFunc.LoadFile('common/quotes/MNK.lua'),
    gFunc.LoadFile('common/quotes/WAR.lua'),
    gFunc.LoadFile('common/quotes/THF.lua'),
    gFunc.LoadFile('common/quotes/RNG.lua'),
    gFunc.LoadFile('common/quotes/COR.lua'),
    gFunc.LoadFile('common/quotes/WHM.lua'),
    gFunc.LoadFile('common/quotes/DRG.lua'),
    gFunc.LoadFile('common/quotes/SAM.lua'),
    gFunc.LoadFile('common/quotes/BLU.lua'),
}

local function findLine(actionName)
    for _, pool in ipairs(pools) do
        if pool and pool[actionName] then
            local list = pool[actionName]
            return list[math.random(#list)]
        end
    end
    return nil
end

function quoter.sayFor(actionName)
    if not actionName then return end
    local line = findLine(actionName)
    if not line then return end
    AshitaCore:GetChatManager():QueueCommand(1, '/s ' .. line)
end

return quoter