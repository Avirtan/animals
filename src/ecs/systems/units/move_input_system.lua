local world_ecs = require "src.ecs.world_ecs"
local move_input_component = require "src.ecs.components.move.move_input_component"
local input_service = require "src.services.input_service"
local unit_controller_component = require "src.ecs.components.units.unit_controller_component"
local move_component = require "src.ecs.components.move.move_component"

local log = require("log.log")

local move_input_system = {
}

function move_input_system.init(world_id)
end

function move_input_system.update(world_id, dt)
    local entites = world_ecs.select_component(world_id, move_input_component.name, unit_controller_component.name,
        move_component.name)

    for _, entity in ipairs(entites) do
        --- @type MoveComponent
        local component_move = world_ecs.get_component(world_id, entity, move_component.name)
        --- @type UnitControllerComponent
        local component_unit = world_ecs.get_component(world_id, entity, unit_controller_component.name)

        local dir_move = input_service.current_inputs.move_input
        if dir_move.x ~= 0 and dir_move.y ~= 0 then
            dir_move = vmath.normalize(dir_move)
        end
        component_unit.position = component_unit.position + dir_move * component_move.speed * dt
        component_move.dir_move = dir_move
        go.set_position(component_unit.position, component_unit.url)
    end
end

function move_input_system.fixed_update(world_id, dt)
end

function move_input_system.destroy(world_id)
end

return move_input_system
