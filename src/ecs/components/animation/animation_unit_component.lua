--- @class AnimationUnitComponent
--- @field current_animation userdata
local animation_unit_component = {
    name = "animation_unit_component"
}

function animation_unit_component.new()
    local self = {}
    self.name = animation_unit_component.name
    self.current_animation = nil
    return self
end

return animation_unit_component
