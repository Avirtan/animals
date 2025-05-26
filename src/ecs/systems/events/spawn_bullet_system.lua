local factory_service = require "src.services.levels.factory_service"
local bullets_service = require "src.services.weapon.bullets_service"

local world_ecs = require "src.ecs.world_ecs"
local bullet_controller_component = require "src.ecs.components.bullets.bullet_controller_component"
local spawn_bullet_component = require "src.ecs.components.events.spawn_bullets.spawn_bullet_component"
local move_component = require "src.ecs.components.move.move_component"
local bullet_tag_component = require "src.ecs.components.tags.bullet_tag_component"
local aim_component = require "src.ecs.components.player.aim_component"
local unit_controller_component = require "src.ecs.components.units.unit_controller_component"
local collision_component = require "src.ecs.components.physics.collision_component"
local weapon_component = require "src.ecs.components.weapon.weapon_component"

local log = require("log.log")

local spawn_bullet_system = {
}

function spawn_bullet_system.init(world_id)
end

function spawn_bullet_system.update(world_id, dt)
    local entites = world_ecs.select_component(world_id, spawn_bullet_component.name)

    for index, value in ipairs(entites) do
        local entites_aim = world_ecs.select_component(world_id, aim_component.name, unit_controller_component.name,
            weapon_component.name)
        local dir_aim = nil
        local posititon = nil
        local angle = nil
        local weapon_config = nil
        for index, value in ipairs(entites_aim) do
            --- @type AimComponent
            local component_aim = world_ecs.get_component(world_id, value, aim_component.name)
            dir_aim = component_aim.current_dir
            angle = component_aim.angle
            --- @type UnitControllerComponent
            local component_unit = world_ecs.get_component(world_id, value, unit_controller_component.name)
            posititon = go.get_position(component_unit.url)
            --- @type WeaponComponent
            local component_weapon = world_ecs.get_component(world_id, value, weapon_component.name)
            weapon_config = component_weapon.config_data or nil
        end
        --- @type SpawnBulletComponent
        local component_spawn = world_ecs.get_component(world_id, value, spawn_bullet_component.name)
        if dir_aim == nil or weapon_config == nil then
            world_ecs.delete_entity(world_id, value)
            break
        end
        local entity = world_ecs.create_entity(world_id)
        local url_bullet = factory_service.spawn_object_factory(factory_service.factory_name.bullet)

        local bullet_controller = msg.url(nil, url_bullet, "bullet_controller")
        local component_bullet = bullet_controller_component.new(bullet_controller, entity, posititon)
        local component_move = move_component.new(weapon_config.bullet_speed)
        component_move.dir_move = bullets_service.bullet_dir_move(dir_aim, angle)
        local component_tag = bullet_tag_component.new_bullet_tag()
        local component_collision = collision_component.new()

        world_ecs.add_components(world_id, entity, component_bullet, component_move, component_tag, component_collision)
        world_ecs.delete_entity(world_id, value)
    end
end

function spawn_bullet_system.fixed_update(world_id, dt)
end

function spawn_bullet_system.destroy(world_id)
end

return spawn_bullet_system
