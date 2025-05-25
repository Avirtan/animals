local world_ecs = require "src.ecs.world_ecs"
local collision_component = require "src.ecs.components.physics.collision_component"
local bullet_tag_component = require "src.ecs.components.tags.bullet_tag_component"
local bullet_controller_component = require "src.ecs.components.bullets.bullet_controller_component"
local change_health_component = require "src.ecs.components.events.unit_state.change_health_component"
local units_service = require "src.services.units.units_service"

local log = require("log.log")

local bullet_check_collision = {
}

function bullet_check_collision.init(world_id)
end

function bullet_check_collision.update(world_id, dt)
    local entites = world_ecs.select_component(world_id, bullet_tag_component.tag_bullet_name, collision_component.name,
        bullet_controller_component.name)

    for _, entity in ipairs(entites) do
        --- @type CollisionComponent
        local component_collision = world_ecs.get_component(world_id, entity, collision_component.name)
        --- @type BulletControllerComponent
        local component_bullet = world_ecs.get_component(world_id, entity, bullet_controller_component.name)
        if component_collision.is_collide then
            if component_collision.other_group == hash("map") then
            elseif component_collision.other_group == hash("enemy") then
                bullet_check_collision.collision_enemy(world_id, component_collision)
            end
            go.delete(component_bullet.url)
            world_ecs.delete_entity(world_id, entity)
        end
    end
end

function bullet_check_collision.collision_enemy(world_id, component_collision)
    local url_enemy = component_collision.other_id
    if units_service.units_alive[url_enemy] == nil then
        return
    end
    local unit_controller = msg.url(nil, url_enemy, "unit_controller")
    local id = go.get(unit_controller, "entity_id")
    local entity_change_health = world_ecs.create_entity(world_id)
    world_ecs.add_component(world_id, entity_change_health, change_health_component.new(-10, id))
end

function bullet_check_collision.fixed_update(world_id, dt)
end

function bullet_check_collision.destroy(world_id)
end

return bullet_check_collision
