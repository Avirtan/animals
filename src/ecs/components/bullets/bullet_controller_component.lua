--- @class BulletControllerComponent
--- @field url hash
--- @field position vector3
local bullet_controller_component = {
    name = "bullet_controller_component"
}

function bullet_controller_component.new(url, position)
    local self = {}
    self.name = bullet_controller_component.name
    self.url = url
    self.position = position or go.get(self.url, "position")
    return self
end

return bullet_controller_component
