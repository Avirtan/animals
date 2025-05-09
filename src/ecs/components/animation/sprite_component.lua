--- @class SpriteComponent
--- @field url hash
local sprite_component = {
    name = "sprite_component"
}

function sprite_component.new(url)
    local self = {} ----setmetatable({}, { __index = sprite_component })
    self.name = sprite_component.name
    self.url = url
    return self
end

return sprite_component
