local world_ecs = require "src.ecs.world_ecs"
local unit_controller_component = require "src.ecs.components.units.unit_controller_component"
local move_component = require "src.ecs.components.move.move_component"
local move_astar_component = require "src.ecs.components.move.move_astar_component"
local character_tag_component = require "src.ecs.components.tags.character_tag_component"

local log = require("log.log")

local move_astar_system = {
}

function move_astar_system.init(world_id)
end

function move_astar_system.update(world_id, dt)
    local entites = world_ecs.select_component(world_id, character_tag_component.tag_enemy_name,
        move_astar_component.name, move_component.name, unit_controller_component.name)

    for _, entity in ipairs(entites) do
        --- @type MoveComponent
        local component_move = world_ecs.get_component(world_id, entity, move_component.name)
        --- @type UnitControllerComponent
        local component_unit = world_ecs.get_component(world_id, entity, unit_controller_component.name)
        --- @type MoveAstarComponent
        local component_astar = world_ecs.get_component(world_id, entity, move_astar_component.name)

        if component_astar.next_point.x ~= 0 and component_astar.next_point.y ~= 0 then
            local distance = vmath.length(go.get_position(component_unit.url) - component_astar.next_point)
            if distance < 1 then
                component_astar.next_point.x = 0
                component_astar.next_point.y = 0
                component_move.dir_move.x = 0
                component_move.dir_move.y = 0
                component_astar.current_index_point = component_astar.current_index_point + 1
            end
        end

        if component_astar.current_index_point <= #component_astar.paths and component_astar.next_point.x == 0 and component_astar.next_point.y == 0 then
            component_astar.next_point.x = component_astar.paths[component_astar.current_index_point][1]
            component_astar.next_point.y = component_astar.paths[component_astar.current_index_point][2]
            component_move.dir_move = vmath.normalize(component_astar.next_point -
                go.get_position(component_unit.url));
        end



        component_unit.position = component_unit.position + component_move.dir_move * component_move.speed * dt
        component_move.dir_move = component_move.dir_move
        go.set_position(component_unit.position, component_unit.url)
    end
end

function move_astar_system.fixed_update(world_id, dt)
end

function move_astar_system.destroy(world_id)
end

return move_astar_system
