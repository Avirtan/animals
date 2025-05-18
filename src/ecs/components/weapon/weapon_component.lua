--- @class WeaponComponent
--- @field name string
--- @field weapon_id number
--- @field cached_data WeaponConfigData

local weapon_component = {
    name = "weapon_component"
}

function weapon_component.new()
    local self = {}
    self.name = weapon_component.name
    self.weapon_id = nil
    self.cached_data = nil
    return self
end

return weapon_component
