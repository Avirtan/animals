--- @class AimComponent
--- @field url hash
--- @field last_position vector3
--- @field tmp_vector vector3
--- @field current_dir vector3
--- @field angle number
--- @field angle_stand number
--- @field angle_move number
local aim_component = {
    name = "aim_component"
}

function aim_component.new(url)
    local self = setmetatable({}, { __index = aim_component })
    self.url = url
    self.last_position = vmath.vector3(0, 0, 0)
    self.tmp_vector = vmath.vector3(0, 0, 0)
    self.current_dir = vmath.vector3(0, 0, 0)
    return self
end

return aim_component
