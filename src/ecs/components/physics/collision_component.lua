local events_service = require "src.services.events_service"

--- @class CollisionComponent
--- @field is_collide bool
--- @field normal vector3
--- @field distance number
--- @field other_group hash
--- @field other_id hash
local collision_component = {
    name = "collision_component"
}

function collision_component.new()
    local self = setmetatable({}, { __index = collision_component })
    self.normal = vmath.vector3()
    return self
end

--- @param component CollisionComponent
--- @param message_id any
--- @param message any
function collision_component.set_collision(component, message_id, message)
    if component == nil then
        return
    end
    if message_id == events_service.physics.contact_point_response then
        component.is_collide = true
        component.normal.x = component.normal.x + message.normal.x
        component.normal.y = component.normal.y + message.normal.y
        component.distance = message.distance
        component.other_group = message.other_group
        component.other_id = message.other_id
    end
end

--- @param component CollisionComponent
function collision_component.reset_collision(component)
    component.is_collide = false
    component.normal.x = 0
    component.normal.y = 0
end

return collision_component
