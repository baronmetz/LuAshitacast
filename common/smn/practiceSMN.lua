local practiceSMN = {}

-- Avatars to cycle through
local avatars = {
    'Carbuncle',
    'Ifrit',
    'Shiva',
    'Garuda',
    'Leviathan',
    'Titan',
    'Ramuh',
    'Diabolos',
    'Fenrir',
};

-- Runtime state
local state = {
    running   = false,
    index     = 1,
    stopFlag  = false,
    buffer    = 1.2,   -- extra seconds for lag / animation (tweak if needed)
};

-- Simple debug helper (respects gSettings.Debug if you have it)
local function debugPrint(msg)
    if gSettings and gSettings.Debug then
        print(chat.header('practiceSMN') .. chat.message(msg))
    end
end

local function getPlayerMP()
    local player = gData.GetPlayer()
    return player and player.MPP and player.MP or 0
end

local function getSpellMPCost(spellName)
    local res = AshitaCore:GetResourceManager():GetSpellByName(spellName, 0)
    if res then
        return res.ManaCost or 0
    end
    return 9999  -- safe fallback so we don't try to cast
end

local function getSpellDelay(spellName)
    local res = AshitaCore:GetResourceManager():GetSpellByName(spellName, 0)
    if not res then
        return 10 + state.buffer
    end

    -- CastTime and RecastDelay are stored in units of 0.25 s
    local castSec  = (res.CastTime or 0) * 0.25
    local recastSec = (res.RecastDelay or 0) * 0.25

    -- We only need cast + a little buffer before we can release
    return castSec + state.buffer
end

local function hasPet()
    local pet = gData.GetPet()
    return pet ~= nil and pet.Name ~= nil and pet.Name ~= ''
end

local function doHeal()
    AshitaCore:GetChatManager():QueueCommand(1, '/heal')
end

local function stopPractice(reason)
    state.running  = false
    state.stopFlag = false
    state.index    = 1
    debugPrint(reason or 'Stopped.')
    doHeal()
end

-- Main step function
local function nextStep()
    if state.stopFlag or not state.running then
        stopPractice('Stopped by user.')
        return
    end

    if state.index > #avatars then
        -- Finished the whole list
        stopPractice('Finished all avatars.')
        return
    end

    local avatar = avatars[state.index]
    local cost   = getSpellMPCost(avatar)
    local mp     = getPlayerMP()

    if mp < cost then
        stopPractice(string.format('Not enough MP for %s (%d needed, have %d). Resting.', avatar, cost, mp))
        return
    end

    -- 1. Summon
    debugPrint(string.format('Summoning %s (%d/%d)', avatar, state.index, #avatars))
    AshitaCore:GetChatManager():QueueCommand(1, '/ma "' .. avatar .. '" <me>')

    local delay = getSpellDelay(avatar)

    -- 2. After cast finishes → Release, then schedule next avatar
    ashita.tasks.once(delay, function()
        if state.stopFlag or not state.running then
            stopPractice('Stopped by user.')
            return
        end

        debugPrint('Releasing ' .. avatar)
        AshitaCore:GetChatManager():QueueCommand(1, '/pet "Release" <me>')

        -- Short pause so the release registers, then move to next
        ashita.tasks.once(1.5 + state.buffer * 0.5, function()
            if state.stopFlag or not state.running then
                stopPractice('Stopped by user.')
                return
            end

            state.index = state.index + 1
            nextStep()
        end)
    end)
end

-- Public entry point
function practiceSMN.start(args)
    if state.running then
        print(chat.header('practiceSMN') .. chat.message('Already running. Use /practiceSMN stop'))
        return
    end

    -- Optional: allow a custom buffer via argument
    if args and args[1] and tonumber(args[1]) then
        state.buffer = tonumber(args[1])
    end

    state.running  = true
    state.stopFlag = false
    state.index    = 1

    print(chat.header('practiceSMN') .. chat.message('Starting avatar practice...'))
    nextStep()
end

function practiceSMN.stop()
    if not state.running then
        print(chat.header('practiceSMN') .. chat.message('Not currently running.'))
        return
    end
    print(chat.header('practiceSMN') .. chat.message('Stopping avatar practice....'));
    state.stopFlag = true
end

-- Command handler (call this from your profile's HandleCommand)
function practiceSMN.handleCommand(args)
    local cmd = args[2];

    if cmd == 'stop' then
        practiceSMN.stop()
    else
        -- shift args so start() can see optional buffer number
        table.remove(args, 1)  -- remove "practicesmn" itself if present
        practiceSMN.start(args)
    end
end

return practiceSMN