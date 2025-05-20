local factory_service = require "src.services.levels.factory_service"
local camera_service = require "src.services.camera_service"
local units_service = require "src.services.units.units_service"
local world_ecs = require "src.ecs.world_ecs"
local unit_controller_component = require "src.ecs.components.units.unit_controller_component"
local sprite_component = require "src.ecs.components.animation.sprite_component"
local spawn_player_component = require "src.ecs.components.events.sapwn_units.spawn_player_component"
local move_input_component = require "src.ecs.components.move.move_input_component"
local move_component = require "src.ecs.components.move.move_component"
local animation_unit_component = require "src.ecs.components.animation.animation_unit_component"
local character_tag_component = require "src.ecs.components.tags.character_tag_component"
local aim_component = require "src.ecs.components.player.aim_component"
local collision_component = require "src.ecs.components.physics.collision_component"
local aim_controller_component = require "src.ecs.components.player.aim_controller_component"
local aim_selected_component = require "src.ecs.components.player.aim_selected_component"
local weapon_component = require "src.ecs.components.weapon.weapon_component"


--- @type CameraModule
local camera_otho = require "orthographic.camera"
local log = require("log.log")

local spawn_player_system = {
}

function spawn_player_system.init(world_id)
end

function spawn_player_system.update(world_id, dt)
    local entites = world_ecs.select_component(world_id, spawn_player_component.name)

    for index, value in ipairs(entites) do
        --- @type SpawnPlayerComponent
        local component_spawn = world_ecs.get_component(world_id, value, spawn_player_component.name)

        local entity = world_ecs.create_entity(world_id)
        local url_player_collection = factory_service.spawn_object_collection(factory_service.factory_name.player)
        local player_controller_url = url_player_collection[hash("/player_character")]
        local unit_controller = msg.url(nil, player_controller_url, "unit_controller")
        local srpite_url = go.get(unit_controller, "url_sprite")
        local url_aim = url_player_collection["/aim_circle"]
        local aim_controller = msg.url(nil, url_aim, "aim_controller")

        local unit_config = units_service.get_unit_config(component_spawn.type_unit)

        local component_unit = unit_controller_component.new(unit_controller, entity, component_spawn.position,
            unit_config)
        local component_sprite = sprite_component.new(srpite_url)
        local component_move_input = move_input_component.new()
        local component_move = move_component.new(50)
        local component_animation = animation_unit_component.new()
        local component_tag = character_tag_component.new_player_tag()
        local component_aim = aim_component.new(url_aim)
        local component_collision = collision_component.new()
        local component_aim_controller = aim_controller_component.new(aim_controller, entity)
        local component_aim_selected = aim_selected_component.new()
        local component_weapon = weapon_component.new()

        camera_otho.follow(camera_service.camera_id, player_controller_url,
            { lerp = 0.05 })
        camera_otho.deadzone(camera_service.camera_id, 50, 50, 50, 50)

        world_ecs.add_components(world_id, entity, component_unit, component_sprite, component_move, component_move_input,
            component_animation, component_tag, component_aim, component_collision, component_aim_controller,
            component_aim_selected, component_weapon)

        world_ecs.delete_entity(world_id, value)
    end
end

function spawn_player_system.fixed_update(world_id, dt)
end

function spawn_player_system.destroy(world_id)
end

return spawn_player_system
