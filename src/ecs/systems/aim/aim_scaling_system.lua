local world_ecs = require "src.ecs.world_ecs"
local aim_component = require "src.ecs.components.player.aim_component"
local move_component = require "src.ecs.components.move.move_component"
local weapon_component = require "src.ecs.components.weapon.weapon_component"

local log = require("log.log")

local aim_scaling_system = {
}

function aim_scaling_system.init(world_id)
end

function aim_scaling_system.update(world_id, dt)
    local entites = world_ecs.select_component(world_id, aim_component.name, move_component.name, weapon_component.name)

    for _, entity in ipairs(entites) do
        --- @type AimComponent
        local component_aim = world_ecs.get_component(world_id, entity, aim_component.name)
        --- @type MoveComponent
        local component_move = world_ecs.get_component(world_id, entity, move_component.name)
        --- @type WeaponComponent
        local component_weapon = world_ecs.get_component(world_id, entity, weapon_component.name)
        if component_weapon.cached_data == nil then
            return
        end
        local data_weapon = component_weapon.cached_data
        local scale = 0
        if component_move.is_moving then
            scale = data_weapon.move_angle
        else
            scale = data_weapon.angle
        end
        scale = scale * 0.2

        if scale ~= component_aim.current_scale or component_aim.is_update_distance then
            component_aim.current_scale = scale
            local normalized_value = 1
            if component_aim.distance ~= nil then
                local max_range_sqr = data_weapon.range * data_weapon.range
                normalized_value = math.min(1, component_aim.distance / max_range_sqr)
                if normalized_value < 0.3 then
                    normalized_value = 0.3
                end
            end
            go.set(component_aim.url, "scale.x", scale * normalized_value)
            go.set(component_aim.url, "scale.y", scale * normalized_value)
            component_aim.is_update_distance = false
        end
    end
end

function aim_scaling_system.fixed_update(world_id, dt)
end

function aim_scaling_system.destroy(world_id)
end

return aim_scaling_system
