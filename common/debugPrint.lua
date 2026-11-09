local debugPrint = {};

function debugPrint.printDebug(...)
    if gSettings.Debug then
        print(...)
    end
end

return;