## Lz-Scripts
# Description
- You can rob all the park meter prop inside all the map of course there is a cooldown you can make how much u want and you get money (default) if u want to add an item as a reward You can make it true inside the config
- you can change everything like mini games and dispatch calls

## Preview

- [Watch Preview](https://www.youtube.com/watch?v=rVJrKZRFrPE&ab_channel=Lz-Scripts)

## Dependencies

* [qb-target](https://github.com/qbcore-framework/qb-target)
* [ps-ui](https://github.com/Project-Sloth/ps-ui)
* [ps-dispatch](https://github.com/Project-Sloth/ps-dispatch)

## Installation

* Download The File 
* Drag and drop into `[standalone]`  the mini game folder "mx_boltgame"
* Restart your server



## ps-dispatch > client > cl_events.lua
if u want to add a custom dispatch call you can add this inisde the Ps-dispatch and edit inside file Dispatch.lua
```lua
-- Meter Robbery
local function MeterRobbery(camId)
    local currentPos = GetEntityCoords(PlayerPedId())
    local locationInfo = getStreetandZone(currentPos)
    local gender = GetPedGender()
    TriggerServerEvent("dispatch:server:notify", {
        dispatchcodename = "meterrobbery", -- has to match the codes in sv_dispatchcodes.lua so that it generates the right blip
        dispatchCode = "10-90",
        firstStreet = locationInfo,
        gender = gender,
        camId = camId,
        model = nil,
        plate = nil,
        priority = 2, -- priority
        firstColor = nil,
        automaticGunfire = false,
        origin = {
            x = currentPos.x,
            y = currentPos.y,
            z = currentPos.z
        },
        dispatchMessage = _U('meterrobbery'), -- message
        job = { "police" } -- jobs that will get the alerts
    })
end

exports('MeterRobbery', MeterRobbery)
```

## ps-dispatch > server > sv_dispatchcodes.lua
```lua
	-- Meter Robbery
	["meterrobbery"] = {displayCode = '10-90', description = "Meter Robbery In Progress", radius = 0, recipientList = {'LEO', 'police'}, blipSprite = 500, clipColour = 1, blipScale = 1.5, blipLength = 2, sound = "Lose_1st", sound2 = "FTAO_FM_Events_Soundset", offset = "false", blipflash = "false"},
```

## Usage
- You can change everything :
- Cooldown 
- required police
- amount of cash 
- if u want to recieve item with the cash u set up Config.Items = true




# Credits
* if You Faced some issue or some problem please dont hesitate to open ticket in our discord : (https://discord.gg/QYCvHQGsJn)
