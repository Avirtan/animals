local bullet_model        = require "src.models.bullet.bullet_model"
local move_component      = require "src.components.move.move_component"
local components_service  = require "src.services.components_service"

--- @class BulletSimpleModel
--- @field base_model BulletModel
local bullet_simple_model = {}

function bullet_simple_model.new()
    local self = setmetatable({}, { __index = bullet_simple_model })
    self.base_model = bullet_model.new({
        damage = 100,
        speed = 50,
    })
    self.base_model:add_component(components_service.name.move, move_component.new(self.base_model))
    return self
end

function bullet_simple_model:add_component(name, component)
    self.base_model:add_component(name, component)
end

function bullet_simple_model:update(dt)
    self.base_model:update(dt)
end

function bullet_simple_model:on_message(name_component, message_id, message)
    self.base_model:on_message(name_component, message_id, message)
end

function bullet_simple_model:destroy()
    self.base_model:destroy()
end

function bullet_simple_model:set_url_controller(url)
    self.base_model:set_url_controller(url)
end

return bullet_simple_model
