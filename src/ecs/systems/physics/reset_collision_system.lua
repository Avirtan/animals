local world_ecs = require "src.ecs.world_ecs"
local collision_component = require "src.ecs.components.physics.collision_component"

local reset_collision_system = {
}

function reset_collision_system.init(world_id)
end

function reset_collision_system.update(world_id, dt)
    local entites = world_ecs.select_component(world_id, collision_component.name)

    for _, entity in ipairs(entites) do
        --- @type CollisionComponent
        local component_collision = world_ecs.get_component(world_id, entity, collision_component.name)
        collision_component.reset_collision(component_collision)
    end
end

function reset_collision_system.fixed_update(world_id, dt)
end

function reset_collision_system.destroy(world_id)
end

return reset_collision_system
