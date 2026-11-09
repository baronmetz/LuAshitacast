local practiceBRD = {}

-- Everything a BRD 41 can know on Horizon.
-- target = 'me' for party songs, 't' for enemy songs.
local songs = {
    { name = "Knight's Minne",     kind = 'minne',    target = 'me' },
    { name = "Valor Minuet",       kind = 'minuet',   target = 'me' },
    { name = "Army's Paeon",       kind = 'paeon',    target = 'me' },
    { name = "Foe Requiem",        kind = 'requiem',  target = 't'  },
    { name = "Herb Pastoral",      kind = 'pastoral', target = 'me' },
    { name = "Light Threnody",     kind = 'threnody', target = 't'  },
    { name = "Sword Madrigal",     kind = 'madrigal', target = 'me' },
    { name = "Dark Threnody",      kind = 'threnody', target = 't'  },
    { name = "Sheepfoe Mambo",     kind = 'mambo',    target = 'me' },
    { name = "Earth Threnody",     kind = 'threnody', target = 't'  },
    { name = "Army's Paeon II",    kind = 'paeon',    target = 'me' },
    { name = "Foe Lullaby",        kind = 'lullaby',  target = 't'  },
    { name = "Water Threnody",     kind = 'threnody', target = 't'  },
    { name = "Foe Requiem II",     kind = 'requiem',  target = 't'  },
    { name = "Wind Threnody",      kind = 'threnody', target = 't'  },
    { name = "Scop's Operetta",    kind = 'operetta', target = 'me' },
    { name = "Fire Threnody",      kind = 'threnody', target = 't'  },
    { name = "Knight's Minne II",  kind = 'minne',    target = 'me' },
    { name = "Enchanting Etude",   kind = 'etude',    target = 'me' },
    { name = "Ice Threnody",       kind = 'threnody', target = 't'  },
    { name = "Valor Minuet II",    kind = 'minuet',   target = 'me' },
    { name = "Lightning Threnody", kind = 'threnody', target = 't'  },
    { name = "Spirited Etude",     kind = 'etude',    target = 'me' },
    { name = "Mage's Ballad",      kind = 'ballad',   target = 'me' },
    { name = "Learned Etude",      kind = 'etude',    target = 'me' },
    { name = "Horde Lullaby",      kind = 'lullaby',  target = 't'  },
    { name = "Quick Etude",        kind = 'etude',    target = 'me' },
    { name = "Advancing March",    kind = 'march',    target = 'me' },
    { name = "Vivacious Etude",    kind = 'etude',    target = 'me' },
    { name = "Hunter's Prelude",   kind = 'prelude',  target = 'me' },
    { name = "Dextrous Etude",     kind = 'etude',    target = 'me' },
    { name = "Fowl Aubade",        kind = 'aubade',   target = 'me' },
    { name = "Magic Finale",       kind = 'finale',   target = 't'  },
    { name = "Sinewy Etude",       kind = 'etude',    target = 'me' },
    { name = "Army's Paeon III",   kind = 'paeon',    target = 'me' },
    { name = "Light Carol",        kind = 'carol',    target = 'me' },
    { name = "Foe Requiem III",    kind = 'requiem',  target = 't'  },
    { name = "Earth Carol",        kind = 'carol',    target = 'me' },
    { name = "Battlefield Elegy",  kind = 'elegy',    target = 't'  },
    { name = "Water Carol",        kind = 'carol',    target = 'me' },
    { name = "Knight's Minne III", kind = 'minne',    target = 'me' },
    { name = "Raptor Mazurka",     kind = 'mazurka',  target = 'me' },
}

local aliases = {
    etudes = 'etude', minne = 'minne', minnes = 'minne',
    minuets = 'minuet', paeons = 'paeon', carols = 'carol',
    threnodies = 'threnody', requiems = 'requiem',
    lullabies = 'lullaby', madrigals = 'madrigal',
}

local state = {
    running  = false,
    index    = 1,
    stopFlag = false,
    buffer   = 2.75,
    queue    = {},
}

local function debugPrint(msg)
    if gSettings and gSettings.Debug then
        print(chat.header('practiceBRD') .. chat.message(msg))
    end
end

local function queueCmd(cmd)
    AshitaCore:GetChatManager():QueueCommand(1, cmd)
end

local function getSpell(name)
    return AshitaCore:GetResourceManager():GetSpellByName(name, 0)
end

local function hasSpell(name)
    local res = getSpell(name)
    if not res or not res.Index then return false end
    local ok, result = pcall(function()
        return AshitaCore:GetMemoryManager():GetPlayer():HasSpell(res.Index)
    end)
    if ok then return result == true end
    return true
end

local function getCastDelay(name)
    local res = getSpell(name)
    if not res then return 8 + state.buffer end
    return ((res.CastTime or 32) * 0.25) + state.buffer
end

local function normalizeKind(kind)
    kind = string.lower(kind or '')
    return aliases[kind] or kind
end

local function stopPractice(reason)
    state.running  = false
    state.stopFlag = false
    state.index    = 1
    state.queue    = {}
    print(chat.header('practiceBRD') .. chat.message(reason or 'Stopped.'))
end

-- kind == nil: one of each self-buff. otherwise every learned song of that family.
local function buildQueue(kind)
    local q = {}
    local seen = {}
    for _, song in ipairs(songs) do
        if not hasSpell(song.name) then
            debugPrint('Skipping unlearned: ' .. song.name)
        elseif kind then
            if song.kind == kind then
                table.insert(q, song)
            end
        elseif song.target == 'me' and not seen[song.kind] then
            table.insert(q, song)
            seen[song.kind] = true
        end
    end
    return q
end

local function nextStep()
    if state.stopFlag or not state.running then
        stopPractice('Stopped by user.')
        return
    end
    if state.index > #state.queue then
        stopPractice('Finished.')
        return
    end

    local song = state.queue[state.index]
    local tgt = song.target == 't' and '<t>' or '<me>'
    print(chat.header('practiceBRD') .. chat.message(string.format(
        '[%d/%d] %s (%s)', state.index, #state.queue, song.name, song.kind)))
    queueCmd('/ma "' .. song.name .. '" ' .. tgt)

    state.index = state.index + 1
    ashita.tasks.once(getCastDelay(song.name), nextStep)
end

function practiceBRD.start(kind, buffer)
    if state.running then
        print(chat.header('practiceBRD') .. chat.message('Already running. Use /practice stop'))
        return
    end
    if buffer then state.buffer = buffer end

    state.queue = buildQueue(kind)
    if #state.queue == 0 then
        print(chat.header('practiceBRD') .. chat.message(
            kind and ('No learned ' .. kind .. ' songs.') or 'No learned buff songs found.'))
        return
    end

    state.running  = true
    state.stopFlag = false
    state.index    = 1
    print(chat.header('practiceBRD') .. chat.message(string.format(
        'Starting %d song%s%s...', #state.queue, #state.queue == 1 and '' or 's',
        kind and (' [' .. kind .. ']') or '')))
    nextStep()
end

function practiceBRD.stop()
    if not state.running then
        print(chat.header('practiceBRD') .. chat.message('Not currently running.'))
        return
    end
    state.stopFlag = true
end

function practiceBRD.handleCommand(args)
    -- /lac fwd practice [etudes|stop|2.5]
    local cmd = args[2] and string.lower(args[2]) or ''
    if cmd == 'stop' then
        practiceBRD.stop()
        return
    end
    local buffer = tonumber(cmd)
    local kind = (cmd ~= '' and not buffer) and normalizeKind(cmd) or nil
    practiceBRD.start(kind, buffer)
end

return practiceBRD