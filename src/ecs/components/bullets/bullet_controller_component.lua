--- @class BulletControllerComponent
--- @field url hash
--- @field position vector3
local bullet_controller_component = {
    name = "bullet_controller_component"
}

function bullet_controller_component.new(url, entity, position)
    local self = {}
    self.name = bullet_controller_component.name
    self.url = url
    self.position = position or go.get_position(self.url)
    go.set_position(position, url)
    go.set(url, "entity_id", entity)

    return self
end

return bullet_controller_component
