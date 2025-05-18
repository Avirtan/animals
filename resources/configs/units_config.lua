---@class UnitDataConfig
---@field id integer               # Уникальный идентификатор юнита
---@field animation_key string    # Ключ анимации, используемый для поиска в `animations`

---@class UnitsTypeConfig
---@field [string] UnitDataConfig  # Динамические ключи (solder, infantry и др.)

---@class AnimationMoveConfig
---@field idle string
---@field up string
---@field down string
---@field right string
---@field left string

---@class AnimationsConfig
---@field move AnimationMoveConfig   # Динамические ключи (например, "unit", "vehicle")

---@class UnitsConfig
---@field units_type UnitsTypeConfig     # Конфигурация юнитов
---@field animations AnimationsConfig    # Конфигурация анимаций

---@type UnitsConfig
local units_config = {
    units_type = {
        solder = {
            id = 1,
            animation_key = "solder",
        },
        infantry = {
            id = 2,
            animation_key = "infantry",
        },
    },
    animations = {
        move = {
            idle = "idle",
            up = "up",
            down = "down",
            right = "right",
            left = "left"
        }
    },

}


return units_config
