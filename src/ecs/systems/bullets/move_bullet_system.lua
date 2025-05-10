local world_ecs = require "src.ecs.world_ecs"
local bullet_controller_component = require "src.ecs.components.bullets.bullet_controller_component"
local move_component = require "src.ecs.components.move.move_component"
local bullet_tag_component = require "src.ecs.components.tags.bullet_tag_component"

local log = require("log.log")

local move_bullet_system = {
}

function move_bullet_system.init(world_id)
end

function move_bullet_system.update(world_id, dt)
    local entites = world_ecs.select_component(world_id, bullet_tag_component.tag_bullet_name,
        bullet_controller_component.name, move_component.name)

    for _, entity in ipairs(entites) do
        --- @type MoveComponent
        local component_move = world_ecs.get_component(world_id, entity, move_component.name)
        --- @type BulletControllerComponent
        local component_controller = world_ecs.get_component(world_id, entity, bullet_controller_component.name)

        component_controller.position = component_controller.position +
            component_move.dir_move * component_move.speed * dt
        go.set_position(component_controller.position, component_controller.url)
    end
end

function move_bullet_system.fixed_update(world_id, dt)
end

function move_bullet_system.destroy(world_id)
end

return move_bullet_system
