local world_ecs = require "src.ecs.world_ecs"
local unit_controller_component = require "src.ecs.components.units.unit_controller_component"
local target_component = require "src.ecs.components.targets.target_component"
local character_tag_component = require "src.ecs.components.tags.character_tag_component"

local log = require("log.log")

local select_target_player_system = {
}

function select_target_player_system.init(world_id)
end

function select_target_player_system.update(world_id, dt)
    local entites_player = world_ecs.select_component(world_id, character_tag_component.tag_player_name)

    local player_target = nil
    for _, entity in ipairs(entites_player) do
        --- @type UnitControllerComponent
        local component_controller = world_ecs.get_component(world_id, entity, unit_controller_component.name)
        player_target = component_controller.url
    end
    if player_target == nil then
        return
    end
    local entites = world_ecs.select_component(world_id, character_tag_component.tag_enemy_name, target_component.name)


    for _, entity in ipairs(entites) do
        --- @type TargetComponent
        local component_target = world_ecs.get_component(world_id, entity, target_component.name)
        component_target.target = player_target
    end
end

function select_target_player_system.fixed_update(world_id, dt)
end

function select_target_player_system.destroy(world_id)
end

return select_target_player_system
