--- @class CharacterTagComponent
--- @field position vector3
local character_tag_component = {
    tag_player_name = "player_tag_component",
    tag_enemy_name = "enemy_tag_component"
}

function character_tag_component.new_player_tag()
    local self = setmetatable({}, { __index = character_tag_component })
    self.name = character_tag_component.tag_player_name
    return self
end

function character_tag_component.new_enemy_tag()
    local self = setmetatable({}, { __index = character_tag_component })
    self.name = character_tag_component.tag_enemy_name
    return self
end

return character_tag_component
