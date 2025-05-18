--- @class ChangeWeaponComponent
--- @field id number
local change_weapon_component = {
    name = "change_weapon_component"
}

function change_weapon_component.new(id)
    local self = {}
    self.name = change_weapon_component.name
    self.id = id
    return self
end

return change_weapon_component
