local world_ecs                   = require "src.ecs.world_ecs"
local move_astar_component        = require "src.ecs.components.move.move_astar_component"
local target_component            = require "src.ecs.components.targets.target_component"
local screen_service              = require "src.services.screen_service"
local unit_controller_component   = require "src.ecs.components.units.unit_controller_component"
local astar_service               = require "src.services.levels.astar_service"

local log                         = require("log.log")

local astar_calculate_path_system = {
}

function astar_calculate_path_system.init(world_id)
end

function astar_calculate_path_system.update(world_id, dt)
    local entites = world_ecs.select_component(world_id, move_astar_component.name, target_component.name)

    for _, entity in ipairs(entites) do
        --- @type MoveAstarComponent
        local component_astar = world_ecs.get_component(world_id, entity, move_astar_component.name)
        --- @type TargetComponent
        local component_target = world_ecs.get_component(world_id, entity, target_component.name)
        --- @type UnitControllerComponent
        local component_controller = world_ecs.get_component(world_id, entity, unit_controller_component.name)
        if component_astar.delay_update <= 0 then
            astar_calculate_path_system.calculate_path(component_target, component_astar, component_controller)
            component_astar.delay_update = astar_service.delay_update
        end
        component_astar.delay_update = component_astar.delay_update - dt
    end
end

function astar_calculate_path_system.fixed_update(world_id, dt)
end

function astar_calculate_path_system.destroy(world_id)
end

---comment
---@param component_target TargetComponent
---@param component_astar MoveAstarComponent
---@param component_controller UnitControllerComponent
function astar_calculate_path_system.calculate_path(component_target, component_astar, component_controller)
    if component_target.target == nil then
        return
    end
    local position_target = go.get_position(component_target.target)
    if component_astar.target_position.x == position_target.x and component_astar.target_position.y == position_target.y then
        -- print("цель не двигается")
        return
    end
    component_astar.target_position = position_target
    local position = go.get_position(component_controller.url)
    local tileXStart, tileYStart = screen_service.world_to_tile(position.x, position.y)
    local tileXEnd, tileYEnd = screen_service.world_to_tile(position_target.x, position_target.y)
    local status, size, total_cost, path = astar.solve(tileXStart, tileYStart, tileXEnd, tileYEnd)
    if status == astar.SOLVED then
        for index, _ in ipairs(component_astar.paths) do
            component_astar.paths[index] = nil
        end
        for index, tile in ipairs(path) do
            local x, y                   = screen_service.tile_to_world(tile.x, tile.y);
            component_astar.paths[index] = { x, y }
        end
        astar_service.show_points_debug(component_controller.url, path)
        component_astar.current_index_point = 2
        component_astar.next_point.x = 0
        component_astar.next_point.y = 0
    end
end

return astar_calculate_path_system
