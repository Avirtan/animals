--- @class TransformComponent
--- @field position vector3
local transform_component = {
    name = "transform_component"
}

function transform_component.new()
    local self = setmetatable({}, { __index = transform_component })
    self.position = vmath.vector3()
    return self
end

return transform_component
