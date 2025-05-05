local character_model = require "src.models.character.character_model"
local move_key_component = require "src.components.move.move_key_component"
local move_component = require "src.components.move.move_component"
local aim_circle_component = require "src.components.player.aim_circle_component"
local sprite_component = require "src.components.animation.sprite_component"
local components_service = require "src.services.components_service"

--- @class PlayerModel
--- @field model CharacterModel
local player_model = {
}

function player_model.new(url_player_collection)
    local self = setmetatable({}, { __index = player_model })

    local spawn_position = vmath.vector3(50, 50, 0)

    self.model = character_model.new({
        position = spawn_position,
        health = 100,
        speed = 50
    })
    local url_aim = url_player_collection["/aim_circle"]
    self.model:add_component(components_service.name.move, move_component.new(self.model))
    self.model:add_component(components_service.name.move_key, move_key_component.new(self.model))
    self.model:add_component(components_service.name.aim_circle, aim_circle_component.new(url_aim, self.model))
    self.model:add_component(components_service.name.sprite_animation, sprite_component.new())

    return self
end

function player_model:add_component(name, component)
    self.model:add_component(name, component)
end

function player_model:update(dt)
    self.model:update(dt)
end

function player_model:on_message(name_component, message_id, message)
    self.model:on_message(name_component, message_id, message)
end

function player_model:destroy()
    self.model:destroy()
end

function player_model:set_url_controller(url)
    self.model:set_url_controller(url)
end

return player_model
