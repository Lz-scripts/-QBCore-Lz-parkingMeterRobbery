
exports['qb-target']:AddTargetModel(Config.ParkingMeterProps,  {
    options = {
      {
        type = 'client',
        event = 'Lz-MeterRobbery:client:UnscrewBackplate',
        icon = Config.MeterIcon,
        label = Config.MeterLabel,
      },
    },
    distance = 2.5,
})