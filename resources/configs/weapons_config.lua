---@class WeaponConfigData
---@field id integer       # Уникальный идентификатор оружия
---@field damage integer  # Наносимый урон
---@field amount integer  # Количество (патронов/использований)
---@field angle number    # Угол разброса (в градусах)
---@field move_angle number # Угол смещения при движении (в градусах)

---@class WeaponsConfig
---@field [string] WeaponConfigData # Другие виды оружия (динамические ключи)
local weapon_config = {
    gun = {
        id = 1,
        damage = 10,
        amount = 5,
        angel = 10,
        move_angle = 20
    },
    shotgun = {
        id = 2,
        damage = 15,
        amount = 3,
        angel = 30,
        move_angle = 50
    }
}


return weapon_config
