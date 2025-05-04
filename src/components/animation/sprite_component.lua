local anim_service = require "src.services.characters.animation_service"
local events_service = require "src.services.events_service"

--- @class SpriteComponent
--- @field url_sprite hash
--- @field current_animation userdata
local sprite_component = {}

function sprite_component.new()
    self = setmetatable({}, { __index = sprite_component })
    self.url_sprite = nil
    self.current_animation = nil

    return self
end

function sprite_component:destroy()
end

--- @param unit CharacterModel
function sprite_component:update(dt, unit)
end

--- @param unit CharacterModel
function sprite_component:on_message(message_id, message, unit)
    if message_id == events_service.animation_events.set_sprite then
        self.url_sprite = message.url
    end

    if message_id == events_service.animation_events.change_animation_event then
        local animation = anim_service.get_move_animation(message)
        self:update_animation(animation)
    end
end

function sprite_component:update_animation(animation)
    if self.current_animation == animation then
        return
    end
    sprite.play_flipbook(self.url_sprite, animation)
    self.current_animation = animation
end

return sprite_component
