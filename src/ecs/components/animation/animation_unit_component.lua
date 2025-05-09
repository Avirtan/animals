--- @class AnimationUnitComponent
--- @field current_animation userdata
--- @field type_unit string
local animation_unit_component = {
    name = "animation_unit_component"
}

function animation_unit_component.new(type_unit)
    local self = {} ---setmetatable({}, { __index = animation_unit_component })
    self.name = animation_unit_component.name
    self.current_animation = nil
    self.type_unit = type_unit
    return self
end

return animation_unit_component
