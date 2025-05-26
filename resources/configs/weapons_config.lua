---@class WeaponConfigData
---@field id integer              # Уникальный идентификатор оружия
---@field name string             # Название оружия
---@field damage integer          # Наносимый урон за выстрел
---@field amount integer          # Количество патронов/зарядов
---@field angle number            # Угол разброса (в градусах)
---@field move_angle number       # Угол разброса при движении (в градусах)
---@field bullet_count integer    # Количество пуль за выстрел
---@field bullet_speed number     # Скорость пули (в условных единицах)
---@field range number            # Дальность стрельбы
---@field reloading_time number   # Время перезарядки (в секундах)
---@field cooldown number         # Задержка между выстрелами (в секундах)

---@class WeaponsConfig
---@field [string] WeaponConfigData
local weapons_config = {
    {
        id = 1,
        name = "gun",
        damage = 10,
        amount = 5,
        angle = 10,
        move_angle = 20,
        range = 70,
        bullet_count = 1,
        bullet_speed = 150,
        reloading_time = 2,
        cooldown = 0.2
    },
    {
        id = 2,
        name = "shotgun",
        damage = 15,
        amount = 3,
        angle = 30,
        range = 60,
        move_angle = 50,
        bullet_count = 3,
        bullet_speed = 150,
        reloading_time = 3,
        cooldown = 0.1
    }
}


return weapons_config
