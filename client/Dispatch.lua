function Dispatch()
    if Config.Dispatch == "ps" then
        exports['ps-dispatch']:SuspiciousActivity()
    elseif Config.Dispatch == "qs" then
        exports['qs-dispatch']:SuspiciousActivity()
    elseif Config.Dispatch == "custom" then
        -- put your exports here
    end
end