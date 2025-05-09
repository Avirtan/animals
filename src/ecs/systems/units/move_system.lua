local world_ecs = require "src.ecs.world_ecs"
local input_service = require "src.services.input_service"
local unit_controller_component = require "src.ecs.components.units.unit_controller_component"
local move_component = require "src.ecs.components.move.move_component"
local character_tag_component = require "src.ecs.components.tags.character_tag_component"

local log = require("log.log")

local move_system = {
}

function move_system.init(world_id)
end

function move_system.update(world_id, dt)
    local entites = world_ecs.select_component(world_id, character_tag_component.tag_enemy_name,
        unit_controller_component.name, move_component.name)

    for _, entity in ipairs(entites) do
        --- @type MoveComponent
        local component_move = world_ecs.get_component(world_id, entity, move_component.name)
        --- @type UnitControllerComponent
        local component_unit = world_ecs.get_component(world_id, entity, unit_controller_component.name)
        go.set_position(component_unit.position, component_unit.url)
    end
end

function move_system.fixed_update(world_id, dt)
end

function move_system.destroy(world_id)
end

return move_system
