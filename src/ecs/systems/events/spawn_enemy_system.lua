local factory_service = require "src.services.levels.factory_service"
local world_ecs = require "src.ecs.world_ecs"
local unit_controller_component = require "src.ecs.components.units.unit_controller_component"
local sprite_component = require "src.ecs.components.animation.sprite_component"
local spawn_enemy_component = require "src.ecs.components.events.sapwn_units.spawn_enemy_component"
local move_component = require "src.ecs.components.move.move_component"
local animation_unit_component = require "src.ecs.components.animation.animation_unit_component"
local character_tag_component = require "src.ecs.components.tags.character_tag_component"
local target_component = require "src.ecs.components.targets.target_component"
local move_astar_component = require "src.ecs.components.move.move_astar_component"

local log = require("log.log")

local spawn_player_system = {
}

function spawn_player_system.init(world_id)
end

function spawn_player_system.update(world_id, dt)
    local entites = world_ecs.select_component(world_id, spawn_enemy_component.name)

    for index, value in ipairs(entites) do
        --- @type SpawnEnemyComponent
        local component_spawn = world_ecs.get_component(world_id, value, spawn_enemy_component.name)

        local entity = world_ecs.create_entity(world_id)
        local url_enemy = factory_service.spawn_object_factory(factory_service.factory_name.enemy)
        local unit_controller = msg.url(nil, url_enemy, "unit_controller")
        local srpite_url = go.get(unit_controller, "url_sprite")

        local component_unit = unit_controller_component.new(unit_controller, entity, component_spawn.position)
        local component_sprite = sprite_component.new(srpite_url)
        local component_move = move_component.new(50)
        local component_animation = animation_unit_component.new(component_spawn.type_unit)
        local component_tag = character_tag_component.new_enemy_tag()
        local component_target = target_component.new()
        local component_astar = move_astar_component.new()

        world_ecs.add_components(world_id, entity, component_unit, component_sprite, component_move,
            component_animation, component_tag, component_target, component_astar)
        world_ecs.delete_entity(world_id, value)
    end
end

function spawn_player_system.fixed_update(world_id, dt)
end

function spawn_player_system.destroy(world_id)
end

return spawn_player_system
