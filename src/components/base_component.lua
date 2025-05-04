--- @class BaseComponent
local base_component = {}

function base_component.new()
    self = setmetatable({}, { __index = base_component })
    return self
end

function base_component:destroy()
end

--- @param unit CharacterModel
function base_component:update(dt, unit)
end

--- @param unit CharacterModel
function base_component:on_message(message_id, message, unit)
end

return base_component
