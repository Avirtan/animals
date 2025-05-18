--- @class CooldownWaponComponent
--- @field name string
--- @field time number
--- @field current_value number
local cooldown_weapon_component = {
    name = "cooldown_weapon_component"
}

function cooldown_weapon_component.new()
    local self = {}
    self.name = cooldown_weapon_component.name
    self.time = 0
    self.current_value = 0
    return self
end

return cooldown_weapon_component
