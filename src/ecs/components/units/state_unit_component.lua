--- @class StateUnitComponent
--- @field health number
local state_unit_component = {
    name = "state_unit_component"
}

function state_unit_component.new(health)
    local self = {}
    self.name = state_unit_component.name
    self.health = health
    return self
end

return state_unit_component
