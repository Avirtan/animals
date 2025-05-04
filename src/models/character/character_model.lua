--- @class CharacterModel
local character_model = {}

--- @param data CharacterModelData
function character_model.new(data)
    self = setmetatable({}, { __index = character_model })
    self.health = data.health or 100
    self.speed = data.speed or 50
    self.weapon = data.weapon
    self.position = data.position or vmath.vector3(0, 0, 0)
    self.components = {}
    self.controller_url = data.controller_url
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
end

function character_model:on_message(name_component, message_id, message)
    local comp = self.components[name_component]
    if comp == nil then
        return
    end
    comp:on_message(message_id, message, self)
end

function character_model:destroy(dt)
    for _, component in pairs(self.components) do
        component:destroy()
    end
end

return character_model
