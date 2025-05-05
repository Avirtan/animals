local character_model         = require "src.models.character.character_model"
local move_component          = require "src.components.move.move_component"
local move_astar_component    = require "src.components.move.move_astar_component"
local sprite_component        = require "src.components.animation.sprite_component"
local components_service      = require "src.services.components_service"
local target_player_component = require "src.components.target_select.target_player_component"

--- @class EnemyModel
--- @field base_model CharacterModel
--- @field target hash
local enemy_model             = {
}

--- comment
--- @param unit_manager UnitManager
function enemy_model.new(unit_manager)
    local self = setmetatable({}, { __index = enemy_model })

    self.base_model = character_model.new({
        health = 100,
        speed = 50
    })
    self.target = nil

    self.base_model:add_component(components_service.name.move, move_component.new(self.base_model))
    self.base_model:add_component(components_service.name.select_target.player,
        target_player_component.new(self, unit_manager))
    self.base_model:add_component(components_service.name.move_astar, move_astar_component.new(self))
    self.base_model:add_component(components_service.name.sprite_animation, sprite_component.new())

    return self
end

function enemy_model:add_component(name, component)
    self.base_model:add_component(name, component)
end

function enemy_model:update(dt)
    self.base_model:update(dt)
end

function enemy_model:on_message(name_component, message_id, message)
    self.base_model:on_message(name_component, message_id, message)
end

function enemy_model:destroy()
    self.base_model:destroy()
end

function enemy_model:set_url_controller(url)
    self.base_model:set_url_controller(url)
end

return enemy_model
