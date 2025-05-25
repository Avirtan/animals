local world_ecs = require "src.ecs.world_ecs"
local unit_controller_component = require "src.ecs.components.units.unit_controller_component"
local sprite_component = require "src.ecs.components.animation.sprite_component"
local move_component = require "src.ecs.components.move.move_component"
local animation_unit_component = require "src.ecs.components.animation.animation_unit_component"
local state_unit_component = require "src.ecs.components.units.state_unit_component"
local units_service = require "src.services.units.units_service"

local M = {}
local log = require("log.log")

--- @param world_id number
--- @param position_spawn vector3
--- @param unit_config UnitDataConfig
--- @param url_unit userdata
--- @param speed number
--- @param health number
function M.create_unit_entity(world_id, position_spawn, unit_config, url_unit, speed, health)
    local entity = world_ecs.create_entity(world_id)
    local unit_controller = msg.url(nil, url_unit, "unit_controller")
    local sprite_url = go.get(unit_controller, "url_sprite")

    local component_unit = unit_controller_component.new(url_unit, unit_controller, entity, position_spawn,
        unit_config)
    local component_sprite = sprite_component.new(sprite_url)
    local component_move = move_component.new(speed)
    local component_animation = animation_unit_component.new()
    local component_state_unit = state_unit_component.new(health)
    world_ecs.add_components(world_id, entity, component_unit, component_sprite, component_move,
        component_animation, component_state_unit)
    units_service.units_alive[url_unit] = true
    return entity
end

return M
