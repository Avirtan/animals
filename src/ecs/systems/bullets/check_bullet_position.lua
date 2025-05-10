local world_ecs = require "src.ecs.world_ecs"
local bullet_controller_component = require "src.ecs.components.bullets.bullet_controller_component"
local move_component = require "src.ecs.components.move.move_component"
local bullet_tag_component = require "src.ecs.components.tags.bullet_tag_component"
local camera_service = require "src.services.camera_service"

local log = require("log.log")

local check_bullet_position = {
}

function check_bullet_position.init(world_id)
end

function check_bullet_position.update(world_id, dt)
    local entites = world_ecs.select_component(world_id, bullet_tag_component.tag_bullet_name,
        bullet_controller_component.name, move_component.name)

    for _, entity in ipairs(entites) do
        --- @type MoveComponent
        local component_move = world_ecs.get_component(world_id, entity, move_component.name)
        --- @type BulletControllerComponent
        local component_controller = world_ecs.get_component(world_id, entity, bullet_controller_component.name)
        local position = go.get_position(component_controller.url)
        if camera_service.is_offscreen(position) then
            world_ecs.delete_entity(world_id, entity)
            go.delete(component_controller.url)
        end
    end
end

function check_bullet_position.fixed_update(world_id, dt)
end

function check_bullet_position.destroy(world_id)
end

return check_bullet_position
