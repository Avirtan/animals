--- @class UnitControllerComponent
--- @field url hash
--- @field position vector3
local unit_controller_component = {
    name = "unit_controller_component"
}

function unit_controller_component.new(url, position)
    local self = setmetatable({}, { __index = unit_controller_component })
    self.url = url
    self.position = position or go.get(self.url, "position")
    return self
end

return unit_controller_component
