Config = {}

-- Parking Meter Config --
Config.Cooldown = 60000--(60000 * 2) -- Parking Meter Cooldown

Config.RequiredPolice = 0 -- Parking Meter Required Police

Config.Dispatch = "ps" --ps/ qs or custom : You can add your own export inside dispatch.lua

Config.RequiredItem = 'screwdriverset' -- RequiredItem to rob Parking Meter

Config.ProgressBarInteger = 3000 -- Length for all Progress Bars

-- Parking Meter Props -- 
Config.ParkingMeterProps = {
    'prop_parknmeter_01',
    'prop_parknmeter_02'
}

-- Parking Meter Third-Eye / Rewards --
Config.MeterLabel = 'Unscrew' -- Third-Eye Label
Config.MeterIcon = 'fa-solid fa-square-parking' -- Third-Eye Icon

Config.RewardMoney = math.random(500, 2000) -- Reward Money ($500 - $2,000)
Config.ItemReward = true
Config.Items = { -------- if u want to get items instead of money or to get both make it true
    {name = "goldbar", amount = 10},  -- Item  with amount 10
    -- Add more items here if needed
}


--------------mini games
Config.MiniGame = "mx-bolt" -- ps-ui / mx-bolt
Config.PsCircle = 3 --- number of circle in ps-ui
Config.psTime = 20 ------ time of minigame
--- if mini game = mx_boltgame 
Config.ScrewSpeed = 0.2 -- 0.5 1.0 or 1.5
Config.ScrewDifficulty = 1 --  1 to 4

Config.FailedTime = 2 -- when u failed 3 times you cant rob again until Reset Time (Not cooldown)

Config.ResetTime = 60000*2 ----after that time u can rob again