--- @class WeaponComponent
--- @field name string
--- @field weapon_id number
--- @field config_data WeaponConfigData
--- @field current_amount number
--- @field current_time number
--- @field is_reloading boolean
local weapon_component = {
    name = "weapon_component"
}

function weapon_component.new()
    local self = {}
    self.name = weapon_component.name
    self.weapon_id = nil
    self.config_data = nil
    return self
end

return weapon_component
