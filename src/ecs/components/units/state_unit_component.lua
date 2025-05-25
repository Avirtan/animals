--- @class StateUnitComponent
--- @field health number
--- @field last_health number
local state_unit_component = {
    name = "state_unit_component"
}

function state_unit_component.new(health)
    local self = {}
    self.name = state_unit_component.name
    self.health = health
    self.last_health = 0
    return self
end

return state_unit_component
