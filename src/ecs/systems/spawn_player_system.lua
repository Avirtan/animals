local factory_service = require "src.services.levels.factory_service"
local world_ecs = require "src.ecs.world_ecs"
local unit_controller_component = require "src.ecs.components.units.unit_controller_component"
local sprite_component = require "src.ecs.components.animation.sprite_component"
local spawn_player_component = require "src.ecs.components.sapwn_units.spawn_player_component"

local log = require("log.log")

local spawn_player_system = {
}

function spawn_player_system.init(world_id)
    -- log:info("world", world.components)
end

function spawn_player_system.update(world_id, dt)
    local entites = world_ecs.select_component(world_id, spawn_player_component.name)

    for index, value in ipairs(entites) do
        local entity = world_ecs.create_entity(world_id)
        local url_player_collection = factory_service.spawn_object_collection(factory_service.factory_name.player)
        local player_controller_url = url_player_collection[hash("/player_character")]
        local unit_controller = msg.url(nil, player_controller_url, "unit_controller")
        local srpite_url = go.get(unit_controller, "url_sprite")
        local component_unit = unit_controller_component.new(player_controller_url)
        local component_sprite = sprite_component.new(srpite_url)
        world_ecs.add_components(world_id, entity, component_unit, component_sprite)
        world_ecs.delete_entity(world_id, value)
        log:info("world", world_ecs.new(world_id))
    end
end

function spawn_player_system.fixed_update(world_id, dt)
end

function spawn_player_system.destroy(world_id)
end

return spawn_player_system
