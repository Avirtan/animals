local world_ecs = require "src.ecs.world_ecs"
local aim_component = require "src.ecs.components.player.aim_component"
local move_component = require "src.ecs.components.move.move_component"

local log = require("log.log")

local aim_scaling_system = {
}

function aim_scaling_system.init(world_id)
end

function aim_scaling_system.update(world_id, dt)
    local entites = world_ecs.select_component(world_id, aim_component.name, move_component.name)

    for _, entity in ipairs(entites) do
        --- @type AimComponent
        local component_aim = world_ecs.get_component(world_id, entity, aim_component.name)
        --- @type MoveComponent
        local component_move = world_ecs.get_component(world_id, entity, move_component.name)

        if component_move.dir_move.x ~= 0 or component_move.dir_move.y ~= 0 then
            go.set(component_aim.url, "scale.x", 1)
            go.set(component_aim.url, "scale.y", 1)
        else
            go.set(component_aim.url, "scale.x", 0.5)
            go.set(component_aim.url, "scale.y", 0.5)
        end
    end
end

function aim_scaling_system.fixed_update(world_id, dt)
end

function aim_scaling_system.destroy(world_id)
end

return aim_scaling_system
