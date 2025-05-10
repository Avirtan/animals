local M = {}

local state = {

}

function M.bullet_dir_move(direction, spread_angle)
    local dir = vmath.normalize(direction)

    local random_angle = math.random() * spread_angle - (spread_angle / 2)
    local angle_rad = math.rad(random_angle)

    local rot = vmath.quat_rotation_z(angle_rad)
    local spread_dir = vmath.rotate(rot, dir)

    return spread_dir
end

return M
