local aketoncheck = {}

----------------------------------------------------------------
-- Zone ID tables
----------------------------------------------------------------
local windurstZones = {
    [238] = true, -- Windurst Waters
    [239] = true, -- Windurst Walls
    [240] = true, -- Port Windurst
    [241] = true, -- Windurst Woods
    [242] = true, -- Heavens Tower
}

local sandyZones = {
    [230] = true, -- Southern San d'Oria
    [231] = true, -- Northern San d'Oria
    [232] = true, -- Port San d'Oria
    [233] = true, -- Chateau d'Oraguille
}

local bastokZones = {
    [234] = true, -- Bastok Mines
    [235] = true, -- Bastok Markets
    [236] = true, -- Port Bastok
    [237] = true, -- Metalworks
}

local jeunoZones = {
    [243] = true, -- Ru'Lude Gardens
    [244] = true, -- Upper Jeuno
    [245] = true, -- Lower Jeuno
    [246] = true, -- Port Jeuno
}

-- Optional later-game city areas (useful for Ducal Aketon style gear)
local otherCityZones = {
    [26]  = true, -- Tavnazian Safehold
    [48]  = true, -- Al Zahbi
    [50]  = true, -- Aht Urhgan Whitegate
    [53] = true, -- Nashmau (uncomment if you want it treated as a city)
}

----------------------------------------------------------------
-- Internal helper
----------------------------------------------------------------
local function getZoneId()
    return AshitaCore:GetMemoryManager():GetParty():GetMemberZone(0)
end

----------------------------------------------------------------
-- Public checks
----------------------------------------------------------------
function aketoncheck.isInWindy()
    return windurstZones[getZoneId()] == true
end

function aketoncheck.isInSandy()
    return sandyZones[getZoneId()] == true
end

function aketoncheck.isInBastok()
    return bastokZones[getZoneId()] == true
end

function aketoncheck.isInJeuno()
    return jeunoZones[getZoneId()] == true
end

-- Broad "city" check for Ducal Aketon / similar movement gear
-- Covers: 3 nations + Jeuno + Tavnazia + Al Zahbi / Whitegate
function aketoncheck.isInCity()
    local zoneId = getZoneId()
    return windurstZones[zoneId]
        or sandyZones[zoneId]
        or bastokZones[zoneId]
        or jeunoZones[zoneId]
        or otherCityZones[zoneId]
        or false
end

-- Optional: return zone id + name (handy for debugging)
function aketoncheck.getZoneInfo()
    local zoneId = getZoneId()
    local zoneName = AshitaCore:GetResourceManager():GetString('zones.names', zoneId)
        or AshitaCore:GetResourceManager():GetString('zones', zoneId)
        or 'Unknown'
    return zoneId, zoneName
end

return aketoncheck