local anim_service = require "src.services.characters.animation_service"
local events_service = require "src.services.events_service"

--- @class SpriteComponent1
--- @field url_sprite hash
--- @field current_animation userdata
local sprite_component_1 = {}

function sprite_component_1.new()
    local self = setmetatable({}, { __index = sprite_component_1 })
    self.url_sprite = nil
    self.current_animation = nil

    return self
end

function sprite_component_1:destroy()
end

--- @param unit CharacterModel
function sprite_component_1:update(dt, unit)
end

--- @param unit CharacterModel
function sprite_component_1:on_message(message_id, message, unit)
    if message_id == events_service.animation_events.set_sprite then
        self.url_sprite = message.url
    end

    if message_id == events_service.animation_events.change_animation_event then
        local animation = anim_service.get_move_animation(message)
        self:update_animation(animation)
    end
end

function sprite_component_1:update_animation(animation)
    if self.current_animation == animation then
        return
    end
    sprite.play_flipbook(self.url_sprite, animation)
    self.current_animation = animation
end

return sprite_component_1
