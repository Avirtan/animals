local world_ecs = require "src.ecs.world_ecs"
local aim_component = require "src.ecs.components.player.aim_component"
local input_service = require "src.services.input_service"
local weapons_service = require "src.services.weapon.weapons_service"
local unit_controller_component = require "src.ecs.components.units.unit_controller_component"
local aim_service = require "src.services.units.aim_service"
local move_component = require "src.ecs.components.move.move_component"
local camera_service = require "src.services.camera_service"
local weapon_component = require "src.ecs.components.weapon.weapon_component"

local log = require("log.log")

local aim_moving_system = {
}

function aim_moving_system.init(world_id)
end

function aim_moving_system.update(world_id, dt)
    local entites = world_ecs.select_component(world_id, aim_component.name, unit_controller_component.name,
        move_component.name, weapon_component.name)

    for _, entity in ipairs(entites) do
        --- @type AimComponent
        local component_aim = world_ecs.get_component(world_id, entity, aim_component.name)
        --- @type UnitControllerComponent
        local component_unit = world_ecs.get_component(world_id, entity, unit_controller_component.name)
        --- @type MoveComponent
        local component_move = world_ecs.get_component(world_id, entity, move_component.name)
        --- @type WeaponComponent
        local component_weapon = world_ecs.get_component(world_id, entity, weapon_component.name)

        if component_weapon.weapon_id == nil then
            return
        end

        local data_weapon = component_weapon.config_data
        local angle = data_weapon.angle
        if component_move.is_moving then
            angle = data_weapon.move_angle
        end
        component_aim.angle = angle
        local position_player = go.get_position(component_unit.url)
        local local_position
        local touch_position = input_service.current_inputs.touch_input
        if not input_service.is_multitouch then
            -- if touch_position.x == component_aim.last_position.x and touch_position.y == component_aim.last_position.y then
            --     break
            -- end
            local position_world = camera_service.screen_to_world(touch_position)
            local x, y = position_world.x, position_world.y
            component_aim.tmp_vector.x = x
            component_aim.tmp_vector.y = y
            local_position = component_aim.tmp_vector - position_player
        else
            local_position = go.get_position(component_aim.url)
            local_position.x = local_position.x + touch_position.x * 1.5
            local_position.y = local_position.y + touch_position.y * 1.5
        end

        aim_service.draw_cone(position_player, local_position, angle, data_weapon.range)
        component_aim.current_dir = local_position
        local len = vmath.length(local_position)

        local max_range_sqr = data_weapon.range

        if len ~= component_aim.distance and len <= max_range_sqr then
            component_aim.distance = len
            component_aim.is_update_distance = true
        end

        if len > max_range_sqr then
            local_position = vmath.normalize(local_position) * data_weapon.range
            component_aim.distance = len
            component_aim.is_update_distance = true
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
