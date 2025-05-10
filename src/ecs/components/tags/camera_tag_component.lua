--- @class CameraTagComponent
local camera_tag_component = {
    tag_camera_name = "camera_tag_component",
}

function camera_tag_component.new_camera_tag()
    local self = {}
    self.name = camera_tag_component.tag_camera_name
    return self
end

return camera_tag_component
