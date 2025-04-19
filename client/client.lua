-- QBCore Exports / Variables --
local QBCore = exports['qb-core']:GetCoreObject()
local RecentRobbery = 0, 0, 0
local RewardTaked = false
local FailedTime = 0

RegisterNetEvent('Lz-MeterRobbery:client:UnscrewBackplate', function()
    if RecentRobbery == 0 or GetGameTimer() > RecentRobbery then
        if FailedTime < Config.FailedTime then
            QBCore.Functions.TriggerCallback('Lz-MeterRobbery:server:PoliceInteger', function(ReturnStatus)
                if ReturnStatus then
                    QBCore.Functions.TriggerCallback('Lz-MeterRobbery:server:ScrewDriverSet', function(ItemScan)
                        if ItemScan then
                            PlayAnimEmote()
                            Wait(2000)
                            Dispatch()
                            ClearPedTasks(PlayerPedId())
                            MiniGames(function(callback)
                                if callback == 'SUCCESS' then
                                        QBCore.Functions.Notify("You Found Some Money"  , 'success')
                                        RecentRobbery = GetGameTimer() + Config.Cooldown
                                        ClearPedTasks(PlayerPedId())
                                        DeleteEntity(ScrewDriver)
                                        FailedTime = 0
                                        Wait(3000)
                                        Reward = CreateObject("h4_prop_h4_gold_pile_01a",GetEntityCoords(PlayerPedId()), true,true,true)
                                        PlaceObjectOnGroundProperly(Reward)
                                        if DoesEntityExist(Reward) then
                                            exports['qb-target']:AddTargetEntity(Reward, {
                                                options = {
                                                    {
                                                        type = "client",
                                                        event = 'Lz-Reward',
                                                        icon = "fas fa-box-circle-check",
                                                        label = "Get Package",
                                                    },
                                                },
                                                distance = 3.0
                                            })
                                        end
                                elseif callback == 'FAILED' then
                                    FailedTime = FailedTime + 1
                                        Citizen.SetTimeout(Config.ResetTime, function()
                                            if FailedTime == Config.FailedTime then
                                                FailedTime = 0
                                            end

                                        end)
                                    QBCore.Functions.Notify('The Screw is Still There ', 'error')
                                end
                            end)
                        else
                            QBCore.Functions.Notify("You Miss This Item :" .. Config.RequiredItem .. " ! ", 'error')
                        end
                    end, Config.RequiredItem)
                end
            end)
        else
            QBCore.Functions.Notify('You Reach The Limit', 'error')
            DeleteEntity(ScrewDriver)
        end
    else
    QBCore.Functions.Notify('Come back later', 'error')
end
end)

RegisterNetEvent("Lz-Reward",function()
    if RewardTaked == false then
        RewardTaked = true
        TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_PICK_UP', 0, true)
        DeleteEntity(Reward)
        QBCore.Functions.Progressbar('Backplate', 'Reward ...', Config.ProgressBarInteger, false, true, { 
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
        animDict = 'pickup_object',
            anim = 'pickup_low',
            flags = 2,
        }, {}, {}, function()
        end)
        TriggerServerEvent("Lz-MeterRobbery:server:AddMoney")
        if Config.ItemReward == true then
            TriggerServerEvent("Lz-Park:GiveItem")
        end
    end
end)
function PlayAnimEmote()
    ClearPedTasks(PlayerPedId())
    RequestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
    while not HasAnimDictLoaded("anim@amb@clubhouse@tutorial@bkr_tut_ig3@") do
        Wait(10)
    end
    TaskPlayAnim(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 8.0, -8.0, -1, 1, 0, false, false, false)
    ScrewDriver = CreateObject("prop_tool_screwdvr03",GetEntityCoords(PlayerPedId()), true,true,true)
    AttachEntityToEntity(ScrewDriver, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.1, 0.02, 0.0,     90.0, 0.0, 0.0,   true, true, false, true, 1, true)
end
function MiniGames(cb)
    if Config.MiniGame == 'ps-ui' then
        exports['ps-ui']:Circle(function(success)
            if success then
                cb("SUCCESS")
            else
                cb("FAILED")
            end
        end, Config.PsCircle, Config.psTime)
    elseif Config.MiniGame == 'mx-bolt' then
        TriggerEvent("mxStartBoltGame", 50, 50, Config.ScrewSpeed, Config.ScrewDifficulty, function(result)
            cb(result)
        end)
    end
end
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
     RecentRobbery = 0, 0, 0
     RewardTaked = false
     FailedTime = 0
     if DoesEntityExist(ScrewDriver) then
        DeleteEntity(ScrewDriver)
     end
     if DoesEntityExist(Reward) then
        DeleteEntity(Reward)
     end
end)