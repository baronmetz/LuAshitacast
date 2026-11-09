local resist = {};

local validElements = {
    fire       = 'Fire',
    ice        = 'Ice',
    wind       = 'Wind',
    air        = 'Wind',      -- optional alias
    earth      = 'Earth',
    stone      = 'Earth',     -- optional alias
    lightning  = 'Lightning',
    thunder    = 'Lightning', -- optional alias
    ltn        = 'Lightning',
    water      = 'Water',
    light      = 'Light',
    dark       = 'Dark',
};

resist.idleSet = 'Idle';
function resist.resist(args)
    local arg = args[2] and args[2]:lower() or nil;
    if arg == nil or arg == 'none' then
        resist.idleSet = 'Idle';
        print(chat.header('Resist: ') .. chat.message('Resistance off, reset to Idle'));
    elseif validElements[arg] then
        resist.idleSet = 'Resist' .. validElements[arg];
        print(chat.header('Resist: ') .. chat.message('Idle set changed to ' .. resist.idleSet));
    else
        print(chat.header('Resist: ') .. chat.message('Unrecognized element. Usage: /resist [fire|ice|wind|earth|lightning|water|light|dark]'));
        return;
    end
end

return resist;