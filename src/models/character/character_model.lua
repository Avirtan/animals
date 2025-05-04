--- @class CharacterModel
local character_model = {}

--- @param data CharacterModelData
function character_model.new(data)
    local self = setmetatable({}, { __index = character_model })
    self.health = data.health or 100
    self.speed = data.speed or 50
    self.position = data.position or vmath.vector3(0, 0, 0)
    self.components = {}
    self.controller_url = data.controller_url or nil
    self.is_moving = false
    return self
end

function character_model:add_component(name, component)
    self.components[name] = component
end

function character_model:update(dt)
    for _, component in pairs(self.components) do
        component:update(dt, self)
    end
    if self.is_moving then
        go.set_position(self.position, self.controller_url)
    end
end

function character_model:on_message(name_component, message_id, message)
    local comp = self.components[name_component]
    if comp == nil then
        return
    end
    comp:on_message(message_id, message, self)
end

function character_model:destroy()
    for _, component in pairs(self.components) do
        component:destroy()
    end
end

function character_model:set_url_controller(url)
    self.controller_url = url
    go.set_position(self.position, self.controller_url)
end

return character_model
