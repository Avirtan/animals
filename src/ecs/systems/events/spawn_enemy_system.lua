local factory_service = require "src.services.levels.factory_service"
local ecs_units_service = require "src.services.ecs.ecs_units_service"
local world_ecs = require "src.ecs.world_ecs"
local spawn_enemy_component = require "src.ecs.components.events.sapwn_units.spawn_enemy_component"
local character_tag_component = require "src.ecs.components.tags.character_tag_component"
local target_component = require "src.ecs.components.targets.target_component"
local move_astar_component = require "src.ecs.components.move.move_astar_component"
local units_service = require "src.services.units.units_service"

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

        local url_enemy = factory_service.spawn_object_factory(factory_service.factory_name.enemy)

        -- local health_url = go.get(unit_controller, "url_health")
        local unit_config = units_service.get_unit_config(component_spawn.type_unit)
        -- label.set_text(health_url, component_state_unit.health .. " hp")

        local entity = ecs_units_service.create_unit_entity(world_id, component_spawn.position, unit_config, url_enemy, 0,
            100)

        local component_tag = character_tag_component.new_enemy_tag()
        local component_target = target_component.new()
        local component_astar = move_astar_component.new()
        world_ecs.add_components(world_id, entity, component_tag, component_astar, component_target)
        world_ecs.delete_entity(world_id, value)
    end
end

function spawn_player_system.fixed_update(world_id, dt)
end

function spawn_player_system.destroy(world_id)
end

return spawn_player_system
