local camera_service = require "src.services.camera_service"
local tilemap_service = require "src.services.levels.tilemap_service"

local M = {}

local state = {
    DISPLAY_WIDTH = sys.get_config_int("display.width"),
    DISPLAY_HEIGHT = sys.get_config_int("display.height")
}

--- @param x number
--- @param y number
function M.screen_to_world(x, y)
    local w, h = window.get_size()

    w = w / (w / state.DISPLAY_WIDTH)
    h = h / (h / state.DISPLAY_HEIGHT)

    local inv = camera_service.get_inv()

    x = (2 * x / w) - 1
    y = (2 * y / h) - 1
    local x1 = x * inv.m00 + y * inv.m01 + inv.m03
    local y1 = x * inv.m10 + y * inv.m11 + inv.m13
    return x1, y1
end

--- @param x number
--- @param y number
function M.world_to_tile(x, y)
    local tile_width = tilemap_service.get_tilemap_size()
    local tile_height = tilemap_service.get_tilemap_size()
    local tilemap_pos = go.get_world_position(tilemap_service.get_tilemap())

    local offset_x = x - tilemap_pos.x
    local offset_y = y - tilemap_pos.y

    local tile_x = math.floor(offset_x / tile_width)
    local tile_y = math.floor(offset_y / tile_height)

    return tile_x + 1, tile_y + 1
end

function M.tile_to_world(x, y)
    local tileSize = tilemap_service.get_tilemap_size()
    local scrx = tileSize * (x - 1) + tileSize / 2
    local scry = tileSize * (y - 1) + tileSize / 2
    return scrx, scry;
end

return M
