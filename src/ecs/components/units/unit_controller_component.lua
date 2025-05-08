--- @class UnitControllerComponent
--- @field url hash
local unit_controller_component = {
    name = "unit_controller_component"
}

function unit_controller_component.new(url)
    local self = setmetatable({}, { __index = unit_controller_component })
    self.url = url
    return self
end

return unit_controller_component
