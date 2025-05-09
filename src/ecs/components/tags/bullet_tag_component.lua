--- @class CharacterTagComponent
local bullet_tag_component = {
    tag_bullet_name = "bullet_tag_component",
}

function bullet_tag_component.new_bullet_tag()
    local self = {}
    self.name = bullet_tag_component.tag_bullet_name
    return self
end

return bullet_tag_component
