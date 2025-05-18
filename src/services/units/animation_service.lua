local units_service = require "src.services.resources.units_service"

local M = {
    animations = {
        solder = {
            idle = hash("idle"),
            up = hash("up"),
            down = hash("down"),
            right = hash("right"),
            left = hash("left")
        },
        tank = {
            idle = hash("tank")
        }
    }
}

local state = {

}

function M.get_character_move_animation()
    return state.character_move_animation
end

--- @param dir vector3
function M.get_move_animation(dir, type_unit)
    if type_unit == units_service.units_type.tank then
        return M.animations.tank.idle
    end

    local isXmore = math.abs(dir.x) > math.abs(dir.y)
    if dir.x > 0 and isXmore then
        return M.animations.solder.right
    elseif dir.x < 0 and isXmore then
        return M.animations.solder.left
    elseif dir.y > 0 then
        return M.animations.solder.up
    elseif dir.y < 0 then
        return M.animations.solder.down
    end
    return M.animations.solder.idle
end

return M
