--- @class UnitControllerComponent
--- @field url hash
--- @field url_controller hash
--- @field position vector3
--- @field unit_config UnitDataConfig
local unit_controller_component = {
    name = "unit_controller_component"
}

function unit_controller_component.new(url, url_controller, entity, position, unit_config)
    local self = {}
    self.name = unit_controller_component.name
    self.url = url
    self.position = position or go.get(self.url, "position")
    self.unit_config = unit_config
    self.url_controller = url_controller
    go.set(url_controller, "entity_id", entity)

    return self
end

return unit_controller_component
