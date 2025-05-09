local factory_service = require "src.services.levels.factory_service"

local world_ecs = require "src.ecs.world_ecs"
local bullet_controller_component = require "src.ecs.components.bullets.bullet_controller_component"
local spawn_bullet_component = require "src.ecs.components.events.spawn_bullets.spawn_bullet_component"
local move_component = require "src.ecs.components.move.move_component"
local bullet_tag_component = require "src.ecs.components.tags.bullet_tag_component"
local aim_component = require "src.ecs.components.player.aim_component"

local log = require("log.log")

local spawn_bullet_system = {
}

function spawn_bullet_system.init(world_id)
end

function spawn_bullet_system.update(world_id, dt)
    local entites = world_ecs.select_component(world_id, spawn_bullet_component.name)
    local entites_aim = world_ecs.select_component(world_id, aim_component.name)
    local dir_aim = nil
    for index, value in ipairs(entites_aim) do
        --- @type AimComponent
        local component_aim = world_ecs.get_component(world_id, value, aim_component.name)
        dir_aim = component_aim.current_dir
    end
    for index, value in ipairs(entites) do
        --- @type SpawnBulletComponent
        local component_spawn = world_ecs.get_component(world_id, value, spawn_bullet_component.name)
        if dir_aim == nil then
            world_ecs.delete_entity(world_id, value)
            break
        end
        local entity = world_ecs.create_entity(world_id)
        local url_bullet = factory_service.spawn_object_factory(factory_service.factory_name.bullet)
        local component_unit = bullet_controller_component.new(url_bullet, component_spawn.position)
        local component_move = move_component.new(20)
        component_move.dir_move.x = dir_aim.x
        component_move.dir_move.y = dir_aim.y
        local component_tag = bullet_tag_component.new_bullet_tag()

        world_ecs.add_components(world_id, entity, component_unit, component_move, component_tag)
        world_ecs.delete_entity(world_id, value)
    end
end

function spawn_bullet_system.fixed_update(world_id, dt)
end

function spawn_bullet_system.destroy(world_id)
end

return spawn_bullet_system
