local synth = {};

local synthRunning = false;

local function DoSynth(count)
    if synthRunning then
        print(chat.header('synth') .. chat.message('Already running – type /synth stop first.'));
        return;
    end

    count = tonumber(count) or 1;
    if count < 1 then count = 1; end
    if count > 10 then
         count = 10;
         print(chat.header('synth') .. chat.message('Can\'t synth more than 6 bucko, sorry.')); 
    end   -- safety limit

    synthRunning = true;
    print(chat.header('synth') .. chat.message(string.format('Starting %d synths (30 s delay)...', count)));

    local function step(remaining)
        if not synthRunning or remaining <= 0 then
            synthRunning = false;
            print(chat.header('synth') .. chat.message('Finished.'));
            return;
        end

        -- Issue the command
        AshitaCore:GetChatManager():QueueCommand(1, '/lastsynth');

        -- Schedule the next one
        ashita.tasks.once(30, function()
            step(remaining - 1);
        end);
    end

    step(count);
end

local function StopSynth()
    if synthRunning then
        synthRunning = false;
        print(chat.header('synth') .. chat.message('Stopped.'));
    else
        print(chat.header('synth') .. chat.message('Not running.'));
    end
end

function synth.synth(args)
    local arg = args[2];
    if arg == nil then
        DoSynth(1);
    elseif (arg == 'stop') then
        StopSynth();
    elseif tonumber(arg) then
        DoSynth(arg);   -- number of times
    else
        print(chat.header('synth') .. chat.message('Use /synth [number] or /synth stop only!'));
    end
    return;
end

return synth;