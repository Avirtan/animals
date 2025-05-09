--- @class CameraFollowComponent
--- @field url hash
--- @field target url
--- @field target_pos vector3
--- @field camera_pos vector3
--- @field lerp_factor number
local camera_follow_component = {
    name = "camera_follow_component"
}

function camera_follow_component.new(url)
    local self = setmetatable({}, { __index = camera_follow_component })
    self.url = url
    self.target = nil
    self.lerp_factor = 0.05
    self.target_pos = vmath.vector3()
    self.camera_pos = vmath.vector3(0, 0, 10)
    return self
end

return camera_follow_component
