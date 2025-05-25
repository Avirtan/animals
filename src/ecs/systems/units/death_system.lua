local world_ecs = require "src.ecs.world_ecs"
local state_unit_component = require "src.ecs.components.units.state_unit_component"
local unit_controller_component = require "src.ecs.components.units.unit_controller_component"
local units_service = require "src.services.units.units_service"

local log = require("log.log")

local death_system = {
}

function death_system.init(world_id)
end

function death_system.update(world_id, dt)
    local entites = world_ecs.select_component(world_id, state_unit_component.name)

    for index, entity in ipairs(entites) do
        death_system.unit_dead(world_id, entity)
    end
end

function death_system.unit_dead(world_id, entity)
    --- @type StateUnitComponent
    local component_state_unit = world_ecs.get_component(world_id, entity, state_unit_component.name)
    --- @type UnitControllerComponent
    local component_controller = world_ecs.get_component(world_id, entity, unit_controller_component.name)

    if component_state_unit.health > 0 then
        return
    end
    units_service.units_alive[component_controller.url] = nil
    world_ecs.delete_entity(world_id, entity)
    go.delete(component_controller.url)
end

function death_system.fixed_update(world_id, dt)
end

function death_system.destroy(world_id)
end

return death_system
