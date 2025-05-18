---@class UnitsConfig
local units_config = {
    units_type = {
        solder = {
            id = 1,
            animation_key = "solder",
            type = "unit"
        },
        infantry = {
            id = 2,
            animation_key = "infantry",
            type = "unit"
        },
    },
    animations = {
        unit = {
            idle = "idle",
            up = "up",
            down = "down",
            right = "right",
            left = "left"
        }
    },

}


return units_config
