--- @class ChangeHealthComponent
--- @field value number
--- @field entity number
local change_health_component = {
    name = "change_health_component"
}

function change_health_component.new(value, entity)
    local self = {}
    self.name = change_health_component.name
    self.value = value
    self.entity = entity
    return self
end

return change_health_component
