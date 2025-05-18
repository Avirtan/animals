--- @class AimControllerComponent
--- @field url hash
local aim_controller_component = {
    name = "aim_controller_component"
}

function aim_controller_component.new(url, entity)
    local self = {}
    self.name = aim_controller_component.name
    self.url = url
    go.set(url, "entity_id", entity)

    return self
end

return aim_controller_component
