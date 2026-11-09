local delayCalculator = {};

function delayCalculator.calculateDelay(action, hastePercent)
    --haste defaults to 0 if not passed
    hastePercent = hastePercent or 0;

    -- Safety buffer (seconds). Increase if you have high latency or packet loss.
    local minimumBuffer = 2;

    -- Base cast time is in milliseconds
    local castTime = action.CastTime or 3000   -- fallback 3s if missing

    -- Convert FC % to a multiplier (e.g. 20% FC → 0.80)
    local fcMultiplier = 1 - (hastePercent / 100)

    -- Actual cast time after Fast Cast
    local actualCast = (castTime * fcMultiplier) / 1000

    -- Delay = actual cast time minus the safety buffer
    local delay = actualCast - minimumBuffer

    -- Never go below a tiny positive value
    if delay < 0.15 then
        delay = 0.15;
    end

    return delay;
end

return delayCalculator;