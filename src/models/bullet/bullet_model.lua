--- @class BulletModel
local bullet_model = {}

--- @param data BulletModelData
function bullet_model.new(data)
    local self = setmetatable({}, { __index = bullet_model })
    self.damage = data.damage or 100
    self.speed = data.speed or 50
    self.position = data.position or vmath.vector3(0, 0, 0)
    self.components = {}
    self.controller_url = data.controller_url or nil
    self.dir_move = vmath.vector3()
    self.is_moving = false
    return self
end

function bullet_model:add_component(name, component)
    self.components[name] = component
end

function bullet_model:update(dt)
    for _, component in pairs(self.components) do
        component:update(dt)
    end
end

function bullet_model:on_message(name_component, message_id, message)
    local comp = self.components[name_component]
    if comp == nil then
        return
    end
    comp:on_message(message_id, message)
end

function bullet_model:destroy()
    for _, component in pairs(self.components) do
        component:destroy()
    end
end

function bullet_model:set_url_controller(url)
    self.controller_url = url
    go.set_position(self.position, self.controller_url)
end

return bullet_model
