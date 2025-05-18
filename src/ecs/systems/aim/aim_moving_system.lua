local world_ecs = require "src.ecs.world_ecs"
local aim_component = require "src.ecs.components.player.aim_component"
local input_service = require "src.services.input_service"
local screen_service = require "src.services.screen_service"
local unit_controller_component = require "src.ecs.components.units.unit_controller_component"
local aim_service = require "src.services.units.aim_service"
local move_component = require "src.ecs.components.move.move_component"
local camera_service = require "src.services.camera_service"

local log = require("log.log")

local aim_moving_system = {
}

function aim_moving_system.init(world_id)
end

function aim_moving_system.update(world_id, dt)
    local entites = world_ecs.select_component(world_id, aim_component.name, unit_controller_component.name,
        move_component.name)

    for _, entity in ipairs(entites) do
        --- @type AimComponent
        local component_aim = world_ecs.get_component(world_id, entity, aim_component.name)
        --- @type UnitControllerComponent
        local component_unit = world_ecs.get_component(world_id, entity, unit_controller_component.name)
        --- @type MoveComponent
        local component_move = world_ecs.get_component(world_id, entity, move_component.name)

        local angle = component_aim.angle_stand
        if component_move.dir_move.x ~= 0 or component_move.dir_move.y ~= 0 then
            angle = component_aim.angle_move
        end
        component_aim.angle = angle
        local touch_position = input_service.current_inputs.touch_input

        -- if touch_position.x == component_aim.last_position.x and touch_position.y == component_aim.last_position.y then
        --     break
        -- end
        local position_world = camera_service.screen_to_world(touch_position)
        local x, y = position_world.x, position_world.y
        local position_player = go.get_position(component_unit.url)
        component_aim.tmp_vector.x = x
        component_aim.tmp_vector.y = y
        local local_position = component_aim.tmp_vector - position_player

        aim_service.draw_cone(position_player, local_position, angle, 100)
        component_aim.current_dir = local_position
        local len = vmath.length_sqr(local_position)
        if len > 10000 then
            local_position = vmath.normalize(local_position) * 100
        end
        go.set_position(local_position, component_aim.url)
        component_aim.last_position.x = touch_position.x
        component_aim.last_position.y = touch_position.y
    end
end

function aim_moving_system.fixed_update(world_id, dt)
end

function aim_moving_system.destroy(world_id)
end

return aim_moving_system
