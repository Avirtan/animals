local tilemap_service = require "src.services.map.tilemap_service"

local M = {}

local state = {
    map = {},
}

--- @param layer string|userdata
function M.set_map(layer)
    local urlTilemap = tilemap_service.get_tilemap()
    local _, _, map_width, map_height = tilemap.get_bounds(urlTilemap)
    local tile = 0
    for y = 1, map_height do
        for x = 1, map_width do
            tile = tilemap.get_tile(urlTilemap, layer, x, y)
            table.insert(state.map, tile)
        end
    end
    local direction = astar.DIRECTION_EIGHT
    local allocate = map_width * map_height
    local typical_adjacent = 8
    local cache = true
    local use_zero = false
    local flip_map = false
    astar.setup(map_width, map_height, direction, allocate, typical_adjacent, cache, use_zero, flip_map)
    astar.set_map(state.map)
end

function M.calculate_path(x1, y1, x2, y2)

end

function M.set_cost(costs)
    astar.set_costs(costs)
end

return M
