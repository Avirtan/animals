local world_ecs = require "src.ecs.world_ecs"
local change_health_component = require "src.ecs.components.events.unit_state.change_health_component"
local state_unit_component = require "src.ecs.components.units.state_unit_component"
local unit_controller_component = require "src.ecs.components.units.unit_controller_component"
local sprite_component = require "src.ecs.components.animation.sprite_component"

local log = require("log.log")

local change_health_system = {
}

function change_health_system.init(world_id)
end

function change_health_system.update(world_id, dt)
    local entites = world_ecs.select_component(world_id, state_unit_component.name, unit_controller_component.name)

    for index, entity in ipairs(entites) do
        change_health_system.update_health(world_id, entity)
    end
end

function change_health_system.update_health(world_id, entity)
    --- @type StateUnitComponent
    local component_state_unit = world_ecs.get_component(world_id, entity, state_unit_component.name)
    --- @type UnitControllerComponent
    local component_controller = world_ecs.get_component(world_id, entity, unit_controller_component.name)
    --- @type SpriteComponent
    local component_sprite = world_ecs.get_component(world_id, entity, sprite_component.name)
    if component_state_unit.health == component_state_unit.last_health then
        return
    end
    local health_url = go.get(component_controller.url_controller, "url_health")
    local text_health = component_state_unit.health .. " hp"
    if component_state_unit.health == 0 then
        text_health = "dead"
    end
    local value_shader = component_state_unit.health / 100 * 16 - 8;
    go.set(component_sprite.url, "colored_percent", -value_shader)
    label.set_text(health_url, text_health)
end

function change_health_system.fixed_update(world_id, dt)
end

function change_health_system.destroy(world_id)
end

return change_health_system
