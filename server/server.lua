-- QBCore Exports / Variables --
local QBCore = exports['qb-core']:GetCoreObject()

-- Police Amount On-Duty --
QBCore.Functions.CreateCallback('Lz-MeterRobbery:server:PoliceInteger', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local PoliceInteger = 0

    for i = 1, #Player do
        local xPlayer = QBCore.Functions.GetPlayer(Player[i])
        if (xPlayer.PlayerData.job.name == 'police' and xPlayer.PlayerData.job.onduty) then
            PoliceInteger = PoliceInteger + 1
        end
    end

    if PoliceInteger >= Config.RequiredPolice then
        cb(true)
    else
        cb(false)
        TriggerClientEvent('QBCore:Notify', src, ('Not enough police'), 'error')
    end
end)

-- Remove ScrewDriverSet on third eye of a Parking Meter --
QBCore.Functions.CreateCallback('Lz-MeterRobbery:server:ScrewDriverSet', function(source, cb, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local ScrewdriverScan = Player.Functions.GetItemByName(item)
    if ScrewdriverScan then
        cb(true)
        Player.Functions.RemoveItem(Config.RequiredItem, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.RequiredItem], 'remove', 1)
    else
        cb(false)
    end
end)

-- Add Money once Parking Meter is robbed --
RegisterNetEvent('Lz-MeterRobbery:server:AddMoney', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.AddMoney('cash', Config.RewardMoney, 'Parking Meter Payout')
end)


RegisterNetEvent('Lz-Park:GiveItem', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    for _, item in pairs(Config.Items) do
        Player.Functions.AddItem(item.name, item.amount)
        TriggerClientEvent('QBCore:Notify', src, "You received " .. item.amount .. " " .. item.name, "success")
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], 'add')
    end
end)