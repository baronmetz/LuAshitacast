-- common/weather.lua
local weather = {};

-- Element → chat color mapping (tweak numbers if you prefer different shades)
local elementColor = {
    ['Fire']     = 1,   -- Red
    ['Ice']      = 6,   -- Cyan
    ['Wind']     = 2,   -- Green
    ['Earth']    = 5,   -- Yellow/Brown
    ['Thunder']  = 3,   -- Blue / Purple-ish
    ['Water']    = 4,   -- Blue
    ['Light']    = 7,   -- White / Light
    ['Dark']     = 8,   -- Gray / Dark
    ['None']     = 0,   -- Default
    ['Unknown']  = 0,
};

local function colorize(text, element)
    local c = elementColor[element] or 0;
    if c == 0 then
        return text;
    end
    return chat.color1(c, text);
end

function weather.Show()
    local env = gData.GetEnvironment();

    local day        = env.Day or 'Unknown';
    local dayElement = env.DayElement or 'Unknown';
    local moon       = env.MoonPhase or 'Unknown';
    local moonPct    = env.MoonPercent or 0;
    local rawWeather = env.RawWeather or 'Unknown';
    local weatherEle = env.RawWeatherElement or 'None';
    local time       = env.Time or 0;          -- e.g. 14.35 = 14:35

    -- Format time nicely (HH:MM)
    local hour   = math.floor(time);
    local minute = math.floor((time - hour) * 100 + 0.5);
    local timeStr = string.format('%02d:%02d', hour, minute);

    print(chat.header('weather') .. chat.message('Time:    ' .. timeStr));
    print(chat.header('weather') .. chat.message('Day:     ' .. colorize(day .. '  (' .. dayElement .. ')', dayElement)));
    print(chat.header('weather') .. chat.message(string.format('Moon:    %s  (%d%%)', moon, moonPct)));
    print(chat.header('weather') .. chat.message('Weather: ' .. colorize(rawWeather .. '  (' .. weatherEle .. ')', weatherEle)));
    if (moon == 'Full Moon' and day == 'Darksday' and (time <=  6 or time >= 18)) then
        print(chat.header('weather') .. chat.message('Treat Staff is active'));
    else
        print(chat.header('weather') .. chat.message('Treat Staff is inactive'));
    end
end

return weather;