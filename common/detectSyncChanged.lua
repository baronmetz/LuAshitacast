local detectSync = {}

local lastSyncLevel = nil

--- Returns true only on the tick that MainJobSync actually changes.
--- Also prints a nice message when it happens.
---@param player table  gData.GetPlayer()
---@return boolean
function detectSync.changed(player)
    local currentSync = player.MainJobSync

    -- First run after profile load – just record the value
    if lastSyncLevel == nil then
        lastSyncLevel = currentSync
        return false
    end

    if currentSync ~= lastSyncLevel then
        print(chat.header('Sync') .. chat.message(
            string.format('Level sync changed: %d → %d', lastSyncLevel, currentSync)
        ))
        lastSyncLevel = currentSync
        return true
    end

    return false
end

--- Optional: force a reset (useful if you manually change jobs or reload)
function detectSync.reset()
    lastSyncLevel = nil
end

return detectSync