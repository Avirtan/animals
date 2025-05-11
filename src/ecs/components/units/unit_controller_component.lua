--- @class UnitControllerComponent
--- @field url hash
--- @field position vector3
local unit_controller_component = {
    name = "unit_controller_component"
}

function unit_controller_component.new(url, entity, position)
    local self = {}
    self.name = unit_controller_component.name
    self.url = url
    self.position = position or go.get(self.url, "position")
    go.set(url, "entity_id", entity)

    return self
end

return unit_controller_component
