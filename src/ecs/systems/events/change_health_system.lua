local world_ecs = require "src.ecs.world_ecs"
local change_health_component = require "src.ecs.components.events.unit_state.change_health_component"
local state_unit_component = require "src.ecs.components.units.state_unit_component"
local unit_controller_component = require "src.ecs.components.units.unit_controller_component"

local log = require("log.log")

local change_health_system = {
}

function change_health_system.init(world_id)
end

function change_health_system.update(world_id, dt)
    local entites = world_ecs.select_component(world_id, change_health_component.name)

    for index, entity in ipairs(entites) do
        --- @type ChangeHealthComponent
        local component_change_health = world_ecs.get_component(world_id, entity, change_health_component.name)
        --- @type StateUnitComponent
        local component_state_unit = world_ecs.get_component(world_id, component_change_health.entity,
            state_unit_component.name)
        --- @type UnitControllerComponent
        local component_controller = world_ecs.get_component(world_id, component_change_health.entity,
            unit_controller_component.name)
        component_state_unit.health = component_state_unit.health - component_change_health.value
        local health_url = go.get(component_controller.url, "url_health")
        label.set_text(health_url, component_state_unit.health .. " hp")


        world_ecs.delete_entity(world_id, entity)
    end
end

function change_health_system.fixed_update(world_id, dt)
end

function change_health_system.destroy(world_id)
end

return change_health_system
