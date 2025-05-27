local projection_utils = require "src.render.projection_utils"

local M = {
}

--- @class RenderState
local state = {
    window_width = 0,
    window_height = 0,
    width = 0,
    height = 0,
    prev_window_width = -1,
    prev_window_height = -1,
    color = vmath.vector4(0, 0, 0, 0),
    clear_buffers = {
        [graphics.BUFFER_TYPE_COLOR0_BIT] = nil,
        [graphics.BUFFER_TYPE_DEPTH_BIT] = 1,
        [graphics.BUFFER_TYPE_STENCIL_BIT] = 0
    },
    cameras = {
        camera_gui = {
            view = vmath.matrix4(),
            near = projection_utils.DEFAULT_NEAR,
            far = projection_utils.DEFAULT_FAR,
            zoom = projection_utils.DEFAULT_ZOOM,
            projection_fn = projection_utils.get_gui_projection,
            options = {}
        },
        camera_world = nil
    },
    -- predicates = {
    --     sprite_character = render.predicate({ "sprite_character" }),
    --     tile = render.predicate({ "tile" }),
    --     gui = render.predicate({ "gui" }),
    --     particle = render.predicate({ "particle" }),
    --     model = render.predicate({ "model" }),
    --     debug_text = render.predicate({ "debug_text" }),
    -- }
}

function M.init_state()
    local color = state.color
    color.x = sys.get_config_number("render.clear_color_red", 0)
    color.y = sys.get_config_number("render.clear_color_green", 0)
    color.z = sys.get_config_number("render.clear_color_blue", 0)
    color.w = sys.get_config_number("render.clear_color_alpha", 0)
    state.clear_buffers[graphics.BUFFER_TYPE_COLOR0_BIT] = color
    return state
end

function M.update_state()
    state.window_width = render.get_window_width()
    state.window_height = render.get_window_height()
    if state.window_width == state.prev_window_width and state.window_height == state.prev_window_height then
        return
    end
    state.prev_window_width = state.window_width
    state.prev_window_height = state.window_height
    state.width = render.get_width()
    state.height = render.get_height()
    local camera_gui = state.cameras.camera_gui
    camera_gui.proj = camera_gui.projection_fn(camera_gui, state)
    camera_gui.frustum = camera_gui.proj * camera_gui.view
end

function M.get_world_camera()
    local cameras = camera.get_cameras()
    if #cameras > 0 then
        for i = #cameras, 1, -1 do
            if camera.get_enabled(cameras[i]) then
                state.cameras.camera_world = cameras[i]
                return state.cameras.camera_world
            end
        end
    end
end

function M.enable_world_camera()
    local world_camera = state.cameras.camera_world
    if world_camera == nil or not camera.get_enabled(world_camera) then
        world_camera = M.get_world_camera()
        if world_camera == nil then
            return
        end
    end
    render.set_camera(world_camera, { use_frustum = true })
    return {}
end

function M.enable_gui_camera()
    render.set_camera()
    local camera_gui = state.cameras.camera_gui
    render.set_view(camera_gui.view)
    render.set_projection(camera_gui.proj)
    return camera_gui
end

function M.get_state()
    return state
end

function M.set_color_clear(color)
    state.clear_buffers[graphics.BUFFER_TYPE_COLOR0_BIT] = color
end

return M
