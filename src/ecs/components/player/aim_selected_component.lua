--- @class AimSelectedComponent
--- @field targets table
local aim_selected_component = {
    name = "aim_selected_component"
}

function aim_selected_component.new()
    local self = {}
    self.name = aim_selected_component.name
    self.targets = {}
    return self
end

return aim_selected_component
