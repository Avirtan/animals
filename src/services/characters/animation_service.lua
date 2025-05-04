local M = {
    character_move_animation = {
        idle = hash("idle"),
        up = hash("up"),
        down = hash("down"),
        right = hash("right"),
        left = hash("left")
    }
}

local state = {

}

function M.get_character_move_animation()
    return state.character_move_animation
end

--- @param dir vector3
function M.get_move_animation(dir)
    local isXmore = math.abs(dir.x) > math.abs(dir.y)
    if dir.x > 0 and isXmore then
        return M.character_move_animation.right
    elseif dir.x < 0 and isXmore then
        return M.character_move_animation.left
    elseif dir.y > 0 then
        return M.character_move_animation.up
    elseif dir.y < 0 then
        return M.character_move_animation.down
    end
    return M.character_move_animation.idle
end

return M
