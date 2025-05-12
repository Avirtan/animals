--- @class TargetComponent
--- @field name string
--- @field target hash
local target_component = {
    name = "target_component"
}

function target_component.new()
    local self = {}
    self.name = target_component.name
    return self
end

return target_component
